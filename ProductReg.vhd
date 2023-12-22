library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ProductReg is
port(  clk          : in std_logic;
      InNum         : in std_logic_vector(63 downto 0);
		WriteCtrl     : in std_logic ;
		OutNum        : out std_logic_vector(63 downto 0));
 end ProductReg;
 
architecture Behavioral of ProductReg is
Signal InNumSig      :  std_logic_vector(63 downto 0):=x"0000000000000000";
Signal RegContent    :  std_logic_vector(63 downto 0):=x"0000000000000000";
Signal WriteCtrlSig  :  std_logic:='0';
Signal OutNumSig     :  std_logic_vector(63 downto 0):=x"0000000000000000";
begin
InNumSig<=InNum;
OutNum <=OutNumSig;
process(WriteCtrlSig,InNumSig)
begin
if (WriteCtrlSig='1') then
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

