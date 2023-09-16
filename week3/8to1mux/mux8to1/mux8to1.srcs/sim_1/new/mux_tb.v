`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 21:16:19
// Design Name: 
// Module Name: mux_tb
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


module mux_tb();

reg [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
reg x, y, z;
wire [3:0] OUT;

mux8to1 u0(I0, I1, I2, I3, I4, I5, I6, I7, x, y, z, OUT);

initial begin
I0 = 4'b0000; 
I1 = 4'b0001; 
I2 = 4'b0010; 
I3 = 4'b0011;
I4 = 4'b0100; 
I5 = 4'b0101; 
I6 = 4'b0110;
I7 = 4'b0111; 

    x = 0; y = 0; z = 0; 
#10 x = 0; y = 1; z = 0;
#10 x = 1; y = 0; z = 0; 
#10 x = 1; y = 1; z = 0; 
#10 x = 0; y = 0; z = 1; 
#10 x = 0; y = 1; z = 1; 
#10 x = 1; y = 0; z = 1; 
#10 x = 1; y = 1; z = 1; 
end

endmodule
