library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity signal_shiftj is
port(
  signin  : in  std_logic_vector(25 downto 0);
  pc      : in  std_logic_vector(31 downto 0);
  signout : out std_logic_vector(31 downto 0)
 
);
end signal_shiftj;

architecture Behavioral of signal_shiftj is

begin
process (signin)
begin
   for i in 27 downto 2 loop
	  signout(i)<=signin(i-2);
   end loop;
	signout(1)<='0';
	signout(0)<='0';
	signout(31 downto 28)<=pc(31 downto 28);
end process;


end Behavioral;

