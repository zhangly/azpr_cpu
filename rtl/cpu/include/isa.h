/* 
 -- ============================================================================
 -- FILE NAME	: isa.h
 -- DESCRIPTION : 命令セットアーキテクチャ
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
 -- ============================================================================
*/

`ifndef __ISA_HEADER__
	`define __ISA_HEADER__			 // Include Guard

//------------------------------------------------------------------------------
// 命令
//------------------------------------------------------------------------------
	/********** 命令 **********/
	`define ISA_NOP			   32'h0 // No Operation
	/********** オペコード **********/
	// バス
	`define ISA_OP_W		   6	 // オペコード幅
	`define IsaOpBus		   5:0	 // オペコードバス
	`define IsaOpLoc		   31:26 // オペコードの位置
	// オペコード
	`define ISA_OP_ANDR		   6'h00 // レジスタ同士の論理積
	`define ISA_OP_ANDI		   6'h01 // レジスタと定数の論理積
	`define ISA_OP_ORR		   6'h02 // レジスタ同士の論理和
	`define ISA_OP_ORI		   6'h03 // レジスタと定数の論理和
	`define ISA_OP_XORR		   6'h04 // レジスタ同士の排他的論理和
	`define ISA_OP_XORI		   6'h05 // レジスタと定数の排他的論理和
	`define ISA_OP_ADDSR	   6'h06 // レジスタ同士の符号付き加算
	`define ISA_OP_ADDSI	   6'h07 // レジスタと定数の符号付き加算
	`define ISA_OP_ADDUR	   6'h08 // レジスタ同士の符号なし加算
	`define ISA_OP_ADDUI	   6'h09 // レジスタと定数の符号なし加算
	`define ISA_OP_SUBSR	   6'h0a // レジスタ同士の符号付き減算
	`define ISA_OP_SUBUR	   6'h0b // レジスタ同士の符号なし減算
	`define ISA_OP_SHRLR	   6'h0c // レジスタ同士の論理右シフト
	`define ISA_OP_SHRLI	   6'h0d // レジスタと定数の論理右シフト
	`define ISA_OP_SHLLR	   6'h0e // レジスタ同士の論理左シフト
	`define ISA_OP_SHLLI	   6'h0f // レジスタと定数の論理左シフト
	`define ISA_OP_BE		   6'h10 // レジスタ同士の符号付き比較(==)
	`define ISA_OP_BNE		   6'h11 // レジスタ同士の符号付き比較(!=)
	`define ISA_OP_BSGT		   6'h12 // レジスタ同士の符号付き比較(<)
	`define ISA_OP_BUGT		   6'h13 // レジスタ同士の符号なし比較(<)
	`define ISA_OP_JMP		   6'h14 // レジスタ指定の絶対分岐
	`define ISA_OP_CALL		   6'h15 // レジスタ指定のサブルーチンコール
	`define ISA_OP_LDW		   6'h16 // ワード読み出し
	`define ISA_OP_STW		   6'h17 // ワード書き込み
	`define ISA_OP_TRAP		   6'h18 // トラップ
	`define ISA_OP_RDCR		   6'h19 // 制御レジスタの読み出し
	`define ISA_OP_WRCR		   6'h1a // 制御レジスタへの書き込み
	`define ISA_OP_EXRT		   6'h1b // 例外からの復帰
	/********** レジスタアドレス **********/
	// バス
	`define ISA_REG_ADDR_W	   5	 // レジスタアドレス幅
	`define IsaRegAddrBus	   4:0	 // レジスタアドレスバス
	`define IsaRaAddrLoc	   25:21 // レジスタRaの位置
	`define IsaRbAddrLoc	   20:16 // レジスタRbの位置
	`define IsaRcAddrLoc	   15:11 // レジスタRcの位置
	/********** 即値 **********/
	// バス
	`define ISA_IMM_W		   16	 // 即値の幅
	`define ISA_EXT_W		   16	 // 即値の符号拡張幅
	`define ISA_IMM_MSB		   15	 // 即値の最上位ビット
	`define IsaImmBus		   15:0	 // 即値のバス
	`define IsaImmLoc		   15:0	 // 即値の位置

//------------------------------------------------------------------------------
// 例外
//------------------------------------------------------------------------------
	/********** 例外コード **********/
	// バス
	`define ISA_EXP_W		   3	 // 例外コード幅
	`define IsaExpBus		   2:0	 // 例外コードバス
	// 例外
	`define ISA_EXP_NO_EXP	   3'h0	 // 例外なし
	`define ISA_EXP_EXT_INT	   3'h1	 // 外部割り込み
	`define ISA_EXP_UNDEF_INSN 3'h2	 // 未定義命令
	`define ISA_EXP_OVERFLOW   3'h3	 // 算術オーバフロー
	`define ISA_EXP_MISS_ALIGN 3'h4	 // アドレスミスアライン
	`define ISA_EXP_TRAP	   3'h5	 // トラップ
	`define ISA_EXP_PRV_VIO	   3'h6	 // 特権違反

`endif
