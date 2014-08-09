azpr_cpu
========
本项目为量化投资领域想用FPGA装逼的童鞋作点好事，零基础学FPGA至少能加速1个月的学习进度，详见本项目wiki。
========

Verilog入门项目：使用Altera FPGA芯片制作一个采用流水线机制的CPU单片机

>开发环境：Quartus II 11.2

>FPGA芯片：Altera Cyclone IV E

>引脚约束：开发板 <http://item.taobao.com/item.htm?id=35911884243>

>占用芯片资源规模：4000 个逻辑单元， 200,000 bit RAM  

#目录说明：

>`rtl/`           项目Verilog源代码目录,顶层模块为chip_top.v  
>`doc/`           设计文档目录  
>`azpr_asm/`           运行在目标cpu上的汇编代码示例及编译器 

注1：原始项目来自《CPU自制入门》，从Xilinx芯片迁移到采用Altera芯片的开发板

注2：本项目上板成功后，想继续装逼为cpu添加指令，先学用LLVM怎么定制一个编译器，据说Objective-C的编译器也是用这个。  
     <https://github.com/umedaikiti/AZPRBackend>
