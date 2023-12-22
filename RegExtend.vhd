library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegExtend is  
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : out  STD_LOGIC_VECTOR (63 downto 0));
end RegExtend;

architecture Behavioral of RegExtend is
Signal asig:STD_LOGIC_VECTOR (31 downto 0);
Signal bsig:STD_LOGIC_VECTOR (63 downto 0);
begin
process(asig)
begin
bsig<="00000000000000000000000000000000" & asig ;
end process;
asig<=a;
b<=bsig;
end Behavioral;

