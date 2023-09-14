`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 20:18:25
// Design Name: 
// Module Name: comparator_tb
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


module comparator_tb ();

reg [3:0] a, b;
wire x, y, z, k;

comparator u1(a, b, x, y, z, k);

initial begin
a = 4'b0011; b = 4'b1000; // a=3, b=8, x=0, y=1, z=0, k=1
#10 a = 4'b0111; b = 4'b0001; // a=7, b=1, x=0, y=1, z=1, k=0
#10 a = 4'b1001; b = 4'b1001; // a=9, b=9, x=1, y=0, z=0, k=0
#10 a = 4'b1011; b = 4'b1111; // a=11, b=15, x=0, y=1, z=0, k=1
end

endmodule
