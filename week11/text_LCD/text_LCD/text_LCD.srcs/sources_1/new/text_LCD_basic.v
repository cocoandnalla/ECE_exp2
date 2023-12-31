`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/09 13:46:01
// Design Name: 
// Module Name: text_LCD_basic
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


module text_LCD_basic(rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out);

input clk, rst;

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;
output reg [7:0] LED_out;

wire LCD_E;
reg LCD_RS, LCD_RW;

reg [2:0] state;
parameter DELAY        = 3'b000; //0
parameter FUNCTION_SET = 3'b001; //1
parameter ENTRY_MODE   = 3'b010; //2
parameter DISP_ONOFF   = 3'b011; //3
parameter LINE1        = 3'b100; //4
parameter LINE2        = 3'b101; //5
parameter DELAY_T      = 3'b110; //6
parameter CLEAR_DISP   = 3'b111; //7

integer cnt;

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
            if(cnt >= 20) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 20) state = LINE2;
    end
        LINE2 : begin
            LED_out = 8'b0000_0100;
            if(cnt >= 20) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 20) state = DELAY_T;
    end
        DELAY_T : begin
            LED_out = 8'b0000_0010;
            if(cnt >= 5) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 5) state = CLEAR_DISP;
    end
        CLEAR_DISP : begin
            LED_out = 8'b0000_0001;
            if(cnt >= 5) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 5) state = FUNCTION_SET;
    end
    default : state = DELAY;
        endcase
    end
end
    

always @(posedge clk or negedge rst) 
begin
    if(!rst)
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_00000000;
    else begin
        case(state)
            FUNCTION_SET : 
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;

            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_1100;

            ENTRY_MODE : // cursor up(1) / down(0) (I/D), display shift(1) (S)
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0110;

        LINE1 :
            begin
                case(cnt)
                00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000; // starting point (LINE1_leftmost= 7'b000_0000(0)) // 3-shift (10'b0_0_1000_0011)
                01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1000; // H
                02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; // E
                03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
                04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
                05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1111; // O
                06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
                07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0111; // W
                08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1111; // O
                09 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0010; // R
                10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1100; // L
                11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0100; // D
                12 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0001; // !
                13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
                14 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
                15 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
                16 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
                default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // blank
            endcase
        end

        LINE2 :
            begin
                case(cnt)
                00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1100_0000; // starting point (LINE2_leftmost = 7'b100_0000(64)) // 3-shift (10'b0_0_1100_0011)
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

        CLEAR_DISP : // delete everyting, cursor to home and address counter DD-RAM address -> 0 
            {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0001;
        default :
            {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0000_0000;
        endcase
    end
end

assign LCD_E = clk;

endmodule
