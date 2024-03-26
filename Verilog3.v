module Modulator(
    input enable,       // ʹ���ź�
    input clk,          // ����ʱ�ӣ�50MHz
    input data_in,      // ��������
    output reg fsk_out // FSK�������
);

initial begin
	fsk_out = 0;
end

// ���ɻ����ź�
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
