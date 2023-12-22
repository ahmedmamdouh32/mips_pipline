library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ForwardingUnit is
port( XM_RegWrite:in std_logic;
      MW_RegWrite:in std_logic;
      DX_Rs:in std_logic_vector(4 downto 0);
      DX_Rt:in std_logic_vector(4 downto 0);
		XM_Rd:in std_logic_vector(4 downto 0);
		MW_Rd:in std_logic_vector(4 downto 0);
		ForwardA:out std_logic_vector(1 downto 0);
		ForwardB:out std_logic_vector(1 downto 0));
end ForwardingUnit;

architecture Behavioral of ForwardingUnit is
signal FOR_A_ALT : std_logic_vector(1 downto 0) :="00";
signal FOR_B_ALT : std_logic_vector(1 downto 0) :="00";
begin
 FORWARDA<=FOR_A_ALT;
FORWARDB<=FOR_B_ALT;
process(XM_Rd,MW_Rd,XM_RegWrite,DX_Rs,DX_Rt)
begin 

if( (XM_RegWrite='1')and(XM_Rd /= "00000")and (XM_Rd = DX_Rs) )then
FOR_A_ALT<="10";
elsif((MW_RegWrite='1')and(MW_Rd /= "00000")and(MW_Rd = DX_Rs) )then
FOR_A_ALT<="01";
else
FOR_A_ALT<="00";
end if;

--and (alusrc /= "00")and (alu_src_xm/="01"  )
if((XM_RegWrite='1')and(XM_Rd /= "00000")and(XM_Rd = DX_Rt) )then
FOR_B_ALT<="10";
elsif((MW_RegWrite='1')and(MW_Rd /= "00000")and(MW_Rd = DX_Rt) )then
FOR_B_ALT<="01";
else 
FOR_B_ALT<="00";
end if;

end process;
end Behavioral;