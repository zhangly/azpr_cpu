;;; 程序加载器
;;; 1、编译  azprasm loader.asm -o loader.bin --coe loader.coe
;;; 2、手工将Xilinx FPGA的coe文件转换为Altera FPGA的mif格式作为ROM初始化数据文件 loader16.mif
;;; 3、开发板综合时，将loader16.mif作为ROM的初始化数据文件

;;; 符号定义
UART_BASE_ADDR_H	EQU		0x6000		;UART Base Address High
UART_STATUS_OFFSET	EQU		0x0			;UART Status Register Offset
UART_DATA_OFFSET	EQU		0x4			;UART Data Register Offset
UART_RX_INTR_MASK	EQU		0x1			;UART Receive Interrupt
UART_TX_INTR_MASK	EQU		0x2			;UART Receive Interrupt

GPIO_BASE_ADDR_H	EQU		0x8000		;GPIO Base Address High
GPIO_IN_OFFSET		EQU		0x0			;GPIO Input Port Register Offset
GPIO_OUT_OFFSET		EQU		0x4			;GPIO Output Port Register Offset

SPM_BASE_ADDR_H		EQU		0x2000		;SPM Base Address High

XMODEM_SOH			EQU		0x1			;Start Of Heading
XMODEM_EOT			EQU		0x4			;End Of Transmission
XMODEM_ACK			EQU		0x6			;ACKnowlege
XMODEM_NAK			EQU		0x15		;Negative AcKnowlege
XMODEM_DATA_SIZE	EQU		128


	XORR	r0,r0,r0
;;;保存 CLEAR_BUFFER 子程序地址到 r1
	ORI		r0,r1,high(CLEAR_BUFFER)	;
	SHLLI	r1,r1,16
	ORI		r1,r1,low(CLEAR_BUFFER)		;
;;;保存 SEND_BYTE 子程序地址到 r2
	ORI		r0,r2,high(SEND_BYTE)		;
	SHLLI	r2,r2,16
	ORI		r2,r2,low(SEND_BYTE)		;
;;;保存 RECV_BYTE 子程序地址到 r3
	ORI		r0,r3,high(RECV_BYTE)		;
	SHLLI	r3,r3,16
	ORI		r3,r3,low(RECV_BYTE)		;
;;;保存 WAIT_PUSH_SW 子程序地址到 r4
	ORI 	r0,r4,high(WAIT_PUSH_SW)	;
	SHLLI	r4,r4,16
	ORI		r4,r4,low(WAIT_PUSH_SW)		;

;;; 清空UART缓存
	CALL	r1							;调用 CLEAR_BUFFER
	ANDR	r0,r0,r0					;NOP
;;; 点亮所有LED
	ORI		r0,r20,GPIO_BASE_ADDR_H		;GPIO Base Address赋给r20
	SHLLI	r20,r20,16					;r20左移16位
	ORI		r0,r21,0x2					;
	SHLLI	r21,r21,16					;r21左移16位，即高位置为0x2
	ORI		r21,r21,0xFFFF				;r21低位置为0xFFFF
	STW		r20,r21,GPIO_OUT_OFFSET		;将r21写入GPIO Output Port

;; 等待任按一键
	CALL	r4
	ANDR	r0, r0, r0

;; 发送NAK
	ORI		r0,r16,XMODEM_NAK			;将r16设为NAK
	CALL	r2							;SEND_BYTE
	ANDR	r0,r0,r0					;NOP

	XORR	r5,r5,r5
;; 接收数据块的头信息
;; 等待接收
RECV_HEADER:
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP

;; 接收数据
	ORI		r0,r6,XMODEM_SOH			;将r6设为SOH
	BE		r16,r6,RECV_SOH
	ANDR	r0,r0,r0					;NOP

;; EOT
;; 发送ACK
	ORI		r0,r16,XMODEM_ACK			;将r16设为ACK
	CALL	r2							;SEND_BYTE
	ANDR	r0,r0,r0					;NOP

;; jump to spm
	ORI		r0,r6,SPM_BASE_ADDR_H		;将SPM Base Address高16位置入r6
	SHLLI	r6,r6,16

	JMP		r6							;执行SPM中的程序
	ANDR	r0,r0,r0					;NOP

;; SOH
RECV_SOH:
;; 接收BN
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r7					;将r7设为收到的BN

;; 接收BNC
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r8					;将r8设为收到的BNC

	ORI		r0,r9,XMODEM_DATA_SIZE
	XORR	r10,r10,r10					;清除r10
	XORR	r11,r11,r11					;清除r11
	
;; 接收一块数据
; byte0
READ_BYTE0:
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,24					;左移24bit
	ORR		r0,r16,r12

; byte1
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,16					;左移16bit
	ORR		r12,r16,r12

; byte2
	CALL	r3							;RECV_BYTE
	ORR		r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,8					;左移8bit
	ORR		r12,r16,r12

; byte3
	CALL	r3							;RECV_BYTE
	ORR		r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	ORR		r12,r16,r12

