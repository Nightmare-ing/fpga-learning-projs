module ip_clk (
    input wire [0:0] sys_clk,
    input wire [0:0] sys_rst,
    output wire [0:0] clk_100m,
    output wire [0:0] clk_100m_delay_180,
    output wire [0:0] clk_50m,
    output wire [0:0] clk_25m
);

wire locked;

clk_wiz_0 u_clk_wiz_0 (
// Clock out ports
    .clk_out1 (clk_100m),     // output clk_out1
    .clk_out2 (clk_100m_delay_180),     // output clk_out2
    .clk_out3 (clk_50m),     // output clk_out3
    .clk_out4 (clk_25m),     // output clk_out4
    // Status and control signals
    .reset (~sys_rst), // input reset
    .locked (locked),       // output locked
    // Clock in ports
    .clk_in1 (sys_clk));      // input clk_in1
    
endmodule