----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2015 04:55:00 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           btnR : in STD_LOGIC;
           btnL : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is


component debounce is
    Port (
        CLK_100M : in std_logic;
        SW : in std_logic;
        sglPulse : out std_logic;
        Sig : out std_logic
    );
end component;

signal btn_store : std_logic;
signal btn_test  : std_logic;

begin

    debounce_L : debounce port map(
        CLK_100M => clk,
        SW => btnL,
        sglpulse => btn_test,
        sig => open
    );
    
    debounce_R : debounce port map(
        CLK_100M => clk,
        SW => btnR,
        sglpulse => btn_store,
        sig => open
    );

led(7 downto 0) <= sw(7 downto 0);



process (clk)
variable storeValue : std_logic_vector (7 downto 0);
variable testValue : std_logic_vector (7 downto 0);
begin
    if (clk'event and clk='1') then
        -- store value
        if (btn_store ='1') then
            storeValue := sw;
            led(15) <= '0';                 
        end if;
       
        if (btn_test = '1') then
            testValue := sw;
            if(storeValue = testValue) then
                led(15) <= '1'; -- test successful
            else
                led(15) <= '0'; -- test failed
            end if;
        end if;
    end if;
end process;
end Behavioral;
