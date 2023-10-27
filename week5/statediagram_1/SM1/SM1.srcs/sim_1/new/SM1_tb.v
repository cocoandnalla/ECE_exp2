`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/27 20:34:53
// Design Name: 
// Module Name: SM1_tb
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


module SM1_tb();
reg clk, rst, x;
wire [1:0] state;
wire y;

SM1 u0 (clk, rst, x, state, y);

always begin
#5 clk <= ~clk;
end

initial begin
clk = 0; 
rst = 0;
#10 rst = 1; x = 1; // (01 / 0)

#10 rst = 0;
#10 rst=1; x = 1; // (01 / 0)
#10 rst=1; x = 0; // (00 / 1)

#10 rst = 0;
#10 rst=1; x = 1; // (01 / 0)
#10 rst=1; x = 1; // (11 / 0)

#10 rst = 0;
#10 rst=1; x = 1; // (01 / 0)
#10 rst=1; x = 1; // (11 / 0)
#10 rst=1; x = 1; // (10 / 0)
#10 rst=1; x = 0; // (00 / 1)

#10 rst = 0;
#10 rst=1; x = 1; // (01 / 0)
#10 rst=1; x = 1; // (11 / 0)
#10 rst=1; x = 1; // (10 / 0)
#10 rst=1; x = 1; // (10 / 0)

#10 rst = 0;
#10 rst=1; x = 1; // (01 / 0)
#10 rst=1; x = 1; // (11 / 0)
#10 rst=1; x = 0; // (00 / 1)

#10 rst = 0;
end

endmodule
