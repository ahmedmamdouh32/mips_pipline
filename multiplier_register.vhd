library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier_Register is
port( clk          : in std_logic ;
      InNum        : in std_logic_vector(31 downto 0);
      ShiftRight   : in std_logic ;
		Load         : in std_logic ;
		OutNum       : out std_logic_vector(31 downto 0));
end Multiplier_Register;

architecture Behavioral of Multiplier_Register is
Signal InNumSig      :  std_logic_vector(31 downto 0);
Signal RegContent    :  std_logic_vector(31 downto 0);
Signal ShiftRightSig :  std_logic;
Signal LoadSig       :  std_logic;
Signal OutNumSig     :  std_logic_vector(31 downto 0);
begin

InNumSig<=InNum;
OutNum<=OutNumSig;

process(LoadSig,ShiftRightSig,RegContent,InNumSig)
begin
if (ShiftRightSig='1') then
RegContent(31)<='0';
for i in 0 to 30 loop
RegContent(i)<=RegContent(i+1);
end loop;
end if;

if (LoadSig='1') then
RegContent<=InNumSig;
end if;
end process;

process(clk)
begin
if(clk'event and clk='1')then
RegContent<=InNumSig;
OutNumSig<=RegContent;
end if;
end process;
end Behavioral;

