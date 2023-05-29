`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Designer : Kishore Bachu	
// Date : 13-May-2023
// Title : Slow Clock Module (slow_clk.v)
// Target Board: PYNQ-Z2
// Target Devices: XC7Z020
// Tool versions: Vivado2022.2
//
//////////////////////////////////////////////////////////////////////////////////


module slow_clk(
                 SYS_CLK,
                 SYS_RST,
                 SLOW_CLK
                );

  //Input Ports
  input SYS_CLK;
  input SYS_RST;
  
  //Output Ports
  output SLOW_CLK;
  
  //Data Types
  reg SLOW_CLK;
  
  //Internal registers
  reg [27:0]slow_clk_counter;
  
 parameter clk_divider =  6250000; //uncomment for FPGA implementation
//  parameter clk_divider = 5; //uncomment for simulation
  
  always @ (posedge SYS_CLK or posedge SYS_RST)
  begin
    if (SYS_RST == 1'b1)
        slow_clk_counter <= 28'b0;
    else if (slow_clk_counter == clk_divider)
        slow_clk_counter <= 28'b0;
    else 
        slow_clk_counter <= slow_clk_counter + 28'b1;
  end
  
  always @(posedge SYS_CLK or posedge SYS_RST)
  begin
    if (SYS_RST == 1'b1)
        SLOW_CLK <= 0;
    else if (slow_clk_counter == clk_divider)
        SLOW_CLK <= ~SLOW_CLK;
    else SLOW_CLK <= SLOW_CLK;
  end
  
endmodule
