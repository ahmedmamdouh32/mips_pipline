library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_mux is
    Port ( control: in  STD_LOGIC_vector(9 downto 0);
				sel : in std_logic;
				control_out : out std_logic_vector(9 downto 0)
	 
	 );
end control_mux;

architecture Behavioral of control_mux is
signal alt : std_logic_vector(9 downto 0):="0000000000";
begin

control_out<=alt;
alt<= "0000000000" when sel ='0' else
		control;

end Behavioral;

