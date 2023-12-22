library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity signextentest is
port (
	 signin  : in  std_logic_vector(15 downto 0);
	 signout : out std_logic_vector(31 downto 0)
					
);
end signextentest;

architecture Behavioral of signextentest is
signal sout : std_logic_vector(31 downto 0):=x"00000000";
begin
process(signin)
begin
  if signin(15)<='0' then
     sout<= "0000000000000000" & signin;
	 elsif signin(15)<='1' then
     sout<= "1111111111111111" & signin;
   end if;
end process;
  signout<=sout;
end Behavioral;

