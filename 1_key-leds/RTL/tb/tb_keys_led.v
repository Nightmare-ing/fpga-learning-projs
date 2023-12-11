`timescale 1ns/1ns
module tb_keys_led();

reg [0:0] sys_clk;
reg [0:0] sys_rst;
reg [1:0] keys;
wire [1:0] leds;


parameter CLK_PERIOD = 20;
parameter FLASH_PERIOD = 25'd25;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b0;
    keys <= 2'b11;
    #210
    sys_rst <= 1'b1;
    #1000
    keys <= 2'b10;
    #1000
    keys <= 2'b01;
end

// generate clk signal
always #(CLK_PERIOD / 2) sys_clk <= ~sys_clk;

keys_led #(FLASH_PERIOD) u_keys_led(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .keys (keys),
    .leds (leds)
);
endmodule