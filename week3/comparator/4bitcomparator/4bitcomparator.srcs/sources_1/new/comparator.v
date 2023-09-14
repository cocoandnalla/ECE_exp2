`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 14:11:23
// Design Name: 
// Module Name: comparator
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


module comparator(a, b, x, y, z, k);
input [3:0] a, b; // PORTS a[0] : Y1, a[1] : W3, a[2] : U2, a[3] : T1, b[0] : W4, b[1] : W1, b[2] : V4, b[3] : U4
output x, y, z, k; // PORTS x = L4, y = M4, z = M2, k = N7 

assign x = (a == b) ? 1'b1 : 1'b0;
assign y = (a != b) ? 1'b1 : 1'b0;
assign z = (a > b) ? 1'b1 : 1'b0;
assign k = (a < b) ? 1'b1 : 1'b0;




endmodule
