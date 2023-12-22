----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity HAZZARD_UNIT is
    Port ( 	mem_read : in  STD_LOGIC;
				id_ex_rt : in std_logic_vector(4 downto 0);
				if_id_rs : in std_logic_vector(4 downto 0);
				if_id_rt : in std_logic_vector(4 downto 0);
				
				pc_flush : out std_logic;
				if_id_flush : out std_logic;
				mux_flush : out std_logic

	 );
end HAZZARD_UNIT;

architecture Behavioral of HAZZARD_UNIT is
signal pc_alt : std_logic:='0';
signal f_d_alt : std_logic:='0';
signal mux_alt : std_logic:='0';
begin

-- ID/EX.MemRead and  ((ID/EX.RegisterRt = IF/ID.RegisterRs) or  (ID/EX.RegisterRt = IF/ID.RegisterRt))
pc_flush<=pc_alt;
if_id_flush<=f_d_alt;
mux_flush<=mux_alt;

process ( mem_read , id_ex_rt , if_id_rs , if_id_rt)
begin 
if( (mem_read='1' )and( (id_ex_rt = if_id_rs) or (id_ex_rt = if_id_rt) ) )then 
pc_alt<='0';
f_d_alt<='0';
mux_alt<='0';
else

pc_alt<='1';
f_d_alt<='1';
mux_alt<='1';
end if;


end process;

end Behavioral;

