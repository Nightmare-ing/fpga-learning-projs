`timescale 1ns/1ns

module tb_beep();
reg [0:0] sys_clk;
reg [0:0] sys_rst;
reg [0:0] key;
wire [0:0] beep;

parameter CNT_MAX = 20'd15;
parameter CLK_PERIOD = 20;

initial begin
    sys_clk <= 1'b0;
    sys_rst <= 1'b0;
    key <= 1'b1;
    #200
    sys_rst <= 1'b1;

    #40
    key <= 1'b0;
    #30
    key <= 1'b1;
    #30
    key <= 1'b0;
    #2000
    key <= 1'b1;
    #4000

    key <= 1'b0;
    #30
    key <= 1'b1;
    #30
    key <= 1'b0;
    #2000
    key <= 1'b1;
end

always #(CLK_PERIOD / 2) sys_clk <= ~sys_clk;

beep #(
    .CNT_MAX (CNT_MAX)) 
    u_beep (
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .key (key),
    .beep (beep)
);
endmodule