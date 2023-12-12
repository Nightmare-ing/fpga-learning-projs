`timescale 1ns/1ns
module tb_touch_led();
reg [0:0] sys_clk;
reg [0:0] sys_rst;
reg [0:0] touch_key;
wire [0:0] led;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b0;
    touch_key <= 1'b0;
    #200
    sys_rst <= 1'b1;
    #200
    touch_key <= 1'b1;
    #1000 
    touch_key <= 1'b0;
end

touch_led u_touch_led(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .touch_key (touch_key),
    .led (led)
);
endmodule