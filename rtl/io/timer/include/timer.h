/*
 -- ============================================================================
 -- FILE NAME	: timer.h
 -- DESCRIPTION : 定时器
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- ============================================================================
*/

`ifndef __TIMER_HEADER__
	`define __TIMER_HEADER__		 //  

	/********** バス **********/
	`define TIMER_ADDR_W		2	 // アドレス幅
	`define TimerAddrBus		1:0	 // アドレスバス
	`define TimerAddrLoc		1:0	 // アドレスの位置
	/********** アドレスマップ **********/
	`define TIMER_ADDR_CTRL		2'h0 // 制御レジスタ 0 : コントロール
	`define TIMER_ADDR_INTR		2'h1 // 制御レジスタ 1 : 割り込み
	`define TIMER_ADDR_EXPR		2'h2 // 制御レジスタ 2 : 満了値
	`define TIMER_ADDR_COUNTER	2'h3 // 制御レジスタ 3 : カウンタ
	/********** ビットマップ **********/
	// 制御レジスタ 0 : コントロール
	`define TimerStartLoc		0	 // スタートビットの位置
	`define TimerModeLoc		1	 // モードビットの位置
	`define TIMER_MODE_ONE_SHOT 1'b0 // モード : ワンショットタイマ
	`define TIMER_MODE_PERIODIC 1'b1 // モード : 周期タイマ
	// 制御レジスタ 1 : 割り込み要求
	`define TimerIrqLoc			0	 // 割り込み要求ビットの位置

`endif
