module fsk_system(
    input clk,           // 系统时钟
    input data_in,       // 输入数据
    input clk_bit0,      // 比特0的时钟信号
    input clk_bit1,      // 比特1的时钟信号
    output data_out      // 解调后的数据输出
);

// 调制器输出
wire fsk_out;

// 调制器模块
fsk_modulator modulator(
    .data_in(data_in),
    .clk_bit0(clk_bit0),
    .clk_bit1(clk_bit1),
    .fsk_out(fsk_out)
);

// 解调器模块
fsk_demodulator demodulator(
    .clk(clk),
    .fsk_in(fsk_out),
    .data_out(data_out)
);

endmodule
