;;; 符号定义(本源代码文件以ANSI编码)
GPIO_BASE_ADDR_H	EQU	0x8000		;GPIO Base Address High
GPIO_OUT_OFFSET		EQU	0x4			;GPIO Output Port Register Offset

;;; 点亮LED
	XORR	r0,r0,r0
	ORI		r0,r1,GPIO_BASE_ADDR_H	;将GPIO Base Address高16位存入r1
	SHLLI	r1,r1,16				;左移16位
	ORI		r0,r2,0x2				;输出数据r2的高16位
	SHLLI	r2,r2,16				;左移16位
	ORI		r2,r2,0x00aa			;输出数据r2的低16位
	STW		r1,r2,GPIO_OUT_OFFSET	;输出数据写入GPIO Output Port

;;; 无限循环
LOOP:
	BE		r0,r0,LOOP				;退回到LOOP
	ANDR	r0,r0,r0				;NOP空操作
