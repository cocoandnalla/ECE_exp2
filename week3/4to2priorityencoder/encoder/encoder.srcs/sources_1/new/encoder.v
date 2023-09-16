`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 16:56:23
// Design Name: 
// Module Name: encoder
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


module encoder(a, x, valid);
input [3:0] a;
output [1:0] x;
output valid;
reg [1:0] x;
reg valid;

always @(*) begin
valid=1;
casex (a)
4'b1xxx : x = 2'b11; 
4'b01xx : x = 2'b10;
4'b001x : x = 2'b01;
4'b0001 : x = 2'b00;
default : begin 
x = 2'bx;
valid=0;
end
endcase
end
endmodule
