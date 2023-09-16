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


module mux4to1(IN0, IN1, IN2, IN3, x, y, outcome);
input [3:0] IN0, IN1, IN2, IN3;
input x, y;
output [3:0] outcome;
reg [3:0] outcome;

always @(*) begin
case({x, y})
2'b00 : outcome = IN0;
2'b01 : outcome = IN1; 
2'b10 : outcome = IN2; 
2'b11 : outcome = IN3; 

endcase
end
endmodule
