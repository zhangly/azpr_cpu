;;; ロケーションアドレスの設定
	LOCATE	0x20000000

;;; シンボルの定義
GPIO_BASE_ADDR_H	EQU	0x8000		;GPIO Base Address High
GPIO_OUT_OFFSET		EQU	0x4			;GPIO Output Port Register Offset

;;; LED点灯
	XORR	r0,r0,r0
	ORI		r0,r1,GPIO_BASE_ADDR_H	;GPIO Base Address上位16ビットをr1にセット
	SHLLI	r1,r1,16				;16ビット左シフト
	ORI		r0,r2,0x2				;出力データを上位16ビットをr2にセット
	SHLLI	r2,r2,16				;16ビット左シフト
	ORI		r2,r2,0xFFFF			;出力データを下位16ビットをr2にセット
	STW		r1,r2,GPIO_OUT_OFFSET	;GPIO Output Portに出力データを書き込む

;;; 無限ループ
LOOP:
	BE		r0,r0,LOOP				;LOOPに戻る
	ANDR	r0,r0,r0				;NOP
