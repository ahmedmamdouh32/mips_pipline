library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux_5 is
    Port ( a       : in   STD_LOGIC_VECTOR (4 downto 0);
           b       : in   STD_LOGIC_VECTOR (4 downto 0);
           s       : in   STD_LOGIC;
           out_mux : out  STD_LOGIC_VECTOR (4 downto 0));
end Mux_5;

architecture Behavioral of Mux_5 is

begin

out_mux <= a WHEN s ='0' ELSE 
           b; 

end Behavioral;

