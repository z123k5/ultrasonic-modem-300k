module num_4_receive(
    input clk,          //200kHz系统时钟
    input rst,
    input [9:0] wave_s,          //AD信号输入
    
    output [3:0] info_judge,  //复原信号
    output [3:0] info_prob,  //可靠性判断
    output sum_over   //并行数据接收指示,上升沿处理数据，下降沿时info_judge稳定
);

// 10位输入转为16位
wire [15:0] fir_in;
assign fir_in[15:6]=wave_s;
assign fir_in[5:0]=6'd0000;

//滤波器35位输出截取为16位
wire signed [39:0] data1;
wire signed [39:0] data2;
wire signed [15:0] wave_11k;
wire signed [15:0] wave_22k;
assign wave_11k = data1[34:19];
assign wave_22k = data2[34:19];

//整流后的波形
wire [15:0] wave_11k_abs;
wire [15:0] wave_22k_abs;

//低通滤波器输出取16位
wire signed [39:0] data1_dc40;
wire signed [39:0] data2_dc40;
wire signed [15:0] wave_11k_dc;
wire signed [15:0] wave_22k_dc;
assign wave_11k_dc = data1_dc40[35:20];
assign wave_22k_dc = data2_dc40[35:20];

wire info;

//差值估值  判断信号有无  
wire signed [15:0] demode;
wire [15:0] difference_abs;
wire [3:0] difference_bit;
wire [3:0] noise_bit = 4'b0000;

wire clk_avg;   //64倍时钟 每计算完32次采样均值变化一次
wire clk_avg_1;   //比clk_avg略有延迟

wire [4:0] difference_bit_avg;   //信号差值估算         

wire signal_en;  //接收到的信号有效                 

//wire [3:0] info_judge;   //最终并行数据
//wire [3:0] info_prob;    //问题报警信号
//wire sum_over;           //并行数据接收指示

//过带通滤波器
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

//整流1
// rectify u1_rectify(
// .wave(wave_11k),
// .wave_abs(wave_11k_abs)
// );
// rectify u2_rectify(
// .wave(wave_22k),
// .wave_abs(wave_22k_abs)
// );

//低通滤波器
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

//解调
// dem u_dem(
// .clk(clk),
// .rst(rst),
// .wave_11k_dc(wave_11k_dc),
// .wave_22k_dc(wave_22k_dc),
// .info(info),
// .demode(demode)
// );

// //差值信号过整流
// rectify u3_rectify(
// .wave(demode),
// .wave_abs(difference_abs)
// );

//差值位宽判断
// bit_judge bit_judge(
// .clk(clk),
// .rst(rst),
// .difference_abs(difference_abs),
// .difference_bit(difference_bit)
// );

//每32位采样数据取平均值
// avg avg(
// .clk(clk),
// .rst(rst),
// .difference_bit(difference_bit),
// .clk_avg(clk_avg),
// .clk_avg_1(clk_avg_1),
// .difference_bit_avg(difference_bit_avg)
// );

//判断是否接收到信号
// signal_enable signal_enable(
// .clk_avg_1(clk_avg_1),
// .rst(rst),
// .difference_bit_avg(difference_bit_avg),
// .noise_bit(noise_bit),
// .signal_en(signal_en)
// );

//同步 判决 输出信号
// judgment judgment(
// .clk(clk),
// .rst(rst),
// .info(info),  
// .signal_en(signal_en),  // 信号有效性判断
// .clk_avg(clk_avg),   //
// .info_judge(info_judge),  //复原信号
// .info_prob(info_prob),  //可靠性判断
// .sum_over(sum_over)
// );

endmodule