module fsk_demodulator(
    input clk,           // 时钟信号
    input fsk_in,        // FSK调制输入
    output reg data_out  // 解调后的数据输出
);

// 参数定义
parameter COUNTER_MAX = 10000;  // 计数器的最大值
parameter PERIODS_TO_MEASURE = 2;  // 要测量的周期数
parameter THRESHOLD = 80 * PERIODS_TO_MEASURE;    // 阈值，用于判断是哪个比特
parameter PERIODS_NOISE = 10;  // 噪声周期数

// 内部信号定义
reg [13:0] counter = 0;         // 计数器，用于测量周期长度
reg fsk_in_last = 0;            // 上一个时钟周期的FSK输入
reg [14:0] period_sum = 0;      // 测量到的周期长度之和
reg [2:0] periods_measured = 0; // 已测量的周期数

initial begin
	data_out = 0;
end

// 测量FSK信号的周期长度并累加
always @(posedge clk) begin
    fsk_in_last <= fsk_in;
    
    if (fsk_in != fsk_in_last) begin
		if (periods_measured < PERIODS_TO_MEASURE) begin
			period_sum <= period_sum + counter;
			periods_measured <= periods_measured + 1;
		end
		counter <= 0;
    end else begin
        if (counter < COUNTER_MAX) begin
            counter <= counter + 1;
        end
    end

    if (periods_measured == PERIODS_TO_MEASURE) begin
        if (period_sum > THRESHOLD) begin
            data_out <= 0;  // 接收到比特0
        end else begin
            data_out <= 1;  // 接收到比特1
        end
        // 重置累加器和计数器
        period_sum <= 0;
        periods_measured <= 0;
    end
end

endmodule
