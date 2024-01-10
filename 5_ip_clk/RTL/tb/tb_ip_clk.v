`timescale 1ns/1ns

module tb_ip_clk ();

reg [0:0] sys_clk;
reg [0:0] sys_rst;

wire [0:0] clk_100m;
wire [0:0] clk_100m_delay_180;
wire [0:0] clk_50m;
wire [0:0] clk_25m;

parameter CLK_PERIOD = 20;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b1;
    #30
    sys_rst <= 1'b0;
    #200
    sys_rst <= 1'b1;
end

always #(CLK_PERIOD / 2) sys_clk <= ~sys_clk;

ip_clk ip_clk_inst(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .clk_100m (clk_100m),
    .clk_100m_delay_180 (clk_100m_delay_180),
    .clk_50m (clk_50m),
    .clk_25m (clk_25m)
);

endmodule