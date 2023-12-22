library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity if_id_reg is
    Port (	instruction_in  : in  STD_LOGIC_vector(31 downto 0);
			pc_in 			: in  STD_LOGIC_vector(31 downto 0);
			branch 			: in  STD_LOGIC_vector(31 downto 0);
			instruction_out : out STD_LOGIC_vector(31 downto 0);
			pc_out 			: out STD_LOGIC_vector(31 downto 0);
			clk				: in  STD_LOGIC;
			stall 			: in  STD_LOGIC;
			flush		    : in  STD_LOGIC
			);
	 
end if_id_reg;

architecture Behavioral of if_id_reg is
signal c        : STD_LOGIC:='0';
signal inst_alt : STD_LOGIC_vector(31 downto 0):=x"00000000";
signal pc_alt   : STD_LOGIC_vector(31 downto 0):=x"00000000";
begin

process (clk , flush ) 
begin
if(clk'event and clk ='0')then
	if(stall ='1')then
		inst_alt <=instruction_in;
		pc_alt<= pc_in;
	end if;
elsif flush='0' then
		c<='1';
		inst_alt <= x"00000000";
		pc_alt <= branch;

end if;
end process;
instruction_out <= inst_alt;
pc_out <= pc_alt;
end Behavioral;

