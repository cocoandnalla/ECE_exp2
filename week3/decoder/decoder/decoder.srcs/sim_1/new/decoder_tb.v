`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 20:46:47
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb();
reg  x, y, z;
wire a, b, c, d, e, f, g, h;

decoder u1(x, y, z, a, b, c, d, e, f, g, h);

initial begin
x = 0; y = 0; z = 0;
#10 x = 0; y = 0; z = 1;
#10 x = 0; y = 1; z = 0;
#10 x = 0; y = 1; z = 1;
#10 x = 1; y = 0; z = 0;
#10 x = 1; y = 0; z = 1;
#10 x = 1; y = 1; z = 0;
#10 x = 1; y = 1; z = 1;
end

endmodule
