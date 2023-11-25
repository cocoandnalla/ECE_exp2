`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/17 13:59:54
// Design Name: 
// Module Name: text_LCD_2_more
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


module text_LCD_2(clk, rst, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out, number_btn, control_btn, btn);

input clk, rst, btn; // DIP_SWITCH
input [9:0] number_btn; // wirte a number // number button
input [1:0] control_btn;  // cursor to left or right // # * button

wire [9:0] number_btn_t;
wire [1:0] control_btn_t;
wire btn1_t, btn2_t;

oneshot_universal #(.WIDTH(12)) O1(.clk(clk), .rst(rst), .btn({number_btn, control_btn, btn, ~btn}), .btn_trig({number_btn_t, control_btn_t, btn1_t, btn2_t}));

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;
output reg [7:0] LED_out;

wire LCD_E;
reg LCD_RS, LCD_RW;

reg [7:0] cnt;

reg [3:0] state;
reg [8:0] address;

parameter DELAY         = 4'b0000;
parameter FUNCTION_SET  = 4'b0001;
parameter DISP_ONOFF    = 4'b0010;
parameter ENTRY_MODE    = 4'b0011;
parameter SET_ADDRESS   = 4'b0100;
parameter DELAY_T       = 4'b0101;
parameter WRITE         = 4'b0110;
parameter SET_LINE1     = 4'b0111;
parameter SET_LINE2     = 4'b1001;
parameter CURSOR        = 4'b1010;

parameter address0   = 8'b0000_0000;
parameter address1   = 8'b0000_0001;
parameter address2   = 8'b0000_0010;
parameter address3   = 8'b0000_0011;
parameter address4   = 8'b0000_0100;
parameter address5   = 8'b0000_0101;
parameter address6   = 8'b0000_0110;
parameter address7   = 8'b0000_0111;
parameter address8   = 8'b0000_1000;
parameter address9   = 8'b0000_1001;
parameter addressA   = 8'b0000_1010;
parameter addressB   = 8'b0000_1011;
parameter addressC   = 8'b0000_1100;
parameter addressD   = 8'b0000_1101;
parameter addressE   = 8'b0000_1110;
parameter addressF   = 8'b0000_1111;
parameter address10  = 8'b0001_0000;
parameter address11  = 8'b0001_0001;
parameter address12  = 8'b0001_0010;
parameter address13  = 8'b0001_0011;
parameter address14  = 8'b0001_0100;
parameter address15  = 8'b0001_0101;

parameter address40   = 8'b0100_0000;
parameter address41   = 8'b0100_0001;
parameter address42   = 8'b0100_0010;
parameter address43   = 8'b0100_0011;
parameter address44   = 8'b0100_0100;
parameter address45   = 8'b0100_0101;
parameter address46   = 8'b0100_0110;
parameter address47   = 8'b0100_0111;
parameter address48   = 8'b0100_1000;
parameter address49   = 8'b0100_1001;
parameter address4A   = 8'b0100_1010;
parameter address4B   = 8'b0100_1011;
parameter address4C   = 8'b0100_1100;
parameter address4D   = 8'b0100_1101;
parameter address4E   = 8'b0100_1110;
parameter address4F   = 8'b0100_1111;
parameter address50   = 8'b0101_0000;
parameter address51   = 8'b0101_0001;
parameter address52   = 8'b0101_0010;
parameter address53   = 8'b0101_0011;
parameter address54   = 8'b0101_0100;
parameter address55   = 8'b0101_0101;

always @(posedge clk or negedge rst) 
begin
    if(!rst) begin
    state <= DELAY; 
    LED_out <= 8'b0000_0000;
    end
    else begin
        case(state)
            DELAY : begin
                if(cnt == 70) state <= FUNCTION_SET;
                LED_out <= 8'b1000_0000;
            end
            
            FUNCTION_SET : begin
                if(cnt == 30) state <= DISP_ONOFF;
                LED_out <= 8'b0100_0000;
            end
            
            DISP_ONOFF : begin
                if(cnt == 30) state <= ENTRY_MODE;
                LED_out <= 8'b0010_0000;
            end
            
            ENTRY_MODE : begin
                if(cnt == 30) state <= SET_ADDRESS;
                LED_out <= 8'b0001_0000;
            end
            
            SET_ADDRESS : begin
                if(cnt == 100) state <= DELAY_T;
                LED_out <= 8'b0000_1000;
            end
            
            DELAY_T : begin
            state <= |number_btn_t ? WRITE : (|control_btn ? CURSOR : (btn1_t ? SET_LINE2 : (btn2_t ? SET_LINE1 : DELAY_T))); // if |number_btn_t != 0, state <= WIRTE // if |number_btn_t == 0, |control_btn_t !=0, state <= CURSOR
            LED_out <= 8'b0000_0100;
            
            if(btn2_t) state <= SET_LINE1;
            else if(btn1_t) state <= SET_LINE2;
            else if(|control_btn_t) state <= CURSOR;
            else if(|number_btn_t) state <= WRITE;
            end
            
            WRITE : begin
                if(cnt == 30) state <= DELAY_T; 
                LED_out <= 8'b0000_0010;
            end
            
            CURSOR : begin
                if(cnt == 30) state <= DELAY_T; // cnt = 260 when control_btn_t
                LED_out <= 8'b0000_0001;
            end
        endcase
    end
end

always @(posedge clk or negedge rst) 
begin
    if(!rst)
        cnt <= 8'b0000_0000;
        else
        begin
            case(state)
            DELAY :
                if(cnt >= 70) cnt <= 0;
                else cnt <= cnt + 1;
            FUNCTION_SET :
                if(cnt >= 30) cnt <= 0;
                else cnt <= cnt + 1;
            DISP_ONOFF :
                if(cnt >= 30) cnt <= 0;
                else cnt <= cnt + 1;
            ENTRY_MODE :
                if(cnt >= 30) cnt <= 0;
                else cnt <= cnt + 1;
            SET_ADDRESS :
                if(cnt >= 100) cnt <= 0;
                else cnt <= cnt + 1;
            DELAY_T :
                cnt <= 0;
            WRITE :
                if(cnt >= 30) cnt <= 0;
                else cnt <= cnt + 1;
            endcase
        end
end


always @(posedge clk or negedge rst) 
begin
    if(!rst)
        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
    else
    begin
        case(state)
        FUNCTION_SET :  
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000; // 8bit(1) , 2Line(1)

        DISP_ONOFF :
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111; // display ON(1), cursor ON(1), cursor blink(1)

        ENTRY_MODE : 
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110; // cursor right(1), no display shift(0)

        SET_ADDRESS : 
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0010; // cursor at home
           
        DELAY_T : 
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111; // wait
            
        WRITE : begin
        if (cnt == 20) begin 
             case(number_btn)
                    10'b1000_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                    10'b0100_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                    10'b0010_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                    10'b0001_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                    10'b0000_1000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                    10'b0000_0100_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                    10'b0000_0010_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                    10'b0000_0001_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                    10'b0000_0000_10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                    10'b0000_0000_01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                endcase
                end
            else {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
        end
        
        SET_LINE1 :
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000;
        
        SET_LINE2 :
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000;
       
        CURSOR : begin
            if(cnt == 20) begin
                case(control_btn)
                    2'b10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0000;
                    2'b01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0100;
                endcase
            end
            else {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
        end
    endcase
    end
end

assign LCD_E = clk;
endmodule
