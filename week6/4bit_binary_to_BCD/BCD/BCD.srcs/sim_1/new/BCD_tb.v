`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/03 23:28:36
// Design Name: 
// Module Name: BCD_tb
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


module BCD_tb();
reg clk, rst;
reg [3:0] bin;
wire [7:0] bcd;

BCD u0(clk, rst, bin, bcd);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; rst <= 0;
#20 rst <= 1; bin <= 0;
#20 rst <= 1; bin <= 1;
#20 rst <= 1; bin <= 2;
#20 rst <= 1; bin <= 3;
#20 rst <= 1; bin <= 4;
#20 rst <= 1; bin <= 5;
#20 rst <= 1; bin <= 6;
#20 rst <= 1; bin <= 7;
#20 rst <= 1; bin <= 8;
#20 rst <= 1; bin <= 9;
#20 rst <= 1; bin <= 10;
#20 rst <= 1; bin <= 11;
#20 rst <= 1; bin <= 12;
#20 rst <= 1; bin <= 13;
#20 rst <= 1; bin <= 14;
#20 rst <= 1; bin <= 15;
end
endmodule