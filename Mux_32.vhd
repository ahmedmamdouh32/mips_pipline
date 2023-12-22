library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux_32 is
    Port ( input1   : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           input2   : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
		   selector : in  STD_LOGIC;
           output   : out STD_LOGIC_VECTOR (31 downto 0));
end Mux_32;

architecture Behavioral of Mux_32 is

begin
output <= input1 WHEN selector ='0' else
          input2 ; 

end Behavioral;

