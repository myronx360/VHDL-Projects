----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2015 07:12:57 PM
-- Design Name: 
-- Module Name: encoder - Behavioral
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

entity encoder is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           a : out STD_LOGIC;
           b : out STD_LOGIC;
           c : out STD_LOGIC;
           d : out STD_LOGIC;
           e : out STD_LOGIC;
           f : out STD_LOGIC;
           g : out STD_LOGIC
          );
     end encoder;

architecture Behavioral of encoder is

begin
 
a <= '0' when (hex = "0001" or hex = "0100" or hex = "1011" or hex = "1101") else
     '1';

b <= '0' when (hex = "0101" or hex = "0110" or hex = "1011" or hex = "1100" or hex = "1110" or hex = "1111") else
     '1';
  
c <= '0' when (hex = "0010" or hex = "1100" or hex = "1110" or hex = "1111") else
     '1';

d <= '0' when (hex = "0001" or hex = "0100" or hex = "0111" or hex = "1010" or hex = "1111") else
     '1';
     
e <= '0' when (hex = "0001" or hex = "0011" or hex = "0100" or hex = "0101" or hex = "0111" or hex = "1001") else
     '1';

f <= '0' when (hex = "0001" or hex = "0010" or hex = "0011" or hex = "0111" or hex = "1101") else
     '1';
     
g <= '0' when (hex = "0000" or hex = "0001" or hex = "0111" or hex = "1100") else
     '1';
     
end Behavioral;
