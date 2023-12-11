`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 17:15:52
// Design Name: 
// Module Name: leemujin
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


module leemujin(clk, rst, btn_1, btn_2, switch, led_R, led_Y, led_G, led_left, led_W_R, led_W_G, LCD_E, LCD_RS, LCD_RW, LCD_DATA );

input clk, rst;
input btn_1, btn_2;
input [2:0] switch;
output reg [3:0] led_R, led_G, led_Y, led_W_R, led_W_G, led_left;

wire flicker;
wire btn_1_t, btn_2_t;
wire [7:0] bcd_hour, bcd_min, bcd_sec;

reg [7:0] hour,min,sec;

output LCD_E;
output reg LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;
reg emergency = 0;

reg [3:0] state_traffic;
reg [3:0] state_save;
// 신호등 스테이트 
parameter  state_A_1     = 4'b0000; // 0
parameter  state_A_2     = 4'b0001; // 1
parameter  state_B       = 4'b0010; // 2
parameter  state_C       = 4'b0011; // 3
parameter  state_D       = 4'b0100; // 4
parameter  state_E_1     = 4'b0101; // 5
parameter  state_E_2     = 4'b0110; // 6
parameter  state_F       = 4'b0111; // 7
parameter  state_G       = 4'b1000; // 8
parameter  state_H       = 4'b1001; // 9


reg [2:0] state_LCD;     
parameter DELAY         = 3'b000; // 0
parameter FUNCTION_SET  = 3'b001; // 1 
parameter ENTRY_MODE    = 3'b010; // 2
parameter DISP_ONOFF    = 3'b011; // 3
parameter LINE_1        = 3'b100; // 4
parameter LINE_2        = 3'b101; // 5 
parameter DELAY_T       = 3'b110; // 6

integer limit = 9999; // 상한 한계선 기본 settin = 1Hz (1sec)
integer cnt_clock; // basic clock의 counter
integer cnt_LCD; 
integer cnt_flicker; // 깜빡깜빡
integer cnt_traffic;

oneshot_universal #(.WIDTH(2)) u0 (.clk(clk), .rst(rst), .btn({btn_1, btn_2}), .btn_trig({btn_1_t, btn_2_t})); // 원샷 트리거 
 
bin2bcd b1 (.clk(clk), .rst(rst), .bin(hour), .bcd(bcd_hour)); // bin to bcd (hour)
bin2bcd b2 (.clk(clk), .rst(rst), .bin(min), .bcd(bcd_min)); // bin to bcd (min)
bin2bcd b3 (.clk(clk), .rst(rst), .bin(sec), .bcd(bcd_sec)); // bin to bcd (sec)

// basic clock

// basic clock

always @ (negedge rst or posedge clk) begin   
        if (!rst) begin
        cnt_clock   <= 0;
        hour        <= 0;
        sec         <= 0;
        min         <= 0;
        end
        else if (btn_1_t && hour < 23) // btn_1 -> hour + 1
            hour <= hour + 1;

        else if (btn_1_t && hour == 23) 
            hour <= 0;

        else if (cnt_clock < limit)  begin 
            cnt_clock <= cnt_clock + 1;
            if (switch[2])      limit <= 999; // 10배 
            else if (switch[1]) limit <= 99; // 100배 
            else if (switch[0]) limit <= 49; // 200배 
            else begin limit <= 9999;
            end
            end

        else begin // cnt_clock == limit
           cnt_clock <= 0;
        if (sec < 59) 
            sec <= sec + 1; 
        else begin 
           sec <= 0;
        if (min < 59) 
            min <= min + 1; 
        else begin 
            min <= 0;
        if (hour < 23) 
            hour <= hour + 1; 
        else begin 
            hour <= 0;
            end
         end
      end              
  end 
end

//text LCD smae with text_LCD 교안

              
          
always @ (negedge rst or posedge clk)
begin
    if (!rst) begin
        state_LCD <= DELAY;
        cnt_LCD <= 0;
        end
    else
    begin
        case (state_LCD)
        DELAY : begin
            if(cnt_LCD >=70) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 70) state_LCD <= FUNCTION_SET;
        end
        FUNCTION_SET : begin
            if(cnt_LCD >=30) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 30) state_LCD <= DISP_ONOFF;
        end
        DISP_ONOFF : begin
            if(cnt_LCD >=30) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 30) state_LCD <= ENTRY_MODE;
        end
        ENTRY_MODE : begin
            if(cnt_LCD >=30) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 30) state_LCD <= LINE_1;
        end
        LINE_1 : begin
            if(cnt_LCD >=20) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 20) state_LCD <= LINE_2;
           end
        LINE_2 : begin
            if(cnt_LCD >=20) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 20) state_LCD <= DELAY_T;
           end
        DELAY_T : begin
            if(cnt_LCD >= 5) cnt_LCD <= 0;
            else cnt_LCD <= cnt_LCD + 1;
            if(cnt_LCD == 5) state_LCD <= LINE_1;
        end
        default : state_LCD <= DELAY;
     endcase
  end
end
                              
always @ (negedge rst or posedge clk)
begin
    if (!rst)
        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_1_00000000;
    else if (hour >= 8 && hour < 23) begin // dayime
        case (state_LCD)
            FUNCTION_SET :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000;
            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1100;
            ENTRY_MODE :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;   
            LINE_1 : begin
                case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000; // 1째줄 주소
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0100; // T
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1001; // i
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1101; // m
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank     
                    08 : begin 
                        case (bcd_hour[7:4])                                     //10의 자리 hour
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                        endcase
                        end                  
                    09 : begin 
                        case (bcd_hour[3:0])                                     //1의 자리 hour
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end 
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010;        // :                    
                    11 :begin 
                        case (bcd_min[7:4]) //10의 자리 min
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                        endcase
                        end
                    12 :begin 
                        case (bcd_min[3:0]) //1의 자리 min
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end     
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010;        // :      
                    14 : begin 
                        case(bcd_sec[7:4]) //10의 자리 sec
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                        endcase
                        end          
                    15 :begin 
                        case (bcd_sec[3:0]) //1의 자리 sec
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end                            
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // 
                 endcase
                end
                LINE_2 : begin
                if (emergency == 1) begin
                case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // 2째줄 주소 
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0011; // S
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0001; // a
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e   
                    08 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1101; // m 
                    09 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e 
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0010; // r                 
                    11 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0111; // g 
                    12 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e 
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1110; // n   
                    14 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0011; // c    
                    15 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_1001; // y
                    16 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank                        
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // blank
                 endcase
                 end
                 else begin
                 case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // 2째줄 주소 
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0011; // S
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0001; // a
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :  
                    08 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    09 : begin 
                        case (state_traffic) // state입력
                            state_A_1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0001; // A
                            state_A_2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0001; // A
                            state_B   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0010; // B
                            state_C   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0011; // C
                            state_D   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0100; // D
                            state_E_1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0101; // E
                            state_E_2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0101; // E
                            state_F   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0110; // F
                            state_G   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0111; // G
                            state_H   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_1000; // H
                        endcase
                        end                  
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_1000; // (                   
                    11 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0100; // d
                    12 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0001; // a
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_1001; // y     
                    14 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_1001; // )    
                    15 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    16 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank                        
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // blank
                 endcase
                 end
              end
            DELAY_T :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0010;
            default :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_1_0000_0000;              
          endcase
        end
            else begin // night time
            case (state_LCD)
            FUNCTION_SET :
                {LCD_RS, LCD_RW,LCD_DATA} <= 10'b0_0_0011_1000;
            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1100;
            ENTRY_MODE :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;   
            LINE_1 : begin
                case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000; // 1째줄 주소
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0100; // T
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1001; // i
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1101; // m
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank    
                    08 : begin 
                        case (bcd_hour[7:4])                                     //10의 자리 hour
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                        endcase
                        end                  
                    09 : begin 
                        case (bcd_hour[3:0])                                     //1의 자리 hour
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end 
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010;        // :                    
                    11 :begin 
                        case (bcd_min[7:4]) //10의 자리 min
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                        endcase
                        end
                    12 :begin 
                        case (bcd_min[3:0]) //1의 자리 min
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end     
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010;        // :      
                    14 : begin 
                        case(bcd_sec[7:4]) //10의 자리 sec
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                        endcase
                        end          
                    15 :begin 
                        case (bcd_sec[3:0]) //1의 자리 sec
                            0 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                            1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            3 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            4 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            5 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            6 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            7 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            8 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            9 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                        endcase
                        end                                                
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // 
                endcase
                end
                LINE_2 : begin
                if (emergency == 1) begin
                case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // 2째줄 주소 
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0011; // S
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0001; // a
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e   
                    08 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1101; // m 
                    09 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e 
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0010; // r                 
                    11 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0111; // g 
                    12 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e 
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1110; // n   
                    14 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0011; // c    
                    15 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_1001; // y
                    16 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank                        
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // blank
                 endcase
                 end
                 else begin
                 case (cnt_LCD)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // 2째줄 주소 
                    01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0101_0011; // S
                    02 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    03 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0001; // a
                    04 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    05 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0101; // e
                    06 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    07 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1010; // :  
                    08 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_0000; // blank
                    09 : begin 
                        case (state_traffic) // state입력
                            state_A_1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0001; // A
                            state_A_2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0001; // A
                            state_B   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0010; // B
                            state_C   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0011; // C
                            state_D   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0100; // D
                            state_E_1 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0101; // E
                            state_E_2 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0101; // E
                            state_F   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0110; // F
                            state_G   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_0111; // G
                            state_H   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0100_1000; // H
                        endcase
                        end                  
                    10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_1000; // (                   
                    11 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1110; // n
                    12 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1001; // i
                    13 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_0111; // g     
                    14 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0110_1000; // h    
                    15 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0111_0100; // t
                    16 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0010_1001; // )                        
                    default : {LCD_RS, LCD_RW, LCD_DATA} <=10'b1_0_0010_0000; // blank
                 endcase
                 end
              end
            DELAY_T :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0010;
            default :
                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_1_0000_0000;              
          endcase
      end
  end
  
assign LCD_E = clk;


// 깜빡 깜빡 코드 
always @ (negedge rst or posedge clk) begin
    if (!rst) 
        cnt_flicker <= 0;
    else if (cnt_flicker >= 9999) // 1sec
        cnt_flicker <= 0;
    else
        cnt_flicker <= cnt_flicker + 1;
end

assign flicker = (cnt_flicker >= 4999) ? 0 : 1; // 절반이 지나면 0(OFF), 절반이 안지나면 1(ON)

// emergency and state_change
reg [31:0] time_on = 0; // state_traffic이 ON 되어있는 시간 이걸 기준으로 절반 이하 절반 이상 구현 


always @(negedge rst or posedge clk) begin
    if (!rst) begin 
        state_traffic <= state_B;
        cnt_traffic <= 0; // real time
        end
    else if (btn_2_t || emergency) begin // 수동조작
        time_on <= 150000;
        if(cnt_traffic >= 150000)  cnt_traffic <=0;
        else cnt_traffic <= (emergency != 0) ? cnt_traffic + 1 : 0;
        state_traffic <= (cnt_traffic >= 150000) ? state_save : ((cnt_traffic >= 10000 && emergency == 1) ? state_A_1 : state_save );  // 0.5초후 A 전환 // 15초후 원래 스테이트로 돌아감 
        emergency <= (cnt_traffic >= 150000) ? 0 : 1;   // btn_2_t in -> emergency = 1, 수동조작 상태 ON. 15sec later, 수동조작 상태 OFF, 원래상태로 BACK.
        end
    else if(hour >= 8 && hour < 23) begin // daytime 5sec
        time_on <= 50000; // 5sec
        state_save <= state_traffic;
        case (state_traffic)
            state_A_1 : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_D;
            if(cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end    
            state_D : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_F;
            if(cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic+ 1;
            end                 
            state_F : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_E_1;
            if(cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            state_E_1 : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_G;
            if(cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            state_G : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_E_2;
            if (cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic  <= cnt_traffic + 1;
            end 
            state_E_2 : begin 
            if(cnt_traffic >= 50000) state_traffic <= state_A_1;
            if (cnt_traffic >= 50000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end  
            default: state_traffic <= state_A_1;
       endcase
    end

    else if(hour < 8 || hour == 23) begin // night_time 10sec  
         time_on <= 100000; // 10sec
         state_save <= state_traffic;
       case(state_traffic)
            state_B : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_A_1;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end    
            state_A_1 : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_C;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end                 
            state_C : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_A_2;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            state_A_2 : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_E_1;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            state_E_1 : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_H;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            state_H : begin 
            if(cnt_traffic >= 100000) state_traffic <= state_B;
            if(cnt_traffic >= 100000) cnt_traffic <=0;
            else cnt_traffic <= cnt_traffic + 1;
            end 
            default: state_traffic <= state_B;
       endcase    
      end
end

// state_traffic_set
// cnt_traffic <= time_on/2 -> 기본 setting
// cnt_traffic > time_on/2 -> flicker and led_yellow 
// cnt_traffic > time_on/2 -> flicker -> led_W_G가 1인 부분을 flicker로 설정 
// cnt_traffic > time_on/2 ->  led_yellow  -> ( led_G, led_W_G ) all OFF and let them set as yellow light

// S N W E
always @(negedge rst or posedge clk) begin
    if (!rst) begin
        {led_G, led_R, led_Y, led_W_G, led_W_R} <= 5'b0_0000;
        end
    else
        case (state_traffic)
            state_A_1 : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b1100;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0000;
                    led_W_G     <= 4'b0011;
                    led_W_R     <= 4'b1100;  
                    end 
                else if (cnt_traffic > time_on/2) begin
                    led_G       <= 4'b0000;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b1100;
                    led_left    <= 4'b0000;
                    led_W_G     <= {2'b00, flicker, flicker};
                    led_W_R     <= 4'b1100; 
                    end
            end
            state_A_2 : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b1100;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0000;
                    led_W_G     <= 4'b0011;
                    led_W_R     <= 4'b1100;   
                    end 
                else if (cnt_traffic > time_on/2) begin
                    led_G       <= 4'b0000;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b1100;
                    led_left    <= 4'b0000;
                    led_W_G     <= {2'b00, flicker, flicker}; 
                    led_W_R     <= 4'b1100; 
                    end
            end
            state_B : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b0100;
                    led_R       <= 4'b1011;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0100;
                    led_W_G     <= 4'b0001;
                    led_W_R     <= 4'b1110; 
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G       <= 4'b0000;
                    led_R       <= 4'b1011;
                    led_Y       <= 4'b1100;
                    led_left    <= 4'b0100;
                    led_W_G     <= {3'b000, flicker};
                    led_W_R     <= 4'b1110;
                    end
            end
            state_C : begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b1000;
                    led_R       <= 4'b0111;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b1000;
                    led_W_G     <= 4'b0010;
                    led_W_R     <= 4'b1101;   
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G       <= 4'b0000;
                    led_R       <= 4'b0111;
                    led_Y       <= 4'b1000;
                    led_left    <= 4'b0000;
                    led_W_G     <= {2'b00, flicker, 1'b0};
                    led_W_R     <= 4'b1101; 
                    end
            end
            state_D : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b0000;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b1100;
                    led_W_G     <= 4'b0000;
                    led_W_R     <= 4'b1111;  
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G       <= 4'b0000;
                    led_R       <= 4'b0011;
                    led_Y       <= 4'b1100;
                    led_left    <= 4'b0000;
                    led_W_G     <= 4'b0000;
                    led_W_R     <= 4'b1111; 
                    end
            end
            state_E_1 : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G         <= 4'b0011;
                    led_R         <= 4'b1100;
                    led_Y         <= 4'b0000;
                    led_left      <= 4'b0000;
                    led_W_G       <= 4'b1100;
                    led_W_R       <= 4'b0011;  
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G         <= 4'b0000;
                    led_R         <= 4'b1100;
                    led_Y         <= 4'b0011;
                    led_left      <= 4'b0000;
                    led_W_G       <= {flicker, flicker, 2'b00};
                    led_W_R       <= 4'b0011;
                    end
            end
            state_E_2 : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G         <= 4'b0011;
                    led_R         <= 4'b1100;
                    led_Y         <= 4'b0000;
                    led_left      <= 4'b0000;
                    led_W_G       <= 4'b1100;
                    led_W_R       <= 4'b0011;  
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G         <= 4'b0000;
                    led_R         <= 4'b1100;
                    led_Y         <= 4'b0011;
                    led_left      <= 4'b0000;
                    led_W_G       <= {flicker, flicker, 2'b00};
                    led_W_R       <= 4'b0011;
                    end
            end
            state_F : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b0010;
                    led_R       <= 4'b1101;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0010;
                    led_W_G     <= 4'b0100;
                    led_W_R     <= 4'b1011; 
                    end 
                else if (cnt_traffic > time_on/2) begin
                    led_G       <= 4'b0000; 
                    led_R       <= 4'b1101;
                    led_Y       <= 4'b0010;
                    led_left    <= 4'b0000;
                    led_W_G     <= {1'b0, flicker, 2'b00};
                    led_W_R     <= 4'b1011;
                    end
            end
            state_G : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b0001;
                    led_R       <= 4'b1110;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0001;
                    led_W_G     <= 4'b1000;
                    led_W_R     <= 4'b0111; 
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G       <= 4'b0000;
                    led_R       <= 4'b1110;
                    led_Y       <= 4'b0001;
                    led_left    <= 4'b0000;
                    led_W_G     <= {flicker, 3'b000};
                    led_W_R     <= 4'b0111;
                    end
            end 
            state_H : 
            begin
                if (cnt_traffic <= time_on/2) begin
                    led_G       <= 4'b0000;
                    led_R       <= 4'b1100;
                    led_Y       <= 4'b0000;
                    led_left    <= 4'b0011;
                    led_W_G     <= 4'b0000;
                    led_W_R     <= 4'b1111;   
                    end 
                else if (cnt_traffic > time_on/2) begin 
                    led_G       <= 4'b0000;
                    led_R       <= 4'b1100;
                    led_Y       <= 4'b0011;
                    led_left    <= 4'b0000;
                    led_W_G     <= 4'b0000;
                    led_W_R     <= 4'b1111;
                    end
            end   
            default: 
                begin
                    {led_G, led_R, led_Y, led_W_G, led_W_R} <= 5'b0_0000;
                end
                endcase
end
endmodule
