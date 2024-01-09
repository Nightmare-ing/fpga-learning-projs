module breath_led (
    input wire [0:0] sys_clk;
    input wire [0:0] sys_rst;
    output reg [0:0] led;
);

parameter CNT_US_MAX = 7'd100;
parameter CNT_MS_MAX = 10'd1000;

reg [6:0] cnt_us;
reg [9:0] cnt_ms;
reg [0:0] proc_flag;

/* count 2ms with cnt_us */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt_us <= 7'd0;
    end
    if (cnt_us < CNT_US_MAX) begin
        cnt_us <= cnt_us + 7'b1;
    end else begin
        cnt_us <= 7'd0;
    end
end

/* count 2s with cnt_ms */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt_ms <= 10'd0;
        proc_flag <= 1'd0;
    end
    if (cnt_ms < CNT_MS_MAX) begin
        if (cnt_us == CNT_US_MAX - 7'd1)begin
            cnt_ms <= cnt_ms + 10'd1;
        end
    end else begin
        cnt_ms <= 10'd0;
        proc_flag <= ~proc_flag;
    end
    
/* control led */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        led <= 1'd0;
    end
    if (cnt_us < cnt_ms) begin
        led <= ~proc_flag;
    end else begin
        led <= proc_flag;
    end
end
endmodule