`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Designer : Kishore Bachu	
// Date : 13-May-2023
// Title : Verilog LCD12864 Controller module (lcd12864_controller.v)
// Target Board: PYNQ-Z2
// Target Devices: XC7Z020
// Tool versions: Vivado2022.2
//
//////////////////////////////////////////////////////////////////////////////////


module lcd12864_controller(
                SYS_CLK,
                SLOW_CLK,
                SYS_RST,
                LCD_RS,
                LCD_RW,
                LCD_EN,
                LCD_DB,
                LCD_RST,
                LCD_PSB,
                LCD_K,
                LCD_A   
             );

 //Input Ports
 input SYS_CLK;
 input SLOW_CLK;
 input SYS_RST;
 
 //Output Ports
 output LCD_RS;
 output LCD_RW;
 output LCD_EN;
 output [7:0]LCD_DB;
 output LCD_RST;
 output LCD_PSB;
 output LCD_K;
 output LCD_A;
 
 //Data Types
 reg LCD_RS;
 reg LCD_RST;
 reg [7:0]LCD_DB;
 reg LCD_EN;
 
 //Internal registers
 reg [3:0]state;
 reg [27:0]timer;
 reg [4:0]addr_Counter; 
 reg [7:0]disp_Data;
 reg done; 
 
  assign LCD_K   = 1'b0;
  assign LCD_A   = 1'b1;
  assign LCD_PSB = 1;           //For 8/4-bit mode, PSB = 1
  assign LCD_RW  = 1'b0;        //LCD write access only

 
// ---------Power ON Initialization--------- 
 always @(posedge SYS_CLK or posedge SYS_RST)
 begin
    if (SYS_RST == 1'b1)
        timer <= 28'b0;
    else if (timer < 5000000)       
        timer <= timer + 1;
    else
        timer <= timer;
 end

 always @(posedge SYS_CLK or posedge SYS_RST)
 begin
    if (SYS_RST == 1'b1)
        LCD_RST <= 1'b0;
    else if (timer == 5000000)  //Wait 40ms (125Mhz*40ms = 5000000 clock cycles)  
        LCD_RST <= 1'b1;
    else  
        LCD_RST <= 1'b0; 
 end
 
 always @(posedge SLOW_CLK or posedge SYS_RST)
 begin
    if (SYS_RST == 1'b1) 
        begin
            state <= 0;
            addr_Counter <= 0;
            LCD_RS <= 1'b0;
            LCD_DB <= 8'b0000_0000;
            done <= 1'b1;
        end
    else
        begin
            case(state)                              
                //-------------IDLE (0xzz)---------------//
                0 : begin LCD_RS <= 1'b0; LCD_DB <= 8'bzzzz_zzzz; state <= state + 1; end                     
               
                //---------Function Set1 (0x30)----------//
                1 : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0011_0000; state <= state + 1; end
                
                //---------Function Set2 (0x30)----------//
                2 : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0011_0000; state <= state + 1; end 
                
                //--------Display ON/OFF (0x0c)----------//
                3 : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0000_1100; state <= state + 1; end
                
                //---------Display clear(0x01)-----------//
                4 : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0000_0001; state <= state + 1; end
                
                //--------Entry Mode Set (0x06)----------//
                5 : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0000_0110; state <= state + 1; end                                              

                //---------Set DDRAM Address-------------//
                6 : begin                       
                        if (addr_Counter == 0) 
                            begin
                                LCD_RS <= 0;
                                LCD_DB <= 8'b1000_0000;     //First Line range is 80H..80F
                            end
                        else
                            begin
                                LCD_RS <= 0;
                                LCD_DB <= 8'b1001_0000;     //Second Line range is 90H..90F
                            end
                        state <= state + 1;                                            
                    end
                    
                //-------------Write Data to RAM---------------//
                7 : begin
                        if (addr_Counter <= 15)                  
                            begin
                                addr_Counter <= addr_Counter + 1;
                                LCD_RS <= 1;
                                LCD_DB <= disp_Data;
                                //If addr_Counter reaches 15 (end of 1st line), go to 
                                //previous state and fetch start address of second line. 
                                if (addr_Counter == 15) state <= state - 1;  
                                else state <= state;                          
                            end
                        else if (addr_Counter >= 15 && addr_Counter <= 31)
                            begin
                                LCD_RS <= 1;
                                LCD_DB <= disp_Data;
                                //If addr_Counter reaches 31 (end of 2nd line), jump to 
                                //next state. 
                                if (addr_Counter == 31) 
                                    begin
                                        //state <= state + 1;
                                        state <= state + 1;
                                        addr_Counter <= 0;   
                                        done <= 1'b0;
                                    end                                    
                                else
                                    begin
                                        state <= state;  
                                        addr_Counter <= addr_Counter + 1;
                                    end      
                            end                   
                    end

                8 : begin LCD_RS <= 1'b0; LCD_DB <= 8'bzzzz_zzzz; state <= 0; end
                
                default : begin LCD_RS <= 1'b0; LCD_DB <= 8'b0000_0000; state <= 0; end
            endcase
        end
 end
 
 always @(done)
 begin
    if (done == 0) LCD_EN = 1'b0;
    else if (done == 1) LCD_EN = SLOW_CLK;
    else LCD_EN = LCD_EN;
 end

 always @(addr_Counter)
 begin
    case(addr_Counter)     
        5'd0    : disp_Data = 8'b0111_0111; //write "w"
        5'd1    : disp_Data = 8'b0111_0111; //write "w"
        5'd2    : disp_Data = 8'b0111_0111; //write "w" 
        5'd3    : disp_Data = 8'b0010_1110; //write "."
        5'd4    : disp_Data = 8'b0110_0111; //write "g"
        5'd5    : disp_Data = 8'b0110_1001; //write "i"
        5'd6    : disp_Data = 8'b0111_0100; //write "t"
        5'd7    : disp_Data = 8'b0110_1000; //write "h"
        5'd8    : disp_Data = 8'b0111_0101; //write "u"
        5'd9    : disp_Data = 8'b0110_0010; //write "b"
        5'd10   : disp_Data = 8'b0010_1110; //write "."
        5'd11   : disp_Data = 8'b0110_0011; //write "c"
        5'd12   : disp_Data = 8'b0110_1111; //write "o"
        5'd13   : disp_Data = 8'b0110_1101; //write "m"
        5'd14   : disp_Data = 8'b0010_1111; //write "/"
        5'd15   : disp_Data = 8'b0010_0000; //blank
        
        5'd16   : disp_Data = 8'b0110_1011; //write "k"
        5'd17   : disp_Data = 8'b0110_1001; //write "i"
        5'd18   : disp_Data = 8'b0110_0010; //write "b"
        5'd19   : disp_Data = 8'b0110_0001; //write "a"
        5'd20   : disp_Data = 8'b0011_0110; //write "6"
        5'd21   : disp_Data = 8'b0011_0101; //write "5"
        5'd22   : disp_Data = 8'b0011_0110; //write "6"
        5'd23   : disp_Data = 8'b0011_0011; //write "3"
        default : disp_Data = 8'b0010_0000;
    endcase
 end                
 
endmodule
