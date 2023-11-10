`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/06 05:30:48
// Design Name: 
// Module Name: control_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_tb();
reg clk, rst;
reg [7:0] bin;

wire [7:0] seg_data;
wire [7:0] seg_sel;
wire led_signal;

LED_control u0(clk, rst, bin, seg_data, seg_sel, led_signal);

always begin
#0.5 clk <= ~clk;
end

initial begin
clk <=0; rst <= 1; bin <= 8'b0000_0000;
#2560 rst<=0; bin <= 8'b0000_0000;
#2560 rst<=0; bin <= 8'b0011_1111;
#2560 rst<=0; bin <= 8'b0111_1111;
#2560 rst<=0; bin <= 8'b1011_1111;
#2560 rst<=0; bin <= 8'b1111_1111;
end
endmodule
