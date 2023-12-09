`timescale 1ns/1ns

module tb_flow_led();
reg [0:0] sys_clk;
reg [0:0] sys_rst;

wire [1:0] led;

parameter CLK_PERIOD = 20;
parameter CNT_MAX = 25'd25;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b0;
    #210
    sys_rst <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk <= ~sys_clk;

flow_led #(CNT_MAX) flow_led_target(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .led (led)
);
endmodule