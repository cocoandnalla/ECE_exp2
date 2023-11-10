`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/09 12:13:04
// Design Name: 
// Module Name: LED3_control_tb
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


module LED3_control_tb();
reg clk, rst;
reg [7:0] btn;

wire [3:0] led_signal_R;
wire [3:0] led_signal_G;
wire [3:0] led_signal_B;

LED3_control u0(clk, rst, btn, led_signal_R, led_signal_G, led_signal_B);
always begin
#5 clk <= ~clk;
end

initial begin
clk <=0; rst <= 1; btn <= 8'b0000_0000;
#2560    rst <= 0; btn <= 8'b0000_0001; // red
#2560    rst <= 0; btn <= 8'b0000_0010; // orange
#2560    rst <= 0; btn <= 8'b0000_0100; // yellow
#2560    rst <= 0; btn <= 8'b1000_0000; // white
end
endmodule
