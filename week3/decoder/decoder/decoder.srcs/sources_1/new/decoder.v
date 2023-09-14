`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 20:32:06
// Design Name: 
// Module Name: decoder
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


module decoder(x ,y, z, a, b, c, d, e, f, g, h);
input x, y, z; // x = y1, y = w3, z = u2 
output a, b, c, d, e, f, g, h; // a = L4, b=M4, c=M2, d=n7, e=m7, f=m3, g=m1 ,h=n5

assign a = (~x) & (~y) & (~z);
assign b = (~x) & (~y) & z;
assign c = (~x) & y & (~z);
assign d = (~x) & y & z;
assign e = x & (~y) & (~z);
assign f = x & (~y) & z;
assign g = x & y & (~z);
assign h = x & y & z;



endmodule
