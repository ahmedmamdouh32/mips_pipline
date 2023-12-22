library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mem_wb_reg is
    Port ( input : in  STD_LOGIC_vector(70 downto 0);
				output: out STD_LOGIC_vector(70 downto 0);
				clk : in STD_LOGIC
	 );
end mem_wb_reg;

architecture Behavioral of mem_wb_reg is

signal alternative : std_logic_vector(70 downto 0):=(others => '0');

begin

output <= alternative;

process (clk)
begin 
if(clk'event and clk ='0')then
	alternative<= input;
end if;

end process;

end Behavioral;

