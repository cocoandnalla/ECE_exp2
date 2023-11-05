`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 00:41:55
// Design Name: 
// Module Name: seg_tb
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


module seg_tb();
reg clk, rst;
reg x;
wire [7:0] seg;

counter_single_7segment u0(clk, rst, x, seg);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; rst <=0;
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
end
endmodule
