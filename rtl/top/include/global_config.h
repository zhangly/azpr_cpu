/*
 -- ============================================================================
 -- FILE NAME	: global_config.h
 -- DESCRIPTION : 全局设置
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- 1.0.1	  2014/07/27  zhangly 
 -- ============================================================================
*/

`ifndef __GLOBAL_CONFIG_HEADER__
	`define __GLOBAL_CONFIG_HEADER__	//  

//------------------------------------------------------------------------------
// 設定項目
//------------------------------------------------------------------------------
	/********** 目标开发板设置 **********/
//	`define TARGET_DEV_MFPGA_SPAR3E		// MFPGA板
	`define TARGET_DEV_AZPR_EV_BOARD	// AZPR原生板

/********** 复位信号极性选择**********/
//	`define POSITIVE_RESET				// Active High
	`define NEGATIVE_RESET				// Active Low

	/********** 内存控制信号极性选择 **********/
	`define POSITIVE_MEMORY				// Active High
//	`define NEGATIVE_MEMORY				// Active Low

	/********** I/O 设备选择**********/
	`define IMPLEMENT_TIMER				// 定时器
	`define IMPLEMENT_UART				// UART
	`define IMPLEMENT_GPIO				// General Purpose I/O

//------------------------------------------------------------------------------
// 生成的参数取决于配置
//------------------------------------------------------------------------------
/********** 复位极性 *********/
	// Active Low
	`ifdef POSITIVE_RESET
		`define RESET_EDGE	  posedge	// 上升沿
		`define RESET_ENABLE  1'b1		// 复位有效
		`define RESET_DISABLE 1'b0		// 复位无效
	`endif
	// Active High
	`ifdef NEGATIVE_RESET
		`define RESET_EDGE	  negedge	// 下降沿
		`define RESET_ENABLE  1'b0		// 复位有效
		`define RESET_DISABLE 1'b1		// 复位无效
	`endif

	/********** 内存控制信号极性 *********/
	// Actoive High
	`ifdef POSITIVE_MEMORY
		`define MEM_ENABLE	  1'b1		// 内存有效
		`define MEM_DISABLE	  1'b0		// 内存无效
	`endif
	// Active Low
	`ifdef NEGATIVE_MEMORY
		`define MEM_ENABLE	  1'b0		// 内存有效
		`define MEM_DISABLE	  1'b1		// 内存无效
	`endif

`endif
