library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity signal_shift is
port(
 signin  : in  std_logic_vector(31 downto 0);
 signout : out std_logic_vector(31 downto 0)
 
);
end signal_shift;

architecture Behavioral of signal_shift is
begin

   signout<=signin(29 downto 0) & "00";


end Behavioral;

