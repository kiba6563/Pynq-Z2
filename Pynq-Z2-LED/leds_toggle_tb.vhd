----------------------------------------------------------------------------------
--
-- Engineer: Kishore Bachu
-- Date: 07-March-2023
-- Title: Test Bench 
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- entity, no port list for test bench
entity leds_toggle_tb is
end entity leds_toggle_tb;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- architecture
architecture Behavioral of leds_toggle_tb is

    -- Component declaration of UUT
    component leds_toggle_top 
        port (
                SYS_CLK     :   in std_logic;           
                SYS_RESET   :   in std_logic;           
                LED_EN_L    :   in std_logic;           
                LED_EN_R    :   in std_logic;           
                LED         :   out std_logic_vector (3 downto 0)          
             );
    end component;
    
    -- Component declaration of slow_clock module
    component slow_clock is
        port (
                SYS_CLK     :  in std_logic;            
                SYS_RESET   :  in std_logic;        
                SLOW_CLK    :  out std_logic        
             );
    end component;
    
    -- Component declaration of push_button module
    component push_button is
        port (
                SYS_RESET   :   in std_logic;       
                LED_EN_L    :   in std_logic;       
                LED_EN_R    :   in std_logic;       
                LED_EN_Lpb  :   out std_logic;      
                LED_EN_Rpb  :   out std_logic       
             );
    end component;
    
    -- Component declaration of led_toggle module
    component led_toggle is
        port (
                SLOW_CLK    :   in std_logic;
                SYS_RESET   :   in std_logic;
                LED_EN_Lpb  :   in std_logic;
                LED_EN_Rpb  :   in std_logic;
                LED         :   out std_logic_vector (3 downto 0)
             );
    end component;
    
    -- Test bench signals
    signal SYS_CLK_tb       :   std_logic;
    signal SYS_RESET_tb     :   std_logic;
    signal LED_EN_L_tb      :   std_logic;
    signal LED_EN_R_tb      :   std_logic;
    signal LED_tb           :   std_logic_vector (3 downto 0);
    
    -- constants
    constant T	:	time := 8 ns;	--Clock period
    
begin

    -- UUT instantiation
    UUT :  leds_toggle_top 
        port map (
                SYS_CLK     =>  SYS_CLK_tb,
                SYS_RESET   =>  SYS_RESET_tb,
                LED_EN_L    =>  LED_EN_L_tb,
                LED_EN_R    =>  LED_EN_R_tb,
                LED         =>  LED_tb
             );
    
    -- Clock generation
    sync_proc   :   process
        begin
            SYS_CLK_tb <= '0';
            wait for T/2;       -- First half period
            SYS_CLK_tb <= '1';
            wait for T/2;       -- Second half period    
        end process sync_proc;          

    -- Stimulus
    stim_proc   :   process
        begin
            SYS_RESET_tb <= '0';
            LED_EN_L_tb <= '0';
            LED_EN_R_tb <= '0';
            wait for T;
            SYS_RESET_tb <= '1';
            wait for 2*T;
            SYS_RESET_tb <= '0';
            wait for 5*T;
            
            LED_EN_L_tb <= '1';
            wait for 10*T;
            LED_EN_L_tb <= '0';
            wait for 2*T;
            LED_EN_R_tb <= '1';
            wait for 10*T;
            LED_EN_R_tb <= '0';
            wait for 2*T;
            
        end process stim_proc;
        
end Behavioral;
----------------------------------------------------------------------------------