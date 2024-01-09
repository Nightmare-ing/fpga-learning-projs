module breath_led (
    input wire [0:0] sys_clk,
    input wire [0:0] sys_rst,
    output reg [0:0] led
);

parameter CNT_2US_MAX = 7'd100;
parameter CNT_2MS_MAX = 10'd1000;
parameter CNT_2S_MAX = 10'd1000;

reg [6:0] cnt_2us;
reg [9:0] cnt_2ms;
reg [9:0] cnt_2s;
reg [0:0] proc_flag;

/* count 2us with cnt_2us */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt_2us <= 7'd0;
    end else if (cnt_2us < CNT_2US_MAX - 7'd1) begin
        cnt_2us <= cnt_2us + 7'd1;
    end else begin
        cnt_2us <= 7'd0;
    end
end

/* count 2ms with cnt_2ms */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt_2ms <= 10'd0;
    end else if (cnt_2ms < CNT_2MS_MAX - 10'd1) begin
        if (cnt_2us == CNT_2US_MAX - 7'd1)begin
            cnt_2ms <= cnt_2ms + 10'd1;
        end
    end else begin
        cnt_2ms <= 10'd0;
    end
end

/* count 2s with cnt_2s */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt_2s <= 10'd0;
        proc_flag <= 1'd0;
    end else if (cnt_2s < CNT_2S_MAX - 10'd1) begin
        if (cnt_2ms == CNT_2MS_MAX - 10'd1) begin
            cnt_2s <= cnt_2s + 10'd1;
        end
    end else begin
        cnt_2s <= 10'd0;
        proc_flag <= ~proc_flag;
    end
end
    
/* control led */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        led <= 1'd0;
    end else if (cnt_2ms < cnt_2s) begin
        led <= ~proc_flag;
    end else begin
        led <= proc_flag;
    end
end
endmodule