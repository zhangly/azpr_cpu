/*
 -- ============================================================================
 -- FILE NAME	: rom.h
 -- DESCRIPTION : ROM ヘッダ
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- ============================================================================
*/

`ifndef __ROM_HEADER__
	`define __ROM_HEADER__			  // インクルードガード

/*
 * 【ROMのサイズについて】
 * ?ROMのサイズを変更するには、
 *	 ROM_SIZE、ROM_DEPTH、ROM_ADDR_W、RomAddrBus、RomAddrLocを変更して下さい。
 * ?ROM_SIZEはROMのサイズを定義しています。
 * ?ROM_DEPTHはROMの深さを定義しています。
 *	 ROMの幅は基本的に32bit（4Byte）固定なので、
 *	 ROM_DEPTHはROM_SIZEを4で割った値になります。
 * ?ROM_ADDR_WはROMのアドレス幅を定義しており、
 *	 ROM_DEPTHをlog2した値になります。
 * ?RomAddrBusとRomAddrLocはROM_ADDR_Wのバスです。
 *	 ROM_ADDR_W-1:0として下さい。
 *
 * 【ROMのサイズの例】
 * ?ROMのサイズが8192Byte（4KB）の場合、
 *	 ROM_DEPTHは8192÷4で2048
 *	 ROM_ADDR_Wはlog2(2048)で11となります。
 */

	`define ROM_SIZE   8192	// ROMのサイズ
	`define ROM_DEPTH  2048	// ROMの深さ
	`define ROM_ADDR_W 11	// アドレス幅
	`define RomAddrBus 10:0 // アドレスバス
	`define RomAddrLoc 10:0 // アドレスの位置

`endif