; write memory
	ORI		r0,r13,SPM_BASE_ADDR_H		;SPM Base Address存入r13的高16位
	SHLLI	r13,r13,16

	SHLLI	r5,r14,7
	ADDUR	r14,r10,r14
	ADDUR	r14,r13,r13
	STW		r13,r12,0

	ADDUI	r10,r10,4
	BNE		r10,r9,READ_BYTE0
	ANDR	r0,r0,r0					;NOP

;; 接收CS
	CALL	r3							;RECV_BYTE
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r12

;; Error Check
	ADDUR	r7,r8,r7
	ORI		r0,r13,0xFF					;将r13置为0xFF
	BNE		r7,r13,SEND_NAK				;如果BN+BNC不等于xFF则发送NAK
	ANDR	r0,r0,r0					;NOP

	ANDI	r11,r11,0xFF				;将r11置为0xFF
	BNE		r12,r11,SEND_NAK			;判断check sum是否正确
	ANDR	r0,r0,r0					;NOP

;; 发送ACK
SEND_ACK:
	ORI		r0,r16,XMODEM_ACK			;将r16置为ACK
	CALL	r2							;SEND_BYTE
	ANDR	r0,r0,r0					;NOP
	ADDUI	r5,r5,1
	BNE		r0,r0,RETURN_RECV_HEADER
	ANDR	r0,r0,r0					;NOP

;; 发送NAK
SEND_NAK:
	ORI		r0,r16,XMODEM_NAK			;将r16置为NAK
	CALL	r2							;SEND_BYTE
	ANDR	r0,r0,r0					;NOP

;; 返回RECV_HEADER
RETURN_RECV_HEADER:
	BE		r0,r0,RECV_HEADER
	ANDR	r0,r0,r0					;NOP

CLEAR_BUFFER:
	ORI		r0,r16,UART_BASE_ADDR_H		;UART Base Address上位16ビットをr16にセット
	SHLLI	r16,r16,16

_CHECK_UART_STATUS:
	LDW		r16,r17,UART_STATUS_OFFSET	;STATUSを取得

	ANDI	r17,r17,UART_RX_INTR_MASK
	BE		r0,r17,_CLEAR_BUFFER_RETURN	;Receive Interrupt bitが立っていれば_CLEAR_BUFFER_RETURNを実行
	ANDR	r0,r0,r0					;NOP

_READ_DATA:
	LDW		r16,r17,UART_DATA_OFFSET	;受信データを読んでバッファをクリアする

	LDW		r16,r17,UART_STATUS_OFFSET	;STATUSを取得
	XORI	r17,r17,UART_RX_INTR_MASK
	STW		r6,r17,UART_STATUS_OFFSET	;Receive Interrupt bitをクリア

	BNE		r0,r0,_CHECK_UART_STATUS	;_CHECK_UART_STATUSに戻る
	ANDR	r0,r0,r0					;NOP
_CLEAR_BUFFER_RETURN:
	JMP		r31							;呼び出し元に戻る
	ANDR	r0,r0,r0					;NOP


SEND_BYTE:
	ORI		r0,r17,UART_BASE_ADDR_H		;UART Base Address上位16ビットをr17にセット
	SHLLI	r17,r17,16
	STW		r17,r16,UART_DATA_OFFSET	;r16を送信する

_WAIT_SEND_DONE:
	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを取得
	ANDI	r18,r18,UART_TX_INTR_MASK
	BE		r0,r18,_WAIT_SEND_DONE		;Transmit Interrupt bitが立っていなければ_WAIT_SEND_DONEを実行
	ANDR	r0,r0,r0					;NOP

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを取得
	XORI	r18,r18,UART_TX_INTR_MASK
	STW		r17,r18,UART_STATUS_OFFSET	;Transmit Interrupt bitをクリア

	JMP		r31							;呼び出し元に戻る
	ANDR	r0,r0,r0					;NOP

RECV_BYTE:
	ORI		r0,r17,UART_BASE_ADDR_H		;UART Base Address上位16ビットをr17にセット
	SHLLI	r17,r17,16

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを取得
	ANDI	r18,r18,UART_RX_INTR_MASK
	BE		r0,r18,RECV_BYTE			;Receive Interrupt bitが立っていればRECV_BYTEを実行
	ANDR	r0,r0,r0					;NOP

	LDW		r17,r16,UART_DATA_OFFSET	;受信データを読む

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを取得
	XORI	r18,r18,UART_RX_INTR_MASK
	STW		r17,r18,UART_STATUS_OFFSET	;Receive Interrupt bitをクリア

	JMP		r31							;呼び出し元に戻る
	ANDR	r0,r0,r0					;NOP

WAIT_PUSH_SW:
	ORI		r0,r16,GPIO_BASE_ADDR_H
	SHLLI	r16,r16,16
_WAIT_PUSH_SW_ON:
	LDW		r16,r17,GPIO_IN_OFFSET
	BE		r0,r17,_WAIT_PUSH_SW_ON
	ANDR	r0,r0,r0					;NOP
_WAIT_PUSH_SW_OFF:
	LDW		r16,r17,GPIO_IN_OFFSET
	BNE		r0,r17,_WAIT_PUSH_SW_OFF
	ANDR	r0,r0,r0					;NOP
_WAIT_PUSH_SW_RETURN:
	JMP		r31
	ANDR	r0,r0,r0					;NOP
