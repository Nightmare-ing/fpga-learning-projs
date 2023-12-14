module beep(
    input wire [0:0] sys_clk,
    input wire [0:0] sys_rst,
    input wire [0:0] key,
    output wire [0:0] beep
);

wire [0:0] key_filtered;
parameter CNT_MAX = 20'd1000000;

key_debounce #(
    .CNT_MAX (CNT_MAX)) 
    u_key_debounce (
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .key (key),
    .key_filtered (key_filtered)
);

beep_control u_beep_control(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .key (key_filtered),
    .beep (beep)
);
endmodule