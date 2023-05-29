----------------------------------------------------------------------------------
-- 
-- Engineer: Kishore Bachu
-- Date: 05-March-2023
-- Title: leds_toggle_top (Top Module)
-- 
-- Inputs: SYS_CLK, SYS_RESET, LED_EN_L, LED_EN_R
-- Outputs: LED[3:0]
-- Parent : None
-- Child : slow_clock.vhd, led_toggle.vhd, push_button.vhd
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Entity
entity leds_toggle_top is
    Port (
            SYS_CLK     :   in std_logic;           -- System Clock, 125MHz
            SYS_RESET   :   in std_logic;           -- Active High Reset. Push Button BTN0
            LED_EN_L    :   in std_logic;           -- Enable LED toggling in Left. Push Button BTN1
            LED_EN_R    :   in std_logic;           -- Enable LED toggling in Right. Push Button BTN2
            LED         :   out std_logic_vector (3 downto 0) -- On-board LEDs 
         );
end leds_toggle_top;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
architecture Behavioral of leds_toggle_top is
    
    -- Component slow_clock module
    component slow_clock is
        port (
                SYS_CLK     :  in std_logic;        -- System Clock input, 125MHz    
                SYS_RESET   :  in std_logic;        -- Active High Reset. Push Button BTN0
                SLOW_CLK    :  out std_logic        -- Slow Clock output
             );
    end component;
    
    -- Component push_button module to latch button position
    component push_button is
        port (
                SYS_RESET   :   in std_logic;       -- Active High Reset. Push Button BTN0
                LED_EN_L    :   in std_logic;       
                LED_EN_R    :   in std_logic;       
                LED_EN_Lpb  :   out std_logic;      -- Latched LED_EN_Lpb push button value on BTN1
                LED_EN_Rpb  :   out std_logic       -- Latched LED_EN_Rpb push button value on BTN2
             );
    end component;
    
    
    -- Component led_toggle module
    component led_toggle is
        port (
                SLOW_CLK    :   in std_logic;
                SYS_RESET   :   in std_logic;
                LED_EN_Lpb  :   in std_logic;
                LED_EN_Rpb  :   in std_logic;
                LED         :   out std_logic_vector (3 downto 0)
             );
    end component;
    
    
    --Internal signals
    signal  SLOW_CLK    :   std_logic;
    signal  LED_EN_Lpb  :   std_logic;
    signal  LED_EN_Rpb  :   std_logic;
    
begin

    -- Port map for slow_clock
    SCLK1   :   slow_clock
        port map (
                    SYS_CLK     =>  SYS_CLK,
                    SYS_RESET   =>  SYS_RESET,
                    SLOW_CLK    =>  SLOW_CLK
                  );

    -- Port map for push_button
    PB1     :   push_button
        port map (
                    SYS_RESET   =>  SYS_RESET,
                    LED_EN_L    =>  LED_EN_L,
                    LED_EN_R    =>  LED_EN_R,
                    LED_EN_Lpb  =>  LED_EN_Lpb,
                    LED_EN_Rpb  =>  LED_EN_Rpb
                 );

    -- Port map for led_toggle
    LED1    :   led_toggle
        port map (
                    SLOW_CLK    =>  SLOW_CLK,
                    SYS_RESET   =>  SYS_RESET,
                    LED_EN_Lpb  =>  LED_EN_Lpb,
                    LED_EN_Rpb  =>  LED_EN_Rpb,
                    LED         =>  LED
                 );

end Behavioral;
----------------------------------------------------------------------------------
