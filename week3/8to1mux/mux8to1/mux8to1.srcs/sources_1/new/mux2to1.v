`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 21:09:29
// Design Name: 
// Module Name: mux2to1
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


module mux2to1(in0, in1, control, out);
input [3:0] in0, in1;
input control;
output [3:0] out;
reg [3:0] out;

always @(*) begin
case (control)
1'b0 : out = in0;
1'b1 : out = in1; 
endcase
end
 
endmodule
