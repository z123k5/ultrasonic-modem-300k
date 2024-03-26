module ultrasonicModem300k(
    input enable,       // 使能信号
    input clk,          // 输入时钟，50MHz
    input data_in,      // 输入数据
    input fsk_in,       //
    output reg fsk_out, // FSK调制输出
    output data_out // 
);

// 定义计数器和比较值以生成基带频率
parameter COUNTER_MAX_BIT0 = 90;  // 90 50MHz / 300kHz / 2 - 1
parameter COUNTER_MAX_BIT1 = 73;  // 73 50MHz / 600kHz / 2 - 1
reg [7:0] counter_bit = COUNTER_MAX_BIT0;
reg [7:0] arr = 8'b0;



fsk_demodulator dem(
    .clk(clk),           // 时钟信号
    .fsk_in(fsk_out),        // FSK调制输入
    .data_out(data_out)  // 解调后的数据输出
);


initial begin
	fsk_out = 0;
end

// 生成基带信号
always @(posedge clk) begin
    if (enable) begin
		counter_bit <= counter_bit - 1'b1;
		if (counter_bit == 8'b0) begin
			counter_bit <= arr;
			fsk_out <= ~fsk_out;
		end
	end else begin
		fsk_out <= 0;
	end
end

// 根据输入数据选择相应的基带频率作为输出
always @(*) begin
    if (data_in == 1'b0) begin
        // fsk_out = clk_bit0;
        arr <= COUNTER_MAX_BIT0;
    end else begin
        // fsk_out = clk_bit1;
        arr <= COUNTER_MAX_BIT1;
    end
end

endmodule
