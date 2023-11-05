`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 02:12:17
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk, rst;
reg x;
wire [7:0] seg_data;
wire [7:0] seg_sel;

seg_x u0(clk, rst, x, seg_data, seg_sel);

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
