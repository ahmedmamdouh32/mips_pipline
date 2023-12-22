library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity subtractor is
    Port ( input1   : in  STD_LOGIC_VECTOR (31 downto 0);
           input2   : in  STD_LOGIC_VECTOR (31 downto 0);
           output   : out STD_LOGIC_VECTOR (31 downto 0);
           zeroFlag : out STD_LOGIC;
		   clk      : in  std_logic);
end subtractor;

architecture Behavioral of subtractor is
signal result : STD_LOGIC_VECTOR (31 downto 0):=x"00000000" ;
begin
	
	result<=input1-input2;
	
	output<=result;
	zeroFlag <= '1' when result=x"00000000" else '0';
	
end Behavioral;

