module Modulator(
    input enable,       // 使能信号
    input clk,          // 输入时钟，50MHz
    input data_in,      // 输入数据
    output reg fsk_out // FSK调制输出
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

endmodule
