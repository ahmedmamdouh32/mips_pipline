library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Mcand_Register is
port( clk          : in std_logic ;
      InNum        : in std_logic_vector(63 downto 0);
      ShiftLeft    : in std_logic ;
		Load         : in std_logic ;
		OutNum       : out std_logic_vector(63 downto 0)
 );
end Mcand_Register;

architecture Behavioral of Mcand_Register is
Signal InNumSig      :  std_logic_vector(63 downto 0);
Signal RegContent    :  std_logic_vector(63 downto 0);
Signal ShiftLeftSig  :  std_logic;
Signal LoadSig       :  std_logic;
Signal OutNumSig     :  std_logic_vector(63 downto 0);
begin
InNumSig<=InNum;
OutNum<=OutNumSig;
process(ShiftLeftSig,RegContent,LoadSig,InNumSig)
begin
if (ShiftLeftSig='1') then
RegContent(0)<='0';
for i in 1 to 63 loop
RegContent(i)<=RegContent(i-1);
end loop;
end if;

if (LoadSig='1') then
RegContent<=InNumSig;
end if;
end process;

process(clk)
begin
RegContent<=InNumSig;
OutNumSig<=RegContent;
end process;

end Behavioral;

