library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Control_Test is
    Port ( ttbMplier      : in   STD_LOGIC_vector(31 downto 0); --thirty two bit 
	        ShrMplier      : out  STD_LOGIC;
			  ShlMcand       : out  STD_LOGIC; 
			  WriteProd      : out  STD_LOGIC;
			  AdderControl   : out  STD_LOGIC );
end Control_Test;

architecture Behavioral of Control_Test is
Signal ttbMplierSig:STD_LOGIC_vector(31 downto 0);
Signal ShrMplierSig:STD_LOGIC; 
Signal ShlMcandSig:STD_LOGIC;
Signal WriteProdSig :STD_LOGIC;
Signal AdderControlSig :STD_LOGIC;
begin
ttbMplierSig<=ttbMplier;
ShrMplier<=ShrMplierSig;
ShlMcand <=ShlMcandSig;
WriteProd<=WriteProdSig;
AdderControl<=AdderControlSig;
process(ttbMplierSig)
begin
if(ttbMplierSig(0)='0')then
ShrMplier<='1';
ShlMcand <='1';
WriteProd<='0';
AdderControl<='0';
else
ShrMplier<='1';
ShlMcand <='1';
WriteProd<='1';
AdderControl<='1';
end if;
end process;
end Behavioral;

