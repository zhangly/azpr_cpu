/*
 -- ============================================================================
 -- FILE NAME	: bus.h
 -- DESCRIPTION : 总线宏定义
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 新規作成
  -- 1.0.0	  2014/08/2  zhangly	  
 -- ============================================================================
*/

`ifndef __BUS_HEADER__
	`define __BUS_HEADER__			 

	/********** 总线主控 *********/
	`define BUS_MASTER_CH	   4	 // 主控数量
	`define BUS_MASTER_INDEX_W 2	 // 主控索引位宽

	/********** 总线所有者*********/
	`define BusOwnerBus		   1:0	 //总线所有者位宽宏
	`define BUS_OWNER_MASTER_0 2'h0	 // 总线所有者 ： 0号总线主控
	`define BUS_OWNER_MASTER_1 2'h1	 // 总线所有者 ： 1号总线主控
	`define BUS_OWNER_MASTER_2 2'h2	 // 总线所有者 ： 2号总线主控
	`define BUS_OWNER_MASTER_3 2'h3	 // 总线所有者 ： 3号总线主控

	/********** 总线从属 *********/
	`define BUS_SLAVE_CH	   8	 // 总线从属设备数量
	`define BUS_SLAVE_INDEX_W  3	 // 从属索引位宽
	`define BusSlaveIndexBus   2:0	 // 总线从属索引位宽定义
	`define BusSlaveIndexLoc   29:27 // 总线从属索引位置

	`define BUS_SLAVE_0		   0	 // 0号总线从属
	`define BUS_SLAVE_1		   1	 // 1号总线从属
	`define BUS_SLAVE_2		   2	 // 2号总线从属
	`define BUS_SLAVE_3		   3	 // 3号总线从属
	`define BUS_SLAVE_4		   4	 // 4号总线从属
	`define BUS_SLAVE_5		   5	 // 5号总线从属
	`define BUS_SLAVE_6		   6	 // 6号总线从属
	`define BUS_SLAVE_7		   7	 // 7号总线从属

`endif
