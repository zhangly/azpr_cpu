/*
 -- ============================================================================
 -- FILE NAME	: gpio.h
 -- DESCRIPTION : General Purpose I/Oヘッダ
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- ============================================================================
*/

`ifndef __GPIO_HEADER__
   `define __GPIO_HEADER__			// インクルードガード

	/********** ポート数の定義 **********/
	`define GPIO_IN_CH		   4	// 入力ポート数
	`define GPIO_OUT_CH		   18	// 出力ポート数
	`define GPIO_IO_CH		   16	// 入出力ポート数
  
	/********** バス **********/
	`define GpioAddrBus		   1:0	// アドレスバス
	`define GPIO_ADDR_W		   2	// アドレス幅
	`define GpioAddrLoc		   1:0	// アドレスの位置
	/********** アドレスマップ **********/
	`define GPIO_ADDR_IN_DATA  2'h0 // 制御レジスタ 0 : 入力ポート
	`define GPIO_ADDR_OUT_DATA 2'h1 // 制御レジスタ 1 : 出力ポート
	`define GPIO_ADDR_IO_DATA  2'h2 // 制御レジスタ 2 : 入出力ポート
	`define GPIO_ADDR_IO_DIR   2'h3 // 制御レジスタ 3 : 入出力方向
	/********** 入出力方向 **********/
	`define GPIO_DIR_IN		   1'b0 // 入力
	`define GPIO_DIR_OUT	   1'b1 // 出力

`endif
