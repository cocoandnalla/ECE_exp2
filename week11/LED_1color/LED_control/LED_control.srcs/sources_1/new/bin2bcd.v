`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/06 04:57:49
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(clk, rst, bin, bcd_out); // 8bit binary to BCD
input clk, rst;
input [7:0] bin;
reg [11:0] bcd;
output reg [11:0] bcd_out;

reg [2:0] i;

always @(posedge rst or posedge clk) begin
    if(rst) begin
        bcd <= {4'd0, 4'd0, 4'd0}; // ?씪?떒 BCD ?뀑 紐⑤몢 0, 0, 0 ?쑝濡? 珥덇린?솕
        i <= 0;
    end
    else begin
        if(i == 0) begin
            bcd [11:1] <= 11'b0000_0000_000;
            bcd [0] <= bin[7];
        end
        else begin
            bcd [11:9] <= (bcd[11:8] >= 3'd5) ? bcd[11:8] +2'd3 : bcd[11:8]; // 일단 BCD 셋 모두 0, 0, 0 으로 초기화
            bcd [8:5] <= (bcd[7:4] >= 3'd5) ? bcd[7:4] +2'd3 : bcd[7:4];
            bcd [4:1] <= (bcd[3:0] >= 3'd5) ? bcd[3:0] +2'd3 : bcd[3:0];
            bcd[0] <= bin[7-i]; // bin의 첫번째 값부터 마지막값까지 순서대로 bcd[0]에 넣어짐
        end
        i <= i + 1; // i 계속 증가해서 결국 [2:0](3bit) 7까지
    end
end

always @(posedge rst or posedge clk) begin
    if(rst) bcd_out <= {4'd0, 4'd0, 4'd0};
    else if (i == 0) bcd_out <= bcd;
end
endmodule
