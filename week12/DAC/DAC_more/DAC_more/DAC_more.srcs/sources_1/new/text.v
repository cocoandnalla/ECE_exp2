`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/17 15:52:22
// Design Name: 
// Module Name: text
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


module text(rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA, number_btn);

input clk, rst;
input [9:0] number_btn;

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;

wire LCD_E;
reg LCD_RS, LCD_RW;
reg [7:0] dac_d_temp;
wire [11:0] bcd_out;
reg [2:0] state;

parameter DELAY        = 4'b0000; 
parameter FUNCTION_SET = 4'b0001; 
parameter ENTRY_MODE   = 4'b0010; 
parameter DISP_ONOFF   = 4'b0011;
parameter LETTER1      = 4'b0100; 
parameter LETTER2      = 4'b0101; 
parameter LETTER3      = 4'b0110;
parameter DELAY_T      = 4'b0111; 
parameter CLEAR_DISP   = 4'b1000; 

integer cnt;

bin2bcd B2(clk, rst, dac_d_temp, bcd_out);

always @(posedge clk or negedge rst) 
begin
    if(!rst) begin
    state = DELAY; 
    cnt = 0;
    end
    else begin
        case(state)
        DELAY : begin
            if(cnt >= 70) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 70) state = FUNCTION_SET;
    end
        FUNCTION_SET : begin
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = DISP_ONOFF;
    end
        DISP_ONOFF : begin
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = ENTRY_MODE;
    end
        ENTRY_MODE : begin
            if(cnt >= 30) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 30) state = LETTER1;
    end
        LETTER1 : begin
            if(cnt >= 20) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 20) state = LETTER2;
    end
        LETTER2 : begin
            if(cnt >= 20) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 20) state = LETTER3;
    end
        LETTER3 : begin
            if(cnt >= 20) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 20) state = DELAY_T;
    end
        DELAY_T : begin
            if(cnt >= 5) cnt = 0;
            else cnt = cnt + 1;
            if(cnt == 5) state = CLEAR_DISP;
    end
        CLEAR_DISP : begin
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

        LETTER1 :
            begin
            {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000;
            case(bcd_out[11:9])
            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0010;
            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0100;
            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0110;
            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
            default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000;
            endcase
        end
        LETTER2 :
            begin
            {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0001;
            case(bcd_out[8:5])
            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0010;
            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0100;
            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0110;
            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
            default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000;
            endcase
        end
        LETTER3 :
            begin
            {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000;
            case(bcd_out[4:1])
            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0010;
            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0100;
            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_0110;
            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
            default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000;
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