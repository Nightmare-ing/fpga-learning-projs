module keys_led (
    input wire [0:0] sys_clk;
    input wire [0:0] sys_rst;
    input wire [1:0] keys;
    output reg [1:0] leds;
);

parameter FLASH_PERID = 25'd25000000;
parameter CNT_MAX = FLASH_PERID - 25'd1;

reg [0:0] flash_flag;

// count for 0.5s
reg [24:0] cnt;
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst)
        cnt <= 25'd0;
    else if (cnt < CNT_MAX) 
        cnt <= cnt + 1;
    else begin
        cnt <= 25'd0;
        flash_flag <= ~flash_flag;
    end
end

// change the content of leds
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) 
        leds <= 2'b00;
    else case (keys)
        2'b11: leds <= 2'b00;
        2'b10: begin
            if (flash_flag)
                leds <= 2'b10;
            else 
                leds <= 2'b01;
        end
        2'b01: begin
            if (flash_flag)
                leds <= 2'b00;
            else
                leds <= 2'b11;
        end
        default: ;
    endcase
end
endmodule