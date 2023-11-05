`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 21:20:24
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
reg btn;
wire [7:0] seg_data;
wire [7:0] seg_sel;


seg_array u0(clk, rst, btn, seg_data, seg_sel);

always begin
#10 clk <= ~clk;
end

initial begin
clk <= 0; rst <=0;
#45 rst <= 1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;
#10 rst <= 1; btn <= 0;
#160 rst<=1; btn <= 1;




end
endmodule
