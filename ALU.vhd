library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A          : in   STD_LOGIC_VECTOR (31 downto 0);
           B          : in   STD_LOGIC_VECTOR (31 downto 0);
           ALUCONTROL : in   STD_LOGIC_VECTOR (3 downto 0);
           ALUResult  : out  STD_LOGIC_VECTOR (31 downto 0);
           zero       : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal result : std_logic_vector(31 downto 0):=x"00000000";
begin
	
	process(ALUCONTROL,A,B)
    begin
		
		case ALUCONTROL is
		when "0010"=>			--add
		result<=A+B;
		when "0110"=>			--sub
		result<=A-B;
		when "0000"=>			--and
		result<=A and B;
		when "0001"=>			--or
		result<=A or B;
		when "0111"=>			--slt
		if (A<B) then
		   result <= x"00000001";
		  else 
		   result <= x"00000000";
		  end if;
		when others => result <= a + b; -- add
		end case;
		
	end process; 
	
	zero <= '1' when result=x"00000000" else '0';
	ALUResult <= result; 
	
end Behavioral;