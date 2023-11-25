`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/17 14:00:16
// Design Name: 
// Module Name: text_tb
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

module text_LCD_2_tb();
reg clk, rst, switch;
reg [9:0] number_btn;
reg [1:0] control_btn;

wire LCD_E, LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0] LED_out;

text_LCD_2 u0(clk, rst, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out, number_btn, control_btn, switch);

always begin
#1 clk <= ~clk;
end

initial begin
clk <=0; rst <= 0; number_btn <= 10'b0_0_0000_0000; control_btn <= 2'b00;
#320 rst <= 1; number_btn <= 10'b0_0_0000_0000; control_btn <= 2'b00;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;
#320  rst <= 1; number_btn <= 10'b0_0_0000_0010; control_btn <= 2'b01;



end
endmodule