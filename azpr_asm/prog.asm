;;; 1、编译： azprasm prog.asm -o prog.bin
;;; 2、上传： 开发板复位之后用tare term以XMODEN协议上传prog.bin,任按一个按钮即完成上传
;;;           开发板综合时，已将程序加载器“loader16.mif”作为ROM初始数据文件
;;; 3、执行： 程序加载器loader通过串口完成程序上传并保存到SPM内存后，跳转到SPM中的程序入口执行
;;; 设置起始位置
	LOCATE	0x20000000

;;; 符号定义
GPIO_BASE_ADDR_H	EQU	0x8000		;GPIO Base Address High
GPIO_OUT_OFFSET		EQU	0x4			;GPIO Output Port Register Offset

;;; 点亮LED
	XORR	r0,r0,r0
	ORI		r0,r1,GPIO_BASE_ADDR_H	;GPIO Base Address存入r1
	SHLLI	r1,r1,16				;左移16位,即设置地址高位
	ORI		r0,r2,0x2				;0x2存入r2
	SHLLI	r2,r2,16				;r2左移16位，即设置高16位置
	ORI		r2,r2,0x00aa			;设置r2的低16位置
	STW		r1,r2,GPIO_OUT_OFFSET	;r2作为输出数据写入GPIO Output Port（总共18位）

;;; 无限循环
LOOP:
	BE		r0,r0,LOOP				;返回LOOP
	ANDR	r0,r0,r0				;NOP
