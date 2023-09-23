`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/23 20:53:44
// Design Name: 
// Module Name: JKFF
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


module JKFF(clk, J, K, Q);
input clk, J, K;
output reg Q;

always @(posedge clk)
begin
case({J, K})
2'b00 : Q <= Q;
2'b01 : Q <= 0;
2'b10 : Q <= 1;
2'b11 : Q <= ~Q;
endcase
end

endmodule
