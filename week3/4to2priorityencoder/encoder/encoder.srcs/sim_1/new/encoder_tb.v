`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 17:15:15
// Design Name: 
// Module Name: encoder_tb
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


module encoder_tb();
reg [3:0] a;
wire [1:0] x;
wire valid;

encoder u1(a, x, valid);
initial begin
a = 4'b0000 ; 
#10 a = 4'b1000;
#10 a = 4'b1011; 
#10 a = 4'b0101;
#10 a = 4'b0001;

end
endmodule
