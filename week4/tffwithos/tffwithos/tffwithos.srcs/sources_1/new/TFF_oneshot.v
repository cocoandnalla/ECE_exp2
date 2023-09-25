`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/24 18:04:36
// Design Name: 
// Module Name: TFF_oneshot
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


module TFF_oneshot(clk, rst, T, Q);

input T, clk, rst;
reg T_reg, T_trig;
output reg Q;

always @(negedge rst or posedge clk) begin
if(!rst) begin
Q <= 1'b0;
T_reg <= 1'b0;
T_trig <= 1'b0;
end
else begin
T_trig <= T & ~T_reg;
T_reg <= T;
if(T_trig)
Q<=~Q;
end
end
endmodule
