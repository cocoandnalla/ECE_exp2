`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/11 22:26:29
// Design Name: 
// Module Name: text_LCD_shift
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
////////////////////////////////////////////////////////////////////////////////

module text_LCD_shift(clk, rst, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out);
input clk, rst;

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;
output reg [7:0] LED_out;

wire LCD_E;
reg LCD_RS, LCD_RW;

reg [2:0] state;
parameter DELAY        = 3'b000;
parameter FUNCTION_SET = 3'b001;
parameter ENTRY_MODE   = 3'b010;
parameter DISP_ONOFF   = 3'b011;
parameter LINE1        = 3'b100;
parameter LINE2        = 3'b101;
parameter DELAY_T      = 3'b110;
parameter SHIFT        = 3'b111; // difference

integer cnt;
integer can_shift; 

always @(posedge clk or negedge rst) 
begin
    if(!rst) begin
    state = DELAY; 
    cnt = 0;
    end
    else begin
        case(state)
        DELAY : begin
            LED_out = 8'b1000_0000;
            if(cnt >= 70) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 70) state = FUNCTION_SET;
    end
        FUNCTION_SET : begin
            LED_out = 8'b0100_0000;
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = DISP_ONOFF;
    end
        DISP_ONOFF : begin
            LED_out = 8'b0010_0000;
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = ENTRY_MODE;
    end
        ENTRY_MODE : begin
            LED_out = 8'b0001_0000;
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = LINE1;
    end
        LINE1 : begin
            LED_out = 8'b0000_1000;
            if(cnt >= 40) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 40) state = LINE2;
    end
        LINE2 : begin
            LED_out = 8'b0000_0100;
            if(cnt >= 40) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 40) state = DELAY_T;
    end
        DELAY_T : begin
            LED_out = 8'b0000_0010;
            if(cnt >= 5) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 5) state = SHIFT;
    end
        SHIFT : begin
            LED_out = 8'b0000_0001;
            cnt = 0;
            if(cnt == 0) state = SHIFT;
    end
    default : state = DELAY;
        endcase
    end
end

always @(posedge clk or negedge rst) 
begin
    if(!rst) begin
    {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_00000000;
    can_shift = 0;
    end
    else begin
        case(state)
        FUNCTION_SET :
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1100; 

        DISP_ONOFF : 
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_1100;

        ENTRY_MODE : 
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0111; // cursor right // display shift -> shift enable

        LINE1 :
        begin
            case(cnt)
            00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000; // starting point (LINE1_leftmost = 7'b100_0000(0))
            01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1000; // H
            03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; // E
            04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
            05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
            06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1111; // O
            07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0111; // W
            09 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1111; // O
            10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0010; // R
            11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
            12 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0100; // D
            13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0001; // !
            14 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            15 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            16 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            endcase
        end

        LINE2 :
        begin
            case(cnt)
            00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1100_0000; // starting point (LINE2_leftmost = 7'b100_0000(64))
            01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; // 2
            02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
            03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; // 2
            04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; // 2
            05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; // 4
            06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; // 4
            07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
            08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
            09 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; // 5
            10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; // 6
            11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            12 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0000; // P
            13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1010; // J
            14 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0111; // W
            15 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            16 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            endcase
        end
    
        DELAY_T :
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0010;

        SHIFT :
        begin
            if(can_shift >= 250) begin
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0001_1000;
                can_shift = 0;
            end
            else begin
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0001_1000;
                can_shift=can_shift+1;
            end
        end               
        
        default :
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0000_0000;
        endcase
    end
end

assign LCD_E = clk;
endmodule
