`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:43:16
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
reg [3:0] a=0;
output reg [2:0] state;

always @(negedge rst or posedge clk)begin
if(!rst) begin
{x_reg, x_trig} <= 2'b00;
end
else begin 
x_reg <= x;
x_trig <= x & ~x_reg;
end
end

always @(negedge rst or posedge clk)begin
if(!rst) state <= 3'b000;
else begin
if(x_trig)
a <= a + 1;
if(a <= 7)
state <= state+1;
else if(a>7 && a <= 14)
state <= state-1;
else
a <= 0;
end
end
endmodule