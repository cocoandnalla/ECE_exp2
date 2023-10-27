`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 01:13:42
// Design Name: 
// Module Name: SM2_tb
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


module SM2_tb();
reg clk, rst;
reg A, B, C;
wire [2:0] state;
wire y;

SM2 u0(clk, rst, A, B, C, state, y);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; 
rst <= 0;
#20 rst <= 1; {A, B, C} = 3'b100;
#20 rst <= 1; {A, B, C} = 3'b010;
#20 rst <= 1; {A, B, C} = 3'b100; 
#20 rst <= 1; {A, B, C} = 3'b010;
#20 rst <= 1; {A, B, C} = 3'b001;
#20 rst <= 0; {A, B, C} = 3'b000;
#20 rst <= 1; {A, B, C} = 3'b100;
#20 rst <= 1; {A, B, C} = 3'b010;
#20 rst <= 1; {A, B, C} = 3'b001;
end
endmodule
