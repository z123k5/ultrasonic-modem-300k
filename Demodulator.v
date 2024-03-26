module num_4_receive(
    input clk,          //200kHzϵͳʱ��
    input rst,
    input [9:0] wave_s,          //AD�ź�����
    
    output [3:0] info_judge,  //��ԭ�ź�
    output [3:0] info_prob,  //�ɿ����ж�
    output sum_over   //�������ݽ���ָʾ,�����ش������ݣ��½���ʱinfo_judge�ȶ�
);

// 10λ����תΪ16λ
wire [15:0] fir_in;
assign fir_in[15:6]=wave_s;
assign fir_in[5:0]=6'd0000;

//�˲���35λ�����ȡΪ16λ
wire signed [39:0] data1;
wire signed [39:0] data2;
wire signed [15:0] wave_11k;
wire signed [15:0] wave_22k;
assign wave_11k = data1[34:19];
assign wave_22k = data2[34:19];

//������Ĳ���
wire [15:0] wave_11k_abs;
wire [15:0] wave_22k_abs;

//��ͨ�˲������ȡ16λ
wire signed [39:0] data1_dc40;
wire signed [39:0] data2_dc40;
wire signed [15:0] wave_11k_dc;
wire signed [15:0] wave_22k_dc;
assign wave_11k_dc = data1_dc40[35:20];
assign wave_22k_dc = data2_dc40[35:20];

wire info;

//��ֵ��ֵ  �ж��ź�����  
wire signed [15:0] demode;
wire [15:0] difference_abs;
wire [3:0] difference_bit;
wire [3:0] noise_bit = 4'b0000;

wire clk_avg;   //64��ʱ�� ÿ������32�β�����ֵ�仯һ��
wire clk_avg_1;   //��clk_avg�����ӳ�

wire [4:0] difference_bit_avg;   //�źŲ�ֵ����         

wire signal_en;  //���յ����ź���Ч                 

//wire [3:0] info_judge;   //���ղ�������
//wire [3:0] info_prob;    //���ⱨ���ź�
//wire sum_over;           //�������ݽ���ָʾ

//����ͨ�˲���
// fir_11k u_fir_11k(
//   .aclk(clk),                           
//   .s_axis_data_tvalid(1'b1), 
//   .s_axis_data_tready(),
//   .s_axis_data_tdata(fir_in),  
//   .m_axis_data_tvalid(),  
//   .m_axis_data_tdata(data1)    
// );
// fir_22k u_fir_22k(
//   .aclk(clk),                           
//   .s_axis_data_tvalid(1'b1), 
//   .s_axis_data_tready(),
//   .s_axis_data_tdata(fir_in),  
//   .m_axis_data_tvalid(),  
//   .m_axis_data_tdata(data2)    
// );

//����1
// rectify u1_rectify(
// .wave(wave_11k),
// .wave_abs(wave_11k_abs)
// );
// rectify u2_rectify(
// .wave(wave_22k),
// .wave_abs(wave_22k_abs)
// );

//��ͨ�˲���
// lowpass u1_lowpass(
//   .aclk(clk),                           
//   .s_axis_data_tvalid(1'b1), 
//   .s_axis_data_tready(),
//   .s_axis_data_tdata(wave_11k_abs),  
//   .m_axis_data_tvalid(),  
//   .m_axis_data_tdata(data1_dc40)    
// );
// lowpass u2_lowpass(
//   .aclk(clk),                           
//   .s_axis_data_tvalid(1'b1), 
//   .s_axis_data_tready(),
//   .s_axis_data_tdata(wave_22k_abs),  
//   .m_axis_data_tvalid(),  
//   .m_axis_data_tdata(data2_dc40)    
// );

//���
// dem u_dem(
// .clk(clk),
// .rst(rst),
// .wave_11k_dc(wave_11k_dc),
// .wave_22k_dc(wave_22k_dc),
// .info(info),
// .demode(demode)
// );

// //��ֵ�źŹ�����
// rectify u3_rectify(
// .wave(demode),
// .wave_abs(difference_abs)
// );

//��ֵλ���ж�
// bit_judge bit_judge(
// .clk(clk),
// .rst(rst),
// .difference_abs(difference_abs),
// .difference_bit(difference_bit)
// );

//ÿ32λ��������ȡƽ��ֵ
// avg avg(
// .clk(clk),
// .rst(rst),
// .difference_bit(difference_bit),
// .clk_avg(clk_avg),
// .clk_avg_1(clk_avg_1),
// .difference_bit_avg(difference_bit_avg)
// );

//�ж��Ƿ���յ��ź�
// signal_enable signal_enable(
// .clk_avg_1(clk_avg_1),
// .rst(rst),
// .difference_bit_avg(difference_bit_avg),
// .noise_bit(noise_bit),
// .signal_en(signal_en)
// );

//ͬ�� �о� ����ź�
// judgment judgment(
// .clk(clk),
// .rst(rst),
// .info(info),  
// .signal_en(signal_en),  // �ź���Ч���ж�
// .clk_avg(clk_avg),   //
// .info_judge(info_judge),  //��ԭ�ź�
// .info_prob(info_prob),  //�ɿ����ж�
// .sum_over(sum_over)
// );

endmodule