module FGenerator(
	input rst,
	input clk,
	output reg clk0_out,
	output reg clk1_out
);
parameter F1 = 271535;
parameter F2 = 277008;
reg cnt0[19:0] = 0;
reg cnt1[19:0] = 0;

always@(posedge clk or negedge rst) begin
	if(!rst) begin
		cnt0 <= F1;
		cnt1 <= F2;
		//clk0_out <= 0;
		//clk1_out <= 0;
	end else
		cnt0 <= cnt0 - 1;
		cnt1 <= cnt1 - 1;
	if(cnt0 == 0) clk0_out <= ~clk0_out;
	if(cnt1 == 0) clk1_out <= ~clk1_out;
end

endmodule
