`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 02:40:51
// Design Name: 
// Module Name: updown
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


module updown(clk, rst, x, state);
input clk, rst;
input x;
reg x_reg, x_trig;
output reg [2:0] state;

always @(negedge rst or posedge clk) begin
if(!rst) begin
{x_reg, x_trig} <= 2'b00;
end
else begin  
x_reg <= x;
x_trig <= x & ~x_reg;
end
end

always @(negedge rst or posedge clk) begin
if(!rst) state <= 3'b000; 
else 
if (x_trig) state = state + 1;
else state = state - 1;  
end
endmodule
