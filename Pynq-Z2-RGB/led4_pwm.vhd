----------------------------------------------------------------------------------
-- 
-- Date: 03-March-2023
-- Title: led4_pwm
-- 
-- Inputs: SYS_CLK, SYS_RESET, LED4_EN
-- Outputs: LED4_R, LED4_G, LED4_B
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
entity led4_pwm is
      Port ( 
                SLOW_CLK    :   in std_logic;       -- Slow Clock, ~1Hz
                SYS_RESET   :   in std_logic;       -- Active High Reset. Push Button BTN0
                LED4_EN     :   in std_logic;       -- Enable RGB LED4 toggle. Slide Switch SW0
                LED4_R      :   out std_logic;      -- RGB LED4 (RED)
                LED4_G      :   out std_logic;      -- RGB LED4 (GREEN)
                LED4_B      :   out std_logic       -- RGB LED4 (BLUE)
           );
end led4_pwm;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--Architecture
architecture Behavioral of led4_pwm is

    signal slow_clk_counter    :   std_logic_vector (31 downto 0); -- slow clock counter
    signal led4_r_buf   :   std_logic;
    signal led4_g_buf   :   std_logic;
    signal led4_b_buf   :   std_logic;
    
    -- intermediate signals
    signal led4_RGB     :   std_logic_vector (2 downto 0);
            
begin
    
    concat: process (led4_r_buf, led4_g_buf, led4_b_buf)
    begin 
        led4_RGB <= led4_r_buf & led4_g_buf & led4_b_buf;       -- concatenation
    end process concat; 
        
    sync: process (SLOW_CLK, SYS_RESET)
    begin
        if (rising_edge(SLOW_CLK)) then                         -- look for clock edge
            if (SYS_RESET = '1') then                           -- on reset high
                led4_RGB <= (others => '0');                    -- reset led4_RGB
            elsif (LED4_EN = '1') then                          -- shift operation
                led4_RGB(2 downto 1) <= led4_RGB(1 downto 0);
                led4_RGB(0) <= not led4_RGB(2);
            else                                                
                led4_RGB <= (others => '0'); 
            end if;
        end if;
    end process sync;
    
    assign: process (SLOW_CLK)
    begin
        LED4_R  <=  led4_RGB(0);    -- assign to RED led
        LED4_G  <=  led4_RGB(1);    -- assign to GREEN led
        LED4_B  <=  led4_RGB(2);    -- assign to BLUE led
    end process assign;

end Behavioral;
----------------------------------------------------------------------------------