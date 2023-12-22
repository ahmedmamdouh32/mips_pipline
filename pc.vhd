library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
    Port ( load   : in  STD_LOGIC_VECTOR (31 downto 0);
	       Clk    : in  STD_LOGIC; 
		   flush  : in  STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0)
	);
end pc;

architecture Behavioral of pc is
signal alt : std_logic_vector(31 downto 0):=x"00000000";  
begin
	output<=alt;
	
	process(Clk,load)
		begin
		if (Clk='1' and Clk'event) then
		if(flush='1')then
		alt<=load;
		else
		alt <=alt;
		end if;
		end if;
	end process; 
	
end Behavioral;

