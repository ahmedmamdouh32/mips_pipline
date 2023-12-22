library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Write_back_stage is
    Port ( WB                          : in  STD_LOGIC;
		   MemtoReg					   : in  STD_LOGIC;
           alu_result				   : in  STD_LOGIC_VECTOR (31 downto 0);
           memory_data 				   : in  STD_LOGIC_VECTOR (31 downto 0);
		   register_destination		   : in  STD_LOGIC_VECTOR (4 downto 0);  
		   WB_register_destination_out : out STD_LOGIC_VECTOR (4 downto 0);
	       WB_register_data_out		   : out STD_LOGIC_VECTOR (31 downto 0);
	       WB_WB                       : out STD_LOGIC
		);
end Write_back_stage;

architecture Behavioral of Write_back_stage is
--------------mux 32--------------

component Mux_32 is
    Port ( input1   : in  STD_LOGIC_VECTOR (31 downto 0);
           input2   : in  STD_LOGIC_VECTOR (31 downto 0);
		   selector : in  STD_LOGIC;
           output   : out STD_LOGIC_VECTOR (31 downto 0));
end component;
-----------------------------------------
signal alu_or_memory_mux_out:std_logic_vector(31 downto 0):=x"00000000";
begin
mux_32_comp:Mux_32 port map(alu_result,memory_data,MemtoReg,alu_or_memory_mux_out);
--out------------
WB_register_destination_out <= register_destination;
WB_register_data_out        <= alu_or_memory_mux_out;
WB_WB                       <= WB;
end Behavioral;

