`include "ultrasonic-modem-300k.v"
`timescale 1ns/1ns

module ultrasonicModem300k_benchmk;
reg clk, data_in, enable;
wire fsk_out;

ultrasonicModem300k c1(.enable(enable), .clk(clk), .data_in(data_in), .fsk_in(fsk_out), .fsk_out(fsk_out), .data_out());


initial begin
    clk = 0;
    forever #10 clk = ~clk;
end
initial begin
    data_in = 1;
    #20000 data_in = 0;
    #32000 data_in = 1;
    #33000 data_in = 0;
    #34000 data_in = 1;
    #37000 data_in = 0;
    #39000 data_in = 1;
    #41000 data_in = 0;
    #10000000 $finish;
end
initial begin
    enable = 0;
    #10 enable = 1;
    #10000000 $finish;
end
initial
begin
    $dumpfile("ultrasonicModem300k_benchmk.vcd");  //生成vcd文件，记录仿真信息
    $dumpvars(0, ultrasonicModem300k_benchmk);  //指定层次数，记录信号
end


endmodule
