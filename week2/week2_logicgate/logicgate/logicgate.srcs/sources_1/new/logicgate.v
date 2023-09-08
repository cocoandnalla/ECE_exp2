`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 10:43:37
// Design Name: 
// Module Name: logicgate
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


module logicgate(x, y, a, b, c, d, e);
input x, y;
output a, b, c, d, e;

assign a = x & y;
assign b = x | y;
assign c = x ^ y;
assign d = ~ (x | y);
assign e = ~ (x & y);
  
endmodule
