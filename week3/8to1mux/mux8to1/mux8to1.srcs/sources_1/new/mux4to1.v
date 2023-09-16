`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 20:59:56
// Design Name: 
// Module Name: mux4to1
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


module mux4to1(I0, I1, I2, I3, x, y, outcome);
input [3:0] I0, I1, I2, I3;
input x, y;
output [3:0] outcome;
reg [3:0] outcome;

always @(*) begin
case({x, y})
2'b00 : outcome = I0;
2'b01 : outcome = I1; 
2'b10 : outcome = I2; 
2'b11 : outcome = I3; 

endcase
end
endmodule
