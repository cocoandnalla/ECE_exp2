`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/12 00:08:17
// Design Name: 
// Module Name: DAC_tb
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


module DAC_tb();

reg clk, rst;
reg [5:0] btn;
reg add_sel;

wire dac_csn, dac_ldacn, dac_wrn, dac_a_b;
wire [7:0] dac_d;
wire [7:0] led_out;

DAC u0(clk, rst, btn, add_sel, dac_csn, dac_ldacn, dac_wrn, dac_a_b, dac_d, led_out);

always begin
#5 clk <= ~clk;
end

initial begin
clk <=0; rst <= 1; btn <= 6'b0000_00;
#250 rst <= 0; btn <= 6'b0000_01;
#250 rst <= 0; btn <= 6'b0000_10;
#250 rst <= 0; btn <= 6'b0001_00;
#250 rst <= 0; btn <= 6'b0010_00;
#250 rst <= 0; btn <= 6'b0100_00;
#250 rst <= 0; btn <= 6'b1000_00;

end
endmodule
