`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/23 21:50:50
// Design Name: 
// Module Name: TFFNOOS_tb
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


module TFFNOOS_tb();
reg clk, rst, T;
wire Q;

TFFNOOS FF(clk, rst, T, Q);

initial begin
clk <= 0;
rst <= 1;
#10 rst <= 0;
#10 rst <= 1;
#60 T <= 0;
#80 T <= 1;
#100 T <= 0;
#120 T <= 1;
#140 T <= 0;
#160 T <= 1;
#180 T <= 0;
end

always begin
#5 clk <= ~clk;
end

endmodule
