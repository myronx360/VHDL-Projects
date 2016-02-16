----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2015 05:00:14 PM
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
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end top;



architecture Behavioral of top is

-- 1
component encoder is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           a : out STD_LOGIC;
           b : out STD_LOGIC;
           c : out STD_LOGIC;
           d : out STD_LOGIC;
           e : out STD_LOGIC;
           f : out STD_LOGIC;
           g : out STD_LOGIC
          );
end component;

component ssd_muxer is
    Port (
        a_in       : in  std_logic_vector(3 downto 0);
        b_in       : in  std_logic_vector(3 downto 0);
        c_in       : in  std_logic_vector(3 downto 0);
        d_in       : in  std_logic_vector(3 downto 0);
        e_in       : in  std_logic_vector(3 downto 0);
        f_in       : in  std_logic_vector(3 downto 0);
        g_in       : in  std_logic_vector(3 downto 0);
        decp0_in   : in  std_logic;
        decp1_in   : in  std_logic;
        decp2_in   : in  std_logic;
        decp3_in   : in  std_logic;
        seg_out    : out std_logic_vector(6 downto 0);
        dp_out     : out std_logic;
        an_out     : out std_logic_vector(3 downto 0);
        clk        : in  STD_LOGIC
    );
end component;

signal hex  : STD_LOGIC_VECTOR (3 downto 0);

signal a_Bus    : std_logic_vector(3 downto 0);
signal b_Bus    : std_logic_vector(3 downto 0);
signal c_Bus   : std_logic_vector(3 downto 0);
signal d_Bus    : std_logic_vector(3 downto 0);
signal e_Bus    : std_logic_vector(3 downto 0);
signal f_Bus    : std_logic_vector(3 downto 0);
signal g_Bus   : std_logic_vector(3 downto 0);


begin


    encoder1 : encoder port map (
          hex => sw(15 downto 12),
          a   => a_Bus(3),
          b   => b_Bus(3),
          c   => c_Bus(3),
          d   => d_Bus(3),
          e   => e_Bus(3),
          f   => f_Bus(3),
          g   => g_Bus(3)    
    );
   
     encoder2 : encoder port map (
          hex => sw(11 downto 8),
          a   => a_Bus(2),
          b   => b_Bus(2),
          c   => c_Bus(2),
          d   => d_Bus(2),
          e   => e_Bus(2),
          f   => f_Bus(2),
          g   => g_Bus(2)    
    );

     encoder3 : encoder port map (
          hex => sw(7 downto 4),
          a   => a_Bus(1),
          b   => b_Bus(1),
          c   => c_Bus(1),
          d   => d_Bus(1),
          e   => e_Bus(1),
          f   => f_Bus(1),
          g   => g_Bus(1)    
    );

    encoder4 : encoder port map (
          hex => sw(3 downto 0),
          a   => a_Bus(0),
          b   => b_Bus(0),
          c   => c_Bus(0),
          d   => d_Bus(0),
          e   => e_Bus(0),
          f   => f_Bus(0),
          g   => g_Bus(0)    
    );

    ssd_muxer_inst : ssd_muxer port map (
        a_in => a_Bus,
        b_in => b_Bus,
        c_in => c_Bus,
        d_in => d_Bus,
        e_in => e_Bus,
        f_in => f_Bus,
        g_in => g_Bus,        
       
        decp0_in  => '0',
        decp1_in  => '0',
        decp2_in  => '0',
        decp3_in  => '0',
         
        clk => clk,
         
       seg_out => seg,
       an_out  => an,
       dp_out  => dp
     );
     
    led <= sw;
end Behavioral;
