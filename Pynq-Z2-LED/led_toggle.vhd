----------------------------------------------------------------------------------
-- 
-- Engineer: Kishore Bachu
-- Date: 06-March-2023
-- Title: led_toggle. Toggles on-board LEDs in sequential shift left/right, enabled 
-- by push button switches.
-- 
-- Inputs: SYS_CLK, SYS_RESET, LED_EN_Lpb, LED_EN_Rpb
-- Outputs: LED[3:0]
-- Parent : leds_toggle_top.vhd
-- Child : none
--
--
----------------------------------------------------------------------------------


----------------------------------------------------------------------------------
-- Library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Entity
entity led_toggle is
      Port ( 
                SLOW_CLK    :   in std_logic;                       -- System Clock, 125MHz
                SYS_RESET   :   in std_logic;                       -- Active High Reset. Push Button BTN0
                LED_EN_Lpb  :   in std_logic;                       -- Latched LED_EN_Lpb push button value on BTN1
                LED_EN_Rpb  :   in std_logic;                       -- Latched LED_EN_Rpb push button value on BTN2
                LED         :   out std_logic_vector (3 downto 0)   -- On-board LEDs
           );
end led_toggle;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Architecture
architecture Behavioral of led_toggle is

    -- Internal signal
    signal shift_buf    :   std_logic_vector (3 downto 0);
    
begin

    process (SLOW_CLK, SYS_RESET)
    begin
        if (rising_edge(SLOW_CLK)) then
            if (SYS_RESET = '1') then                           -- On active reset
                shift_buf <= (others => '0');                   -- Set shift_but bits 0
            elsif (LED_EN_Lpb = '1') then                       -- LED Left shift Enable
                shift_buf(3 downto 1) <= shift_buf(2 downto 0); -- Left shift shift_buf bits
                shift_buf(0) <= not shift_buf(3);               
            elsif (LED_EN_Rpb = '1') then                       -- LED Right shift Enable
                shift_buf(2 downto 0) <= shift_buf(3 downto 1); -- Right Shift shift_buf bits
                shift_buf(3) <= not shift_buf(0);
            else
                shift_buf <= (others => '0');
            end if;
        end if;
    
    end process;

    LED <= shift_buf;   -- assign shift_buf to LED output

end Behavioral;
----------------------------------------------------------------------------------