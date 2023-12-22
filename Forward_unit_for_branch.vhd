library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Forward_unit_for_branch is
    Port ( XM_RegWrite : in  std_logic;
           MW_RegWrite : in  std_logic;
		   FD_RegWrite : in  std_logic;
           FD_Rs  	   : in  std_logic_vector(4 downto 0);
           FD_Rt	   : in  std_logic_vector(4 downto 0);
	       XM_Rd	   : in  std_logic_vector(4 downto 0);
	       MW_Rd	   : in  std_logic_vector(4 downto 0);
		   ForwardA    : out std_logic_vector(1 downto 0);
		   ForwardB    : out std_logic_vector(1 downto 0)
		   );
end Forward_unit_for_branch;

architecture Behavioral of Forward_unit_for_branch is
signal FOR_A_ALT : std_logic_vector(1 downto 0) :="00";
signal FOR_B_ALT : std_logic_vector(1 downto 0) :="00";
begin
 FORWARDA<=FOR_A_ALT;
FORWARDB<=FOR_B_ALT;
process(XM_RegWrite,XM_Rd,MW_Rd,XM_RegWrite,FD_Rs,FD_Rt,FD_RegWrite,MW_RegWrite)
begin 

if((XM_RegWrite='1')and(XM_Rd /= "00000")and(XM_Rd = FD_Rs))then
FOR_A_ALT<="10";
elsif((MW_RegWrite='1')and(MW_Rd /= "00000")and(MW_Rd = FD_Rs))then
FOR_A_ALT<="01";
else
FOR_A_ALT<="00";
end if;


if((XM_RegWrite='1')and(XM_Rd /= "00000")and(XM_Rd = FD_Rt))then
FOR_B_ALT<="10";
elsif((MW_RegWrite='1')and(MW_Rd /= "00000")and(MW_Rd = FD_Rt))then
FOR_B_ALT<="01";
else 
FOR_B_ALT<="00";
end if;

end process;


end Behavioral;

