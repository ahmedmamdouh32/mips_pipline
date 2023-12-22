library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux_4_1 is
    Port ( input1 : in   STD_LOGIC_VECTOR (31 downto 0);
           input2 : in   STD_LOGIC_VECTOR (31 downto 0);
           input3 : in   STD_LOGIC_VECTOR (31 downto 0);
           input4 : in   STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel    : in   STD_LOGIC_vector(1 downto 0));
end mux_4_1;

architecture Behavioral of mux_4_1 is
signal mux_out : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
begin
process(input1,input2,input3,input4,sel)
begin
	if(sel="00")then
	mux_out<=input1;
	elsif(sel="01")then
	mux_out<=input2;
	elsif(sel="10")then
	mux_out<=input3;
	elsif(sel="11")then
	mux_out<=input4;
	end if;
	end process;
	output<=mux_out;
end Behavioral;

