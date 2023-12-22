library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity DM is
    Port ( WriteSig   : in  STD_LOGIC;
           ReadSig    : in  STD_LOGIC;
           Clock      : in  STD_LOGIC;
		   Address    : in  STD_LOGIC_VECTOR (31 downto 0);
           DataInput  : in  STD_LOGIC_VECTOR (31 downto 0);       
	       DataOutput : out STD_LOGIC_VECTOR (31 downto 0));			
end DM;

architecture Behavioral of DM is
-- define the new type for the 20 x 32 Data memory
signal data : std_logic_vector(31 downto 0):=x"00000000";

type DataMemArray is array(0 to 31) of std_logic_vector(31 downto 0) ;
--initial vakues for words of the memory 
signal MemoryContent : DataMemArray:=(others=>(others=>'0')) ;
begin
   
DataOutput<=data;
	
process(Clock,Address,WriteSig,ReadSig)
begin
 if(rising_edge(Clock)) then
	 if(WriteSig ='1') then 
			MemoryContent(to_integer(unsigned( Address(4 downto 0) ))) <= DataInput  ;
	 elsif (ReadSig ='1') then
			data <= MemoryContent(to_integer(unsigned(Address(4 downto 0)))) ;
	 end if;
 end if;
end process;
	
end Behavioral;

