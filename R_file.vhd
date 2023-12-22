								   ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:32 11/09/2019 
-- Design Name: 
-- Module Name:    file1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity R_file is
	port(	read_address1 : in std_logic_vector(4 downto 0);
			read_address2 : in std_logic_vector(4 downto 0);
			write_address : in std_logic_vector(4 downto 0);
			write_data    : in std_logic_vector(31 downto 0);
			reg_write_en  : in std_logic;
			clk           : in std_logic;
			data1         : out std_logic_vector(31 downto 0);
			data2         : out std_logic_vector(31 downto 0)
);
end R_file;

architecture Behavioral of R_file is
type register_mem is array (0 to 31) of std_logic_vector(31 downto 0);
signal mem_reg  : register_mem := ( 0=>x"00000000",8=>x"00000006",9=>x"00000002",10=>x"00000001",11=>x"00000005",12=>x"00000007",13=>x"00000010",14=>x"00000011"   ,others => (others => '0')) ;

signal d1,d2 : std_logic_vector(31 downto 0) := x"00000000";

begin

process(clk,read_address1,read_address2,write_address,write_data,reg_write_en)
begin

--if(rising_edge(clk))then		--the value is taken fron the last value
	if(reg_write_en='1' and write_address/="00000")then
		mem_reg( to_integer(unsigned(write_address)) ) <= write_data;
	end if;
--end if;
end process;
process(clk)
begin
if(rising_edge(clk))then
	d1 <= mem_reg( to_integer(unsigned(read_address1)) );
	d2 <= mem_reg( to_integer(unsigned(read_address2)) );
end if;

end process;

data1<= d1;
data2<= d2;

end Behavioral;