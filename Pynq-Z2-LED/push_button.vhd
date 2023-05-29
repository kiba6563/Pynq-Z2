----------------------------------------------------------------------------------
--
-- Enginner :   Kishore Bachu
-- Date     :   05-march-2023
-- Title    :   Push_Button. Generates a latched output from push buttons BTN1, BTN2
-- 
-- Inputs   :   SYS_RESET, LED_EN_L, LED_EN_R
-- Outputs  :   LED_EN_Lpb, LED_EN_Rpb
-- Parent   :   leds_toggle_top.vhd
-- Child    :   None
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Entity
entity push_button is
    Port (
            SYS_RESET   :   in std_logic;
            LED_EN_L    :   in std_logic;
            LED_EN_R    :   in std_logic;
            LED_EN_Lpb  :   out std_logic;
            LED_EN_Rpb  :   out std_logic
          );
end push_button;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Architecture
architecture Behavioral of push_button is

    -- Internal signal
    signal btn1_reg   : std_logic;
    signal btn2_reg   : std_logic;
    
begin
    
    process (SYS_RESET, LED_EN_L, LED_EN_R)
    begin
        if (SYS_RESET = '1') then
            btn1_reg <= '0';
            btn2_reg <= '0';
        elsif (LED_EN_L = '1') then       -- Toggle btn1_reg
            btn1_reg <= not btn1_reg;
        elsif (LED_EN_R = '1') then       
            btn2_reg <= not btn2_reg;     -- Toggle btn2_reg
        else
            btn1_reg <= btn1_reg;         -- Latch BTN1 value
            btn2_reg <= btn2_reg;         -- Latch BTN2 value
        end if;
    end process;
        
        LED_EN_Lpb <= btn1_reg;           -- Assign latched BTN1 to output
        LED_EN_Rpb <= btn2_reg;           -- Assign latched BTN2 to output
        
end Behavioral;
----------------------------------------------------------------------------------