`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/10 00:19:42
// Design Name: 
// Module Name: halfadder_case
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


module halfadder_case(x, y, c, s);
input x, y;
output c, s;
reg c, s; 

always @(*) begin
case ( {x, y} )
2'b00 : begin c = 0; s = 0; end
2'b01 : begin c = 0; s = 1; end
2'b10 : begin c = 0; s = 1; end
2'b11 : begin c = 1; s = 0; end

endcase
end
endmodule
