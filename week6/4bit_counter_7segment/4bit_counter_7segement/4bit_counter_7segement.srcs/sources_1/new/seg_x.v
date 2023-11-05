`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 01:48:32
// Design Name: 
// Module Name: seg_x
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


module seg_x(clk, rst, x, seg_data, seg_sel);
input clk, rst;
input x;
wire [9:0] x_trig;
reg [3:0] state_bin;
wire [7:0] state_bcd;
output reg [7:0] seg_data;
output reg [7:0] seg_sel;
reg [3:0] BCD;

oneshot #(.WIDTH(1)) O1(clk, rst, x, x_trig);
BCD B1(clk, rst, state_bin[3:0], state_bcd[7:0]);

always @(negedge rst or posedge clk) begin
if (!rst) state_bin <= 4'b0000;
else if(state_bin == 4'b1001 && x_trig == 1) state_bin <=4'b0000;
else if (x_trig == 1) state_bin <= state_bin +1;
end

always @(negedge rst or posedge clk) begin
    if(!rst) seg_sel <=8'b11111110;
    else begin
        seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end
end

always @(*) begin
    case (BCD[3:0])
        0 : seg_data = 8'b11111100;
        1 : seg_data = 8'b01100000;
        2 : seg_data = 8'b11011010;
        3 : seg_data = 8'b11110010;
        4 : seg_data = 8'b01100110;
        5 : seg_data = 8'b10110110;
        6 : seg_data = 8'b10111110;
        7 : seg_data = 8'b11100000;
        8 : seg_data = 8'b11111110;
        9 : seg_data = 8'b11110110;
        default : seg_data <= 8'b00000000;
        endcase
    end


always @(*) begin
        case(seg_sel)
        8'b11111110 : BCD = state_bcd[3:0];
        8'b11111101 : BCD = state_bcd[7:4];
        8'b11111011 : BCD = 4'b0000;
        8'b11110111 : BCD = 4'b0000;
        8'b11101111 : BCD = 4'b0000;
        8'b11011111 : BCD = 4'b0000;
        8'b10111111 : BCD = 4'b0000;
        8'b01111111 : BCD = 4'b0000;
        endcase
    end
endmodule
