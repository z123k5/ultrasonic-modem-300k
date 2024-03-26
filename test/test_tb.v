`timescale 1ns/1ns
module test_tb; 
reg clk, enable, reset; 
wire [7:0] out; 
counter c1(.out(out), .clk(clk), .enable(enable), .reset(reset));
    initial begin
        enable = 1;
    end
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    initial begin
        reset = 1;
        #15 reset = 0;
        #1000 $finish;
    end
    initial
    begin            
        $dumpfile("test_tb.vcd");  //生成vcd文件，记录仿真信息
        $dumpvars(0, test_tb);  //指定层次数，记录信号
    end 
endmodule
