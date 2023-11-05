`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 01:37:26
// Design Name: 
// Module Name: oneshot
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


module oneshot(clk, rst, x, x_trig);
parameter WIDTH = 1;
input clk, rst, x;
reg [WIDTH-1 : 0] x_reg;
output reg [WIDTH-1 :0] x_trig;

always @(negedge rst or posedge clk) begin
    if(!rst) begin
        x_reg <= {WIDTH{1'b0}};
        x_trig <= {WIDTH{1'b0}};
    end
end
endmodule
