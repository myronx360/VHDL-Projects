----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2015 04:26:35 PM
-- Design Name: 
-- Module Name: accumulator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

    entity accumulator is
        port(CLK, CLR : in std_logic;
             D : in signed(7 downto 0);
             Q : out signed(7 downto 0));
    end accumulator;
    
    architecture archi of accumulator is
        signal tmp: signed(7 downto 0);
    begin
    
        process (CLK)
        begin
            if (CLK'event and CLK='1') then
              if (CLR='1') then
                tmp <= "00000000";
              else
                tmp <= abs(tmp + D);
              end if;
            end if;
        end process;
        
        Q <= tmp;
        
    end archi;
