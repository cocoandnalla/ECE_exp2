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
reg btn;
wire [7:0] seg;

counter_single_7segment u0(clk, rst, btn, seg);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; rst <=0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
#20 rst <= 1; btn <= 1;
#20 rst <= 1; btn <= 0;
end
endmodule
