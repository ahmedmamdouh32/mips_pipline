library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity forward_mux is
    Port ( input1 : in  STD_LOGIC_vector(31 downto 0):=x"00000000";
				input2 : in  STD_LOGIC_vector(31 downto 0):=x"00000000";
				input3 : in  STD_LOGIC_vector(31 downto 0):=x"00000000";
				output : out  STD_LOGIC_vector(31 downto 0);
				sel: in std_logic_vector(1 downto 0)
	 
	 );
end forward_mux;

architecture Behavioral of forward_mux is
signal out_alt : std_logic_vector(31 downto 0):= x"00000000";
begin

process(sel,input1,input2,input3)
begin

if(sel="00")then
	out_alt<=input1;
elsif(sel="01")then
	out_alt<=input2;
elsif(sel="10")then
	out_alt<=input3;
else
	out_alt<=x"00000000";
end if;
end process;
output<=out_alt;
end Behavioral;

