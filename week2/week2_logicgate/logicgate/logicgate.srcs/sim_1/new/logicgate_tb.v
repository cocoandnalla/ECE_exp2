`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 21:58:20
// Design Name: 
// Module Name: logicgate_tb
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


module logicgate_tb();
reg x, y;
wire a, b, c, d, e;

logicgate u1(x, y, a, b, c, d, e);

initial begin

x = 0; y = 0;

#20 x = 0; y = 1;
#20 x = 1; y = 0;
#20 x = 1; y = 1;
end
endmodule
