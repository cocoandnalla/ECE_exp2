`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/24 18:37:09
// Design Name: 
// Module Name: TFF_oneshot_tb
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


module TFF_oneshot_tb();
reg clk, rst, T;
wire Q;

TFF_oneshot FF(clk, rst, T, Q);

initial begin 
clk <= 0;
rst <= 1;
T <= 0;
#10 rst <= 0;
#10 rst <= 1;
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
