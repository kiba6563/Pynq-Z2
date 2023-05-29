----------------------------------------------------------------------------------
-- 
-- Date: 03-March-2023
-- Title: led5_pwm
-- 
-- Inputs: SYS_CLK, SYS_RESET, LED5_EN
-- Outputs: LED5_R, LED5_G, LED5_B
-- Parent : reg_led_pwm
-- Child : None
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.all;

----------------------------------------------------------------------------------


----------------------------------------------------------------------------------
-- Entity
entity led5_pwm is
      Port ( 
                SLOW_CLK    :   in std_logic;       -- Slow Clock, ~1Hz
                SYS_RESET   :   in std_logic;       -- Active High Reset. Push Button BTN0
                LED5_EN     :   in std_logic;       -- Enable RGB LED5 toggle. Slide Switch SW1
                LED5_R      :   out std_logic;      -- RGB LED5 (RED)
                LED5_G      :   out std_logic;      -- RGB LED5 (GREEN)
                LED5_B      :   out std_logic       -- RGB LED5 (BLUE)
           );
end led5_pwm;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--Architecture
architecture Behavioral of led5_pwm is

    signal slow_clk_counter    :   std_logic_vector (31 downto 0); -- slow clock counter
    signal led5_r_buf   :   std_logic;
    signal led5_g_buf   :   std_logic;
    signal led5_b_buf   :   std_logic;
    
    -- intermediate signals
    signal led5_RGB     :   std_logic_vector (2 downto 0);
            
begin
    
    concat: process (led5_r_buf, led5_g_buf, led5_b_buf)
    begin 
        led5_RGB <= led5_r_buf & led5_g_buf & led5_b_buf;       -- concatenation
    end process concat; 
        
    sync: process (SLOW_CLK, SYS_RESET)
    begin
        if (rising_edge(SLOW_CLK)) then                         -- look for clock edge
            if (SYS_RESET = '1') then                           -- on reset high
                led5_RGB <= (others => '0');                    -- reset led5_RGB
            elsif (LED5_EN = '1') then                          -- shift operation
                led5_RGB(2 downto 1) <= led5_RGB(1 downto 0);
                led5_RGB(0) <= not led5_RGB(2);
            else                                                
                led5_RGB <= (others => '0'); 
            end if;
        end if;
    end process sync;
    
    assign: process (SLOW_CLK)
    begin
        LED5_R  <=  led5_RGB(0);    -- assign to RED led
        LED5_G  <=  led5_RGB(1);    -- assign to GREEN led
        LED5_B  <=  led5_RGB(2);    -- assign to BLUE led
    end process assign;
    
end Behavioral;
----------------------------------------------------------------------------------