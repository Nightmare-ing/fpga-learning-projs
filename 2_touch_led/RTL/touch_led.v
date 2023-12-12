module touch_led (
    input wire [0:0] sys_clk;
    input wire [0:0] sys_rst;
    input wire [0:0] touch_key;
    output reg [0:0] led;
);

reg [0:0] touch_key_b0;
reg [0:0] touch_key_b1;
reg [0:0] touch_key_b2;
wire [0:0] detected_edge;
// posedge detection
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        touch_key_b0 <= 1'b0;
        touch_key_b1 <= 1'b0;
        touch_key_b2 <= 1'b0;
    end else begin
        touch_key_b0 <= touch_key;
        touch_key_b1 <= touch_key_b0;
        touch_key_b2 <= touch_key_b1;
    end
end

assign detected_edge = ~touch_key_b2 & touch_key_b1;

always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) 
        led <= 1'b0;
    else if (detected_edge) 
        led <= ~led;
end
endmodule