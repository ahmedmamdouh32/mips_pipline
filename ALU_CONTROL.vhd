library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_CONTROL is
    Port ( ALUOP   : in   STD_LOGIC_VECTOR (1 downto 0);
           INST    : in   STD_LOGIC_VECTOR (5 downto 0);
           control : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU_CONTROL;

architecture Behavioral of ALU_CONTROL is

begin

process(ALUOP,INST)
	begin
		if(ALUOP="00")then --load/store & Addi
			control<="0010";
		elsif(ALUOP="01")then --Beq
			control<="0110";
		elsif(ALUOP="10")then
		
			if(INST="100000")then	--add
				control<="0010";
			elsif(INST="100010")then	--sub
				control<="0110";
			elsif(INST="100100")then 	--and
				control<="0000";
			elsif(INST="100101")then	--or
				control<="0001";
			elsif(INST="101010")then	--slt
				control<="0111";
			else
				control<="1111";
			end if;
			
		end if;
	end process;
	
end Behavioral;

