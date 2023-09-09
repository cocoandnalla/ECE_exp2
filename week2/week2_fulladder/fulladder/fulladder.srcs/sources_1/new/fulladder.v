`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/09 17:16:09
// Design Name: 
// Module Name: fulladder
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


module fulladder(x, y, Cin, S, Cout);
input x, y, Cin;
output S, Cout;
wire c1, s1, c2;

halfadder HA1(x, y, c1, s1);
halfadder HA2(s1, Cin, c2, S);

assign Cout = c2 | c1;

endmodule
