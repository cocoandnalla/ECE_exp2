`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 00:17:44
// Design Name: 
// Module Name: counter
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


module counter(clk, rst, x, state);
input clk, rst;
input x;
wire x_trig;
output reg [3:0] state;

oneshot O1(clk, rst, x, x_trig);

always @(negedge rst or posedge clk) begin
if (!rst) state <= 4'b0000;
else begin
if(x_trig)
state <= state+1;
if(state == 4'b1001)
state <= 4'b0000;
end
end
endmodule
