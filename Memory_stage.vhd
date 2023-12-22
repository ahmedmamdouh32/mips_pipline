library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Memory_stage is
    Port ( WB 							   : in  STD_LOGIC;
		   MemtoReg						   : in  STD_LOGIC;
		   memory_read					   : in  STD_LOGIC;
		   memory_write					   : in  STD_LOGIC;	  
           alu_result 					   : in  STD_LOGIC_VECTOR (31 downto 0);
           write_data 					   : in  STD_LOGIC_VECTOR (31 downto 0);
		   register_destination			   : in  STD_LOGIC_VECTOR (4 downto 0);  
		   memory_WB_out 				   : out STD_LOGIC;
		   memory_MemtoReg_out			   : out STD_LOGIC;
		   memory_data_out				   : out STD_LOGIC_VECTOR (31 downto 0);
	       memory_register_destination_out : out STD_LOGIC_VECTOR (4 downto 0);
		   memory_alu_result_out           : out STD_LOGIC_VECTOR (31 downto 0);  
		   clk                             : in  STD_LOGIC
			  );
end Memory_stage;

architecture Behavioral of Memory_stage is
--------------------data memory-----------------
component DM is
    Port ( WriteSig    : in   STD_LOGIC;
           ReadSig     : in   STD_LOGIC;
           Clock       : in   STD_LOGIC;
		   Address     : in   STD_LOGIC_VECTOR (31 downto 0);
           DataInput   : in   STD_LOGIC_VECTOR (31 downto 0);       
		   DataOutput  : out  STD_LOGIC_VECTOR (31 downto 0));			
end component;
-------------------------------------------------
signal data_out :   STD_LOGIC_VECTOR (31 downto 0):=x"00000000";

begin
data_memory:DM port map(memory_write,memory_read,clk,alu_result,write_data,data_out);
----out--------
memory_WB_out<=WB;
memory_MemtoReg_out<=MemtoReg;
memory_data_out<=data_out;
memory_register_destination_out<=register_destination;
memory_alu_result_out<=alu_result;
end Behavioral;

