`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 21:25:59
// Design Name: 
// Module Name: seg_array
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


module seg_array(clk, rst, btn, seg_data, seg_sel);
input clk, rst;
input btn;
wire btn_trig;
reg [3:0] state_bin;
wire [7:0] state_bcd;
output reg [7:0] seg_data;
output reg [7:0] seg_sel; // 몇번째 LED ON 할 건지 정함
reg [3:0] bcd; // state_bcd(from bin2bcd) 저장하려고

oneshot_universal #(.WIDTH(1)) O1(clk, rst, btn, btn_trig); // 원샷트리거
bin2bcd B1(clk, rst, state_bin[3:0], state_bcd[7:0]); // binary to BCD

always @(negedge rst or posedge clk) begin // 4bit 'state_bin' counter 
if (!rst) state_bin <= 4'b0000;
else if (state_bin == 4'b1111 && btn_trig == 1) state_bin <= 4'b0000;
else if (btn_trig) state_bin <= state_bin + 1;
end // ㅇㅋ

always @(negedge rst or posedge clk) begin // sel을 옮기는 작업 '0'에 해당하는 위치가 LED ON
if (!rst) seg_sel <= 8'b11111110;
else begin
    seg_sel <= {seg_sel[6:0], seg_sel[7]}; // clock마다 왼쪽에 위치한 LED를 ON하고 원래 ON은 OFF로 변경
end
end // ㅇㅋ

always @(*) begin
    case (seg_sel)
    8'b11111110 : bcd = state_bcd[3:0]; // 제일 오른쪽 seg_sel이 켜지는 경우 bcd를 state_bcd [3:0]의 값을 저장함
    8'b11111101 : bcd = state_bcd[7:4]; // 오른쪽에서 두번째 seg_sel이 켜지는 경우 bcd를 state_bcd [7:4]의 값을 저장함
    8'b11111011 : bcd = 4'b0000; // 최대 15라서 나머지 LED는 OFF
    8'b11110111 : bcd = 4'b0000;
    8'b11101111 : bcd = 4'b0000;
    8'b11011111 : bcd = 4'b0000;
    8'b10111111 : bcd = 4'b0000;
    8'b01111111 : bcd = 4'b0000;
    default : bcd = 4'b0000;
    endcase
end

always @(*) begin
    case (bcd[3:0]) // 저장된 bcd [3:0]의 값이 왼쪽이면 seg_data에 LED에 숫자를 표현할 오른쪽을 저장함 aka 7segment에 어느 부분을 ON / OFF할지 정함 
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
    default : seg_data = 8'b00000000;
    endcase
end
endmodule
