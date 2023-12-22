library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Excute_stage is
    Port ( 
			WB								: in  STD_LOGIC;
			register1_data 					: in  STD_LOGIC_VECTOR (31 downto 0);		--register 1 data
            register2_data 					: in  STD_LOGIC_VECTOR (31 downto 0);		--register 2 data
			alu_forward_data 				: in  STD_LOGIC_VECTOR (31 downto 0);		--alu forwarding data
			memory_forward_data				: in  STD_LOGIC_VECTOR (31 downto 0);	--memory forwarding data
		    forward_A						: in  STD_LOGIC_VECTOR (1 downto 0);					--selection of forwarding
			forward_B						: in  STD_LOGIC_VECTOR (1 downto 0);					--selection of forwarding  
			alu_op							: in  STD_LOGIC_VECTOR (1 downto 0);
			AluSrc							: in  STD_LOGIC;  
			MemRead  						: in  STD_LOGIC;
			MemtoReg 						: in  STD_LOGIC;
	     	MemWrite 						: in  STD_LOGIC;
			RegWrite 						: in  STD_LOGIC;
			RegDest                         : in  STD_LOGIC; 
			sign_extend                     : in  STD_LOGIC_VECTOR (31 downto 0);	 
			instruction                     : in  STD_LOGIC_VECTOR (31 downto 0);  
		    excute_MemRead_out              : out STD_LOGIC;
		    excute_MemtoReg_out             : out STD_LOGIC;
   		    excute_MemWrite_out             : out STD_LOGIC;
		    excute_RegWrite_out             : out STD_LOGIC;
		    excute_alu_out                  : out STD_LOGIC_VECTOR(31 downto 0);
		    excute_desrination_register_out : out STD_LOGIC_VECTOR(4 downto 0);
		    data_for_memory                 : out STD_LOGIC_VECTOR(31 downto 0);		--data that stored in memory
		    excute_WB_out                   : out STD_LOGIC 
			  );
end Excute_stage;

architecture Behavioral of Excute_stage is
---------------mux 4*1----------------------
component mux_4_1 is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           input4 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel    : in  STD_LOGIC_vector(1 downto 0));
end component;
-------------------------------------------------
------------------------mux 32 bit------------------
component Mux_32 is
    Port ( input1   : in  STD_LOGIC_VECTOR (31 downto 0);
           input2   : in  STD_LOGIC_VECTOR (31 downto 0);
		   selector : in  STD_LOGIC;
           output   : out STD_LOGIC_VECTOR (31 downto 0));
end component;
----------------------------------------------------------
----------------------------alu control-----------------------
component ALU_CONTROL is
    Port ( ALUOP   : in   STD_LOGIC_VECTOR (1 downto 0);
           INST    : in   STD_LOGIC_VECTOR (5 downto 0);
           control : out  STD_LOGIC_VECTOR (3 downto 0));
end component;
---------------------------------------------------------------
----------------------------------alu----------------------------
component ALU is
    Port ( A          : in STD_LOGIC_VECTOR (31 downto 0);
           B          : in STD_LOGIC_VECTOR (31 downto 0);
           ALUCONTROL : in STD_LOGIC_VECTOR (3 downto 0);
           ALUResult  : out STD_LOGIC_VECTOR (31 downto 0);
           zero       : out STD_LOGIC);
end component;
-----------------------------------------------------------------
--------------------------------mux 5-------------------------
component Mux_5 is
    Port ( a       : in  STD_LOGIC_VECTOR (4 downto 0);
           b       : in  STD_LOGIC_VECTOR (4 downto 0);
           s       : in  STD_LOGIC;
           out_mux : out  STD_LOGIC_VECTOR (4 downto 0));
end component;
----------------------------------------------------------------
signal forward_A_mux_out    : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal forward_B_mux_out    : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal Alu_second_input_mux : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal alu_control_out      : STD_LOGIC_VECTOR (3 downto 0):="0000";
signal Alu_result           : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal zero_flag            : STD_LOGIC:='0';
signal register_destination : STD_LOGIC_VECTOR(4 downto 0):="00000";		--rt or rd
begin 
forward_A_mux_comp       : mux_4_1     port map(register1_data,memory_forward_data,alu_forward_data,x"00000000",forward_A_mux_out,forward_A);
forward_B_mux_comp       : mux_4_1     port map(register2_data,memory_forward_data,alu_forward_data,x"00000000",forward_B_mux_out,forward_B);
mux_32_comp              : Mux_32      port map(forward_B_mux_out,sign_extend,AluSrc,Alu_second_input_mux);
alu_control_comp         : ALU_CONTROL port map(alu_op,instruction(5 downto 0),alu_control_out);
alu_comp                 : ALU         port map(forward_A_mux_out,Alu_second_input_mux,alu_control_out,Alu_result,zero_flag);
register_destination_mux : Mux_5       port map(instruction(20 downto 16),instruction(15 downto 11),RegDest,register_destination);

		 
--------out--------
excute_MemRead_out              <= MemRead;
excute_MemtoReg_out             <= MemtoReg;
excute_MemWrite_out             <= MemWrite;
excute_RegWrite_out             <= RegWrite;
excute_alu_out                  <= Alu_result;
excute_desrination_register_out <= register_destination;
data_for_memory                 <= register2_data;
excute_WB_out                   <= WB;
end Behavioral;