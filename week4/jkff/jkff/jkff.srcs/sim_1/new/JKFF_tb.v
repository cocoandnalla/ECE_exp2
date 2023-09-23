`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/23 21:05:22
// Design Name: 
// Module Name: JKFF_tb
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


module JKFF_tb();
reg clk, J, K;
wire Q;

JKFF FF(clk, J, K, Q);
initial begin
clk <= 0;
#30 J=0; K=0;
#30 J=0; K=1;
#30 J=0; K=0;
#30 J=1; K=0;
#30 J=0; K=0;
#30 J=1; K=1;
#30 J=0; K=0;
end

always begin
#5 clk <= ~clk;
end
endmodule
