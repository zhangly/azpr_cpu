/*
 -- ============================================================================
 -- FILE NAME	: spm.h
 -- DESCRIPTION : スクラッチパッドメモリヘッダ
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- ============================================================================
*/

`ifndef __SPM_HEADER__
	`define __SPM_HEADER__			  // インクルードガード

/*
 * 【SPMのサイズについて】
 * ?SPMのサイズを変更するには、
 *	 SPM_SIZE、SPM_DEPTH、SPM_ADDR_W、SpmAddrBus、SpmAddrLocを変更して下さい。
 * ?SPM_SIZEはSPMのサイズを定義しています。
 * ?SPM_DEPTHはSPMの深さを定義しています。
 *	 SPMの幅は基本的に32bit（4Byte）固定なので、
 *	 SPM_DEPTHはSPM_SIZEを4で割った値になります。
 * ?SPM_ADDR_WはSPMのアドレス幅を定義しており、
 *	 SPM_DEPTHをlog2した値になります。
 * ?SpmAddrBusとSpmAddrLocはSPM_ADDR_Wのバスです。
 *	 SPM_ADDR_W-1:0として下さい。
 *
 * 【SPMのサイズの例】
 * ?SPMのサイズが16384Byte（16KB）の場合、
 *	 SPM_DEPTHは16384÷4で4096
 *	 SPM_ADDR_Wはlog2(4096)で12となります。
 */

	`define SPM_SIZE   16384 // SPMのサイズ
	`define SPM_DEPTH  4096	 // SPMの深さ
	`define SPM_ADDR_W 12	 // アドレス幅
	`define SpmAddrBus 11:0	 // アドレスバス
	`define SpmAddrLoc 11:0	 // アドレスの位置

`endif

