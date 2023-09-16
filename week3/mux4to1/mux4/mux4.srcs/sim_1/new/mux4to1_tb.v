`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 18:09:24
// Design Name: 
// Module Name: mux4to1_tb
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


module mux4to1_tb();
reg [1:0] I0, I1, I2, I3;
reg x, y;
wire [1:0] outcome;

mux4to1 u1(I0, I1, I2, I3, x, y, outcome);
initial begin
    I0 = 2'b00; I1 = 2'b01; I2 = 2'b10; I3 = 2'b11;
    x = 0; y = 0;
#10 I0 = 2'b00; I1 = 2'b01; I2 = 2'b10; I3 = 2'b11; 
    x = 0; y = 1;
#10 I0 = 2'b00; I1 = 2'b01; I2 = 2'b10; I3 = 2'b11;   
    x = 1; y = 0;
#10 I0 = 2'b00; I1 = 2'b01; I2 = 2'b10; I3 = 2'b11;
    x = 1; y = 1;

end
endmodule
