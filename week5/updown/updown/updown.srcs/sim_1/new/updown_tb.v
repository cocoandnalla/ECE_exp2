`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:43:38
// Design Name: 
// Module Name: updown_tb
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


module updown_tb();
reg clk, rst;
reg x;
wire [2:0] state;

updown u0(clk, rst, x, state);

always begin
#5 clk <= ~clk;
end

initial begin
clk <= 0; rst <= 0;
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
