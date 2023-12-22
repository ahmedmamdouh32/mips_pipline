library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier is
port( clk           : in  std_logic;
      Multiplier    : in  std_logic_vector(31 downto 0);
      Multiplicand  : in  std_logic_vector(31 downto 0);
		Resultlow     : out std_logic_vector(31 downto 0);
      Resulthigh    : out std_logic_vector(31 downto 0));
end Multiplier ;

architecture Behavioral of Multiplier  is
Component Control_Test is
    Port ( ttbMplier      : in   STD_LOGIC_vector(31 downto 0); --thirty two bit 
	        ShrMplier      : out  STD_LOGIC;
			  ShlMcand       : out  STD_LOGIC; 
			  WriteProd      : out  STD_LOGIC;
			  AdderControl   : out  STD_LOGIC );
end Component;

Component Mcand_Register is
port( clk          : in std_logic ;
      InNum        : in std_logic_vector(63 downto 0);
      ShiftLeft    : in std_logic ;
		Load         : in std_logic ;
		OutNum       : out std_logic_vector(63 downto 0));
end Component;

component Multiplier_Register is
port( clk          : in std_logic ;
      InNum        : in std_logic_vector(31 downto 0);
      ShiftRight   : in std_logic ;
		Load         : in std_logic ;
		OutNum       : out std_logic_vector(31 downto 0));
end component;

component ProductReg is
port(  clk          : in std_logic;
      InNum         : in std_logic_vector(63 downto 0);
		WriteCtrl     : in std_logic ;
		OutNum        : out std_logic_vector(63 downto 0));
 end component;
 
component Simple_Adder is
    Port ( Operand1  : in   STD_LOGIC_vector(63 downto 0);
           Operand2  : in   STD_LOGIC_vector(63 downto 0);
			   Control  : in   std_logic;
            Output   : Out  STD_LOGIC_vector(63 downto 0));
end component;

component RegExtend is  
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : out  STD_LOGIC_VECTOR (63 downto 0));
end component;
 
Signal SHR : std_logic; 
Signal SHL : std_logic; 
Signal LDR     : std_logic; 
Signal MplierOut : std_logic_vector(31 downto 0); 
Signal Outextended : std_logic_vector(63 downto 0); 
Signal OutMcand : std_logic_vector(63 downto 0); 
Signal Wr_ProdSig : std_logic; 
Signal addrCtrlSig : std_logic; 
Signal addrOutSig : std_logic_VECTOR (63 downto 0); 
Signal prodOut : std_logic_vector(63 downto 0);
begin
L0:Multiplier_Register port map(clk,Multiplier,SHR,LDR,MplierOut);
L1:Control_Test port map(MplierOut,SHR,SHL,Wr_ProdSig,addrCtrlSig);
L2:RegExtend port map (Multiplicand,Outextended);
L3:Mcand_Register port map(clk,Outextended,SHL,LDR,OutMcand);
L4:Simple_Adder port map(OutMcand,prodOut,addrCtrlSig,addrOutSig);
L5:ProductReg port map(clk,addrOutSig,Wr_ProdSig,addrOutSig);
end Behavioral;
