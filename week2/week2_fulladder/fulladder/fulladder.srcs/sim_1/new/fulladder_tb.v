`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/09 17:43:36
// Design Name: 
// Module Name: fulladder_tb
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


module fulladder_tb();
reg x, y, Cin;
wire Cout, S;

fulladder u1(x, y, Cin, S, Cout);

initial begin
x = 0;  y = 0; Cin = 0;
#10 x = 0;  y = 0; Cin = 1;
#10 x = 0;  y = 1; Cin = 0;
#10 x = 1;  y = 0; Cin = 0;
#10 x = 0;  y = 1; Cin = 1;
#10 x = 1;  y = 0; Cin = 1;
#10 x = 1;  y = 1; Cin = 0;
#10 x = 1;  y = 1; Cin = 1;
end

endmodule
