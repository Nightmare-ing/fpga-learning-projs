`timescale 1ns/1ns

module tb_breath_led ();

reg [0:0] sys_clk;
reg [0:0] sys_rst;

wire [0:0] led;

parameter CLK_PERIOD = 20;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b0;
    #200
    sys_rst <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk <= ~sys_clk;

breath_led breath_led_inst(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .led (led)
);
endmodule