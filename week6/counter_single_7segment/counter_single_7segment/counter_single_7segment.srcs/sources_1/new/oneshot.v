`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 00:23:17
// Design Name: 
// Module Name: oneshot
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

module oneshot (clk, rst, x, x_trig);
input clk, rst;
input x;
reg x_reg;
output reg x_trig;

always @(negedge rst or posedge clk) begin
if(!rst) begin
{x_reg, x_trig} <= 2'b00;
end
else begin
x_reg <= x;
x_trig <= x & ~x_reg;
end
end
endmodule
