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
output reg [2:0] state;
reg up_count_enable; 
reg down_count_enable; 

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
if (!rst) begin
state <= 3'b000; 
up_count_enable <= 1'b1; 
down_count_enable <= 1'b0;
end else begin
if (x_trig)
if (up_count_enable) begin
state <= state + 1; 
if (state == 3'b110) begin
up_count_enable <= 1'b0; 
down_count_enable <= 1'b1; 
end
end else if (down_count_enable) begin
state <= state - 1; 
if (state == 3'b001) begin
up_count_enable <= 1'b1; 
down_count_enable <= 1'b0; 
end
end
end
end

endmodule