;;; 憲催協吶
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

	ORI		r0,r1,high(CLEAR_BUFFER)	;ラベルCLEAR_BUFFERの貧了16ビットをr1にセット
	SHLLI	r1,r1,16
	ORI		r1,r1,low(CLEAR_BUFFER)		;ラベルCLEAR_BUFFERの和了16ビットをr1にセット

	ORI		r0,r2,high(SEND_BYTE)		;ラベルSEND_BYTEの貧了16ビットをr2にセット
	SHLLI	r2,r2,16
	ORI		r2,r2,low(SEND_BYTE)		;ラベルSEND_BYTEの和了16ビットをr2にセット

	ORI		r0,r3,high(RECV_BYTE)		;ラベルRECV_BYTEの貧了16ビットをr3にセット
	SHLLI	r3,r3,16
	ORI		r3,r3,low(RECV_BYTE)		;ラベルRECV_BYTEの和了16ビットをr3にセット

	ORI 	r0,r4,high(WAIT_PUSH_SW)	;ラベルWAIT_PUSH_SWの貧了16ビットをr4にセット
	SHLLI	r4,r4,16
	ORI		r4,r4,low(WAIT_PUSH_SW)		;ラベルWAIT_PUSH_SWの和了16ビットをr4にセット

;;; UARTのバッファクリア
	CALL	r1							;CLEAR_BUFFER柵び竃し
	ANDR	r0,r0,r0					;NOP

	ORI		r0,r20,GPIO_BASE_ADDR_H		;GPIO Base Address貧了16ビットをr20にセット
	SHLLI	r20,r20,16					;16ビット恣シフト
	ORI		r0,r21,0x2					;竃薦デ�`タを貧了16ビットをr21にセット
	SHLLI	r21,r21,16					;16ビット恣シフト
	ORI		r21,r21,0xFFFF				;竃薦デ�`タを和了16ビットをr21にセット
	STW		r20,r21,GPIO_OUT_OFFSET		;GPIO Output Portに竃薦デ�`タを��き�zむ

;; Wait Push Switch
	CALL	r4
	ANDR	r0, r0, r0

;; NAK僕佚
	ORI		r0,r16,XMODEM_NAK			;r16にNAKをセット
	CALL	r2							;SEND_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP

	XORR	r5,r5,r5
;; ブロックの枠�^を鞭佚する
;; 鞭佚棋ち
RECV_HEADER:
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP

;; 鞭佚デ�`タ
	ORI		r0,r6,XMODEM_SOH			;r6にSOHをセット
	BE		r16,r6,RECV_SOH
	ANDR	r0,r0,r0					;NOP

;; EOT
;; ACK僕佚
	ORI		r0,r16,XMODEM_ACK			;r16にACKをセット
	CALL	r2							;SEND_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP

;; jump to spm
	ORI		r0,r6,SPM_BASE_ADDR_H		;SPM Base Address貧了16ビットをr6にセット
	SHLLI	r6,r6,16

	JMP		r6							;SPMのプログラムを�g佩する
	ANDR	r0,r0,r0					;NOP

;; SOH
RECV_SOH:
;; BN鞭佚
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r7					;r7に鞭佚デ�`タBNをセット

;; BNC鞭佚
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r8					;r8に鞭佚デ�`タBNCをセット

	ORI		r0,r9,XMODEM_DATA_SIZE
	XORR	r10,r10,r10					;r10をクリア
	XORR	r11,r11,r11					;r11をクリア

;; 1ブロック鞭佚
; byte0
READ_BYTE0:
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,24					;24bit恣シフト
	ORR		r0,r16,r12

; byte1
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,16					;16bit恣シフト
	ORR		r12,r16,r12

; byte2
	CALL	r3							;RECV_BYTE柵び竃し
	ORR		r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	SHLLI	r16,r16,8					;8bit恣シフト
	ORR		r12,r16,r12

; byte3
	CALL	r3							;RECV_BYTE柵び竃し
	ORR		r0,r0,r0					;NOP
	ADDUR	r11,r16,r11
	ORR		r12,r16,r12

; write memory
	ORI		r0,r13,SPM_BASE_ADDR_H		;SPM Base Address貧了16ビットをr13にセット
	SHLLI	r13,r13,16

	SHLLI	r5,r14,7
	ADDUR	r14,r10,r14
	ADDUR	r14,r13,r13
	STW		r13,r12,0

	ADDUI	r10,r10,4
	BNE		r10,r9,READ_BYTE0
	ANDR	r0,r0,r0					;NOP

;; CS鞭佚
	CALL	r3							;RECV_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ORR		r0,r16,r12

;; Error Check
	ADDUR	r7,r8,r7
	ORI		r0,r13,0xFF					;r13に0xFFをセット
	BNE		r7,r13,SEND_NAK				;BN+BNCが0xFFでなければNAK僕佚
	ANDR	r0,r0,r0					;NOP

	ANDI	r11,r11,0xFF				;r11に0xFFをセット
	BNE		r12,r11,SEND_NAK			;check sumが屎しいか
	ANDR	r0,r0,r0					;NOP

;; ACK僕佚
SEND_ACK:
	ORI		r0,r16,XMODEM_ACK			;r16にACKをセット
	CALL	r2							;SEND_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP
	ADDUI	r5,r5,1
	BNE		r0,r0,RETURN_RECV_HEADER
	ANDR	r0,r0,r0					;NOP

;; NAK僕佚
SEND_NAK:
	ORI		r0,r16,XMODEM_NAK			;r16にNAKをセット
	CALL	r2							;SEND_BYTE柵び竃し
	ANDR	r0,r0,r0					;NOP

;; RECV_HEADERに��る
RETURN_RECV_HEADER:
	BE		r0,r0,RECV_HEADER
	ANDR	r0,r0,r0					;NOP

CLEAR_BUFFER:
	ORI		r0,r16,UART_BASE_ADDR_H		;UART Base Address貧了16ビットをr16にセット
	SHLLI	r16,r16,16

_CHECK_UART_STATUS:
	LDW		r16,r17,UART_STATUS_OFFSET	;STATUSを函誼

	ANDI	r17,r17,UART_RX_INTR_MASK
	BE		r0,r17,_CLEAR_BUFFER_RETURN	;Receive Interrupt bitが羨っていれば_CLEAR_BUFFER_RETURNを�g佩
	ANDR	r0,r0,r0					;NOP

_READ_DATA:
	LDW		r16,r17,UART_DATA_OFFSET	;鞭佚デ�`タを�iんでバッファをクリアする

	LDW		r16,r17,UART_STATUS_OFFSET	;STATUSを函誼
	XORI	r17,r17,UART_RX_INTR_MASK
	STW		r6,r17,UART_STATUS_OFFSET	;Receive Interrupt bitをクリア

	BNE		r0,r0,_CHECK_UART_STATUS	;_CHECK_UART_STATUSに��る
	ANDR	r0,r0,r0					;NOP
_CLEAR_BUFFER_RETURN:
	JMP		r31							;柵び竃し圷に��る
	ANDR	r0,r0,r0					;NOP


SEND_BYTE:
	ORI		r0,r17,UART_BASE_ADDR_H		;UART Base Address貧了16ビットをr17にセット
	SHLLI	r17,r17,16
	STW		r17,r16,UART_DATA_OFFSET	;r16を僕佚する

_WAIT_SEND_DONE:
	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを函誼
	ANDI	r18,r18,UART_TX_INTR_MASK
	BE		r0,r18,_WAIT_SEND_DONE		;Transmit Interrupt bitが羨っていなければ_WAIT_SEND_DONEを�g佩
	ANDR	r0,r0,r0					;NOP

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを函誼
	XORI	r18,r18,UART_TX_INTR_MASK
	STW		r17,r18,UART_STATUS_OFFSET	;Transmit Interrupt bitをクリア

	JMP		r31							;柵び竃し圷に��る
	ANDR	r0,r0,r0					;NOP

RECV_BYTE:
	ORI		r0,r17,UART_BASE_ADDR_H		;UART Base Address貧了16ビットをr17にセット
	SHLLI	r17,r17,16

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを函誼
	ANDI	r18,r18,UART_RX_INTR_MASK
	BE		r0,r18,RECV_BYTE			;Receive Interrupt bitが羨っていればRECV_BYTEを�g佩
	ANDR	r0,r0,r0					;NOP

	LDW		r17,r16,UART_DATA_OFFSET	;鞭佚デ�`タを�iむ

	LDW		r17,r18,UART_STATUS_OFFSET	;STATUSを函誼
	XORI	r18,r18,UART_RX_INTR_MASK
	STW		r17,r18,UART_STATUS_OFFSET	;Receive Interrupt bitをクリア

	JMP		r31							;柵び竃し圷に��る
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
