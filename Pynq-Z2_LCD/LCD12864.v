`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Designer : Kishore Bachu	
// Date : 13-May-2023
// Title : Verilog LCD12864 top module (lcd12864_top.v)
// Target Board: PYNQ-Z2
// Target Devices: XC7Z020
// Tool versions: Vivado2022.2
//
//////////////////////////////////////////////////////////////////////////////////

module lcd12864_top (
                        SYS_CLK,    //System Clock, 125MHz on PYNQ-Z2.
                        SYS_RST,    //Active High Reset. Push Button KEY0 on PYNQ-Z2.
                        LCD_RS,     //LCD Register Select. 0=Instruction Register. 1=Data Register.
                        LCD_RW,     //LCD Read/Write Control. 0=Register Write. 1=Register Read.
                        LCD_EN,     //LCD Read/Write Enable. Active High. 
                        LCD_DB,     //8-bit LCD Data Bus.
                        LCD_RST,    //LCD Reset. Active Low. 0=Display OFF. 1=Display from Line0.
                        LCD_PSB,    //Serial/Parallel selection. 0=Serial Mode. 1=8/4-bit Parallel Bus Mode.
                        LCD_K,      //Supply Voltage for LED-
                        LCD_A       //Supply Voltage for LED+
                    );

  //Input Ports
  input SYS_CLK;
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
  
  //slow_clock module instanitation
  slow_clk u1 (
                .SYS_CLK(SYS_CLK),
                .SYS_RST(SYS_RST),
                .SLOW_CLK(SLOW_CLK)
              );
  
  
  //lcd12864_controller module instantation
  lcd12864_controller u2 (
                .SYS_CLK(SYS_CLK),
                .SLOW_CLK(SLOW_CLK),
                .SYS_RST(SYS_RST),
                .LCD_RS(LCD_RS),
                .LCD_RW(LCD_RW),
                .LCD_EN(LCD_EN),
                .LCD_DB(LCD_DB),
                .LCD_RST(LCD_RST),
                .LCD_PSB(LCD_PSB),
                .LCD_K(LCD_K),
                .LCD_A(LCD_A)                
              );
                
endmodule