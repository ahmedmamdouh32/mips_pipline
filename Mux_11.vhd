library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Mux_11 is
    Port ( input1    : in  STD_LOGIC_VECTOR (10 downto 0);
           input2    : in  STD_LOGIC_VECTOR (10 downto 0);
           output    : out STD_LOGIC_VECTOR (10 downto 0);
           selection : in  STD_LOGIC);
end Mux_11;

architecture Behavioral of Mux_11 is

begin
output <= input1 WHEN selection ='0' ELSE 
          input2; 

end Behavioral;

