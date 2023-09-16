`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 21:00:12
// Design Name: 
// Module Name: mux8to1
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


module mux8to1(I0, I1, I2, I3, I4, I5, I6, I7, x, y, z, outcome);

input [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
input x, y, z;
output [3:0] outcome;
wire w1, w2;

mux4to1 MUX4_1(I0, I1, I2, I3, x, y, w1);
mux4to1 MUX4_2(I4, I5, I6, I7, x, y, w2);

mux2to1 MUX2(w1, w2, z, outcome);
endmodule
