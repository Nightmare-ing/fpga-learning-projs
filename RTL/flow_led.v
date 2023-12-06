module flow_led (
    input sys_clk,
    input sys_rst,

    output reg [1:0] led
);

reg [24:0] cnt;
parameter FLASH_PERIOD = 25'd25;


/* Count until time reach FLASH_PERIOD */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        cnt <= 25'd0;
    end
    else if (cnt < FLASH_PERIOD - 25'd1) begin
        cnt <= cnt + 25'd1;
    end
    else begin
        cnt <= 25'd0;
    end
end

/* Control the led reg to flash */
always @(posedge sys_clk or negedge sys_rst) begin
    if (!sys_rst) begin
        led <= 2'b01;
    end
    else if (cnt == FLASH_PERIOD - 25'd1) begin
        led <= {led[0], led[1]};
    end
    else;
end
    
endmodule