library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Fetch_stage is
    Port ( pc_load : in  STD_LOGIC;
				pc_data:in std_logic_vector(31 downto 0);
				clk:in std_logic;
				
				IM_data:out std_logic_vector(31 downto 0);
				pc4:out std_logic_vector(31 downto 0)
				
				
				);
end Fetch_stage;

architecture Behavioral of Fetch_stage is
------------------pc comp---------------------
component pc is
    Port ( load   : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk    : in  STD_LOGIC;
		   flush  : in  STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;
------------------instruction comp------------------------
component IM is
    Port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component ;
--------------------------------------------------------------------
signal pc_out:std_logic_vector(31 downto 0):=x"00000000";
begin

pc_comp: pc port map(pc_data,clk,pc_load,pc_out);
IM_comp:IM port map(pc_out,IM_data);
pc4<=pc_out+4;


end Behavioral;

