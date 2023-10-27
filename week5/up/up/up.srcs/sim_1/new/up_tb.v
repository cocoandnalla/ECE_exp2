`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 03:20:25
// Design Name: 
// Module Name: up_tb
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


module up_tb();
reg clk, rst;
reg x;
wire [1:0] state;

up u0(clk, rst, x, state);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; rst <=0;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
#20 rst <= 1; x <= 0;
#20 rst <= 1; x <= 1;
end
endmodule
