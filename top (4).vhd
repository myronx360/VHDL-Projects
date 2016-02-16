----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2015 06:49:48 PM
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           btnR : in STD_LOGIC;
           btnL : in STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

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
    
    component debounce is
        Port (   
             CLK_100M : in std_logic;
             SW       : in std_logic;
             sglPulse : out std_logic;
             Sig      : out std_logic
             );
    end component;
   
    
    
    signal a_Bus   : std_logic_vector(3 downto 0);
    signal b_Bus   : std_logic_vector(3 downto 0);
    signal c_Bus   : std_logic_vector(3 downto 0);
    signal d_Bus   : std_logic_vector(3 downto 0);
    signal e_Bus   : std_logic_vector(3 downto 0);
    signal f_Bus   : std_logic_vector(3 downto 0);
    signal g_Bus   : std_logic_vector(3 downto 0);
    
    signal btn_en      : std_logic;
    signal btn_clr     : std_logic;
   
    signal input        :  std_logic_vector(7 downto 0);
    signal prev_Input   :  std_logic_vector(7 downto 0);
    signal output       :  std_logic_vector(7 downto 0);
                
               
begin

    

 
    encoder0: encoder port map(
         hex => output(7 downto 4),
         a   => a_Bus(1),
         b   => b_Bus(1),
         c   => c_Bus(1),
         d   => d_Bus(1),
         e   => e_Bus(1),
         f   => f_Bus(1),
         g   => g_Bus(1) 
    );
    

    encoder1: encoder port map(
            hex => output(3 downto 0),
            a   => a_Bus(0),
            b   => b_Bus(0),
            c   => c_Bus(0),
            d   => d_Bus(0),
            e   => e_Bus(0),
            f   => f_Bus(0),
            g   => g_Bus(0)  
    );
                    
    ssd_muxer_int: ssd_muxer port map(
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
    
    debounce_en : debounce port map(
        CLK_100M => clk,
        SW => btnL,
        sglpulse => btn_en,
        sig => open 
     ); 
     
    debounce_clr : debounce port map(
         CLK_100M => clk,
         SW => btnR,
         sglpulse => btn_clr,
         sig => open 
      );
      
       --  accumulator
        process (clk)
        variable total : std_logic_vector (7 downto 0);
            begin
                if (clk'event and clk='1') then
                    total := std_logic_vector(signed(input)+signed(prev_Input));            
                  if (btn_clr ='1') then
                   output <= "00000000";
                   prev_Input <= "00000000";
                   g_Bus(2) <= '0';
                  elsif (btn_en = '1') then
                    if (signed(total) >= 0) then
                        output <= total;
                        prev_Input <= total;
                        g_Bus(2) <= '0';
                    elsif (signed(total)<0) then
                        output <= std_logic_vector(abs(signed(total)));
                        prev_Input <= total;
                        g_Bus(2) <= '1';
                    end if;
                  end if;         
                end if;
            end process;
                 

    input <= sw(7 downto 0);    
    led <= sw;

end Behavioral;
