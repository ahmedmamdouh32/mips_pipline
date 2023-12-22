library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adder is
    Port ( input1 : in   STD_LOGIC_VECTOR (31 downto 0);
           input2 : in   STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end adder;

architecture Behavioral of adder is

begin
   output <= input1 + input2; 


end Behavioral;

