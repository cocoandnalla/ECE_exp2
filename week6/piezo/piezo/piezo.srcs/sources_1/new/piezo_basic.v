`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 18:20:42
// Design Name: 
// Module Name: piezo_basic
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


module piezo_basic(clk, rst, btn, piezo);
input clk, rst;
input [7:0] btn;
output reg piezo;
//��׵��� state�� �� '1MHz/���ļ�'
parameter do = 12'd3830; // 3830�� '��'�� ���ֱ�
parameter re = 12'd3400;
parameter mi = 12'd3038;
parameter pa = 12'd2864;
parameter sol = 12'd2550;
parameter ra = 12'd2272;
parameter si = 12'd2028;
parameter high_do = 12'd1912;

reg [11:0] cnt;
reg [11:0] cnt_limit;

always @(btn) begin
if(!rst) cnt_limit = 0;
else begin
case(btn) // btn�� ���������� ���� state�� ���� ����
8'b00000001 : cnt_limit = do;
8'b00000010 : cnt_limit = re;
8'b00000100 : cnt_limit = mi;
8'b00001000 : cnt_limit = pa;
8'b00010000 : cnt_limit = sol;
8'b00100000 : cnt_limit = ra;
8'b01000000 : cnt_limit = si;
8'b10000000 : cnt_limit = high_do;
default : cnt_limit = 0;
endcase
end
end

always @(posedge clk or negedge rst) begin
if(!rst) begin // just �ʱ�ȭ
cnt = 0;
piezo = 0;
end
else if (cnt > cnt_limit/2) begin // �ϴ� cnt�� 0 state/2 (ex btn '��' �����ٰ� ����) = 1700 ���� ����ؼ� piezo ��� �����ϰ� 66��° �ٿ��� cnt�� ����ؼ� +1�� ����, 1700���� Ŀ���� cnt �ʱ�ȭ 
piezo = ~piezo; // piezo ��� ����
cnt = 0; // cnt �ʱ�ȭ 
end
else cnt = cnt + 1; // cnt <= state/2 (1700) �̸� ����ؼ� 1�߰����� , �̰� 1�ʿ� 294�� (294Hz) �ݺ��ϴ� ����
end


endmodule
