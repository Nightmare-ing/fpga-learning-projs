module beep_control(
    input wire [0:0] sys_clk,
    input wire [0:0] sys_rst,
    input wire [0:0] key,
    output reg [0:0] beep
);

reg [0:0] key_b0;
wire [0:0] edge_detected;

always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst)
        key_b0 <= 1'b1;
    else 
        key_b0 <= key;
end

assign edge_detected = ~key & key_b0;

always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst)
        beep <= 1'b1;
    else if (edge_detected)
        beep <= ~beep;
end
endmodule