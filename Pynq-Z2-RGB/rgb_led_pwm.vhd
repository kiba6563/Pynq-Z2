----------------------------------------------------------------------------------
-- 
-- Date: 12-March-2023
-- Title: rgb_led_pwm (Top Module)
-- 
-- Inputs: SYS_CLK, SYS_RESET, LED4_EN, LED5_EN
-- Outputs: LED4_R, LED4_G, LED4_B, LED5_R, LED5_G, LED5_B
-- Parent : None
-- Child : led4_pwm.vhd, led5_pwm.vhd, slow_clock.vhd
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Entity
entity rgb_led_pwm is
      Port ( 
                SYS_CLK     :   in std_logic;       -- System Clock, 125MHz
                SYS_RESET   :   in std_logic;       -- Active High Reset. Push Button BTN0
                LED4_EN     :   in std_logic;       -- Enable RGB LED4 toggle. Slide Switch SW1
                LED5_EN     :   in std_logic;       -- Enable RGB LED5 toggle. Slide Switch SW2
                LED4_R      :   out std_logic;      -- RGB LED4 (RED)
                LED4_G      :   out std_logic;      -- RGB LED4 (GREEN)
                LED4_B      :   out std_logic;      -- RGB LED4 (BLUE)
                LED5_R      :   out std_logic;      -- RGB LED5 (RED)
                LED5_G      :   out std_logic;      -- RGB LED5 (GREEN)
                LED5_B      :   out std_logic       -- RGB LED5 (BLUE)
            );
end rgb_led_pwm;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Architecture
architecture Behavioral of rgb_led_pwm is

    --Component slow_clock module
    component slow_clock is 
        port (
                SYS_CLK     :   in std_logic;
                SYS_RESET   :   in std_logic;
                SLOW_CLK    :   out std_logic
             );
    end component;


    --Component led4_pwm module
    component led4_pwm is
        port (
                SLOW_CLK    :   in std_logic;
                SYS_RESET   :   in std_logic;
                LED4_EN     :   in std_logic;
                LED4_R      :   out std_logic;
                LED4_G      :   out std_logic;
                LED4_B      :   out std_logic
             );
    end component;

    --Component led5_pwm module
    component led5_pwm is
        port (
                SLOW_CLK    :   in std_logic;
                SYS_RESET   :   in std_logic;
                LED5_EN     :   in std_logic;
                LED5_R      :   out std_logic;
                LED5_G      :   out std_logic;
                LED5_B      :   out std_logic
             );
    end component;
    
    -- Intermediate signals
    signal  SLOW_CLK        :   std_logic;
    
begin

    -- Port map for slow_clock
    SLCK    :   slow_clock
        port map (
                    SYS_CLK     =>  SYS_CLK,
                    SYS_RESET   =>  SYS_RESET,
                    SLOW_CLK    =>  SLOW_CLK
                 );

    -- Port map for led4_pwm
    PWM1    :   led4_pwm 
        port map (
                    SLOW_CLK    =>  SLOW_CLK,
                    SYS_RESET   =>  SYS_RESET,
                    LED4_EN     =>  LED4_EN,
                    LED4_R      =>  LED4_R,
                    LED4_G      =>  LED4_G,
                    LED4_B      =>  LED4_B
                 );

    -- Port map for pwm
    PWM2    :   led5_pwm 
        port map (
                    SLOW_CLK    =>  SLOW_CLK,
                    SYS_RESET   =>  SYS_RESET,
                    LED5_EN     =>  LED5_EN,
                    LED5_R      =>  LED5_R,
                    LED5_G      =>  LED5_G,
                    LED5_B      =>  LED5_B
                 );
        
end Behavioral;
----------------------------------------------------------------------------------