cmodule ultrasonicModem300k(
    input enable,       // ʹ���ź�
    input clk,          // ����ʱ�ӣ�50MHz
    input data_in,      // ��������
    input fsk_in,       // 
    output reg fsk_out, // FSK�������
    output data_out // 
);

// ����������ͱȽ�ֵ�����ɻ���Ƶ��
parameter COUNTER_MAX_BIT0 = 95;  //95 367.276 = 200MHz / 271535Hz / 2 - 1
parameter COUNTER_MAX_BIT1 = 89; //89  // 360.000 = 200MHz / 277008Hz / 2 - 1
reg [7:0] counter_bit = COUNTER_MAX_BIT0;
reg [7:0] arr = 0;


// 100MHz
//reg         temp_mul;
//assign         P = ~(clk ^ ~temp_mul);
//always @(posedge P)
//begin
//	temp_mul <= ~temp_mul ;
//end

// 200MHz
//reg         clk200;
//assign         P2 = ~(P ^ ~clk200);
//always @(posedge P2)
//begin
//	clk200 <= ~clk200 ;
//end


fsk_demodulator dem(
    .clk(clk),           // ʱ���ź�
    .fsk_in(fsk_in),        // FSK��������
    .data_out(data_out),  // �������������
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

// ������������ѡ����Ӧ�Ļ���Ƶ����Ϊ���
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