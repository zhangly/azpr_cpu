azpr_cpu 汇编代码编译器azprasm for windows
使用方法一：
1、编译汇编源代码：azprasm led.asm -o led.bin --coe led.coe
2、将生成出来的led.coe(xilinux ROM映像文件) 手工转换为 altera ROM 映像文件led.mif

使用方法二（使用串口程序加载器）：
前提：开发板综合时将串口程序加载器的mif文件作为ROM初始化数据文件；
1、使用azprasm编译出二进制执行文件 *.bin;
2、开发板通过串口与PC连接
3、开发板复位，在PC上用tare term软件以XMODEM协议发送所要加载的*.bin文件
4、在开发板上任按一个按钮（KEY1~KEY4），即触发串口文件传送
5、传送完毕，开发板即开始执行上传的程序
