module key_debounce (
    input wire [0:0] sys_clk,
    input wire [0:0] sys_rst,
    input wire [0:0] key,
    output reg [0:0] key_filtered
);

parameter CNT_MAX = 20'd1000000;

reg [0:0] key_b0;
reg [0:0] key_b1;

// record beat of the key
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        key_b0 <= 1'b1;
        key_b1 <= 1'b1;
    end else begin
        key_b0 <= key;
        key_b1 <= key_b0;
    end
end

reg [14:0] cnt;
// count the key signal to keep 20ms
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) 
        cnt <= 20'd0;
    else if (key_b0 != key_b1) 
        cnt <= CNT_MAX;
    else if (cnt > 0)
        cnt <= cnt - 20'd1;
    else ;
end

// if the signal keeps for 20ms, record key signal
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst)
        key_filtered <= 1'b1;
    else if (cnt == 1)
        key_filtered <= key_b0;
    else ;
end
endmodule