library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decode_stage is
    Port (instruction                : in  STD_LOGIC_VECTOR (31 downto 0);
          pc4                        : in  STD_LOGIC_VECTOR (31 downto 0);
		  write_register_data        : in  STD_LOGIC_VECTOR (31 downto 0);	--register data
		  write_register             : in  STD_LOGIC;										--write reg enable
		  register_destination       : in  STD_LOGIC_VECTOR (4 downto 0);		--register destination
	      mux_flush                  : in  STD_LOGIC;											--mux flush(0 or control unit signals)
	      alu_forward_data           : in  STD_LOGIC_VECTOR (31 downto 0);
		  memory_forward_data        : in  STD_LOGIC_VECTOR (31 downto 0);
		  forward_A                  : in  STD_LOGIC_VECTOR (3 downto 0);					--selection of forwarding
			  --forward_B:in  STD_LOGIC_VECTOR (1 downto 0);					--selection of forwarding
		  read_register1_out         : out STD_LOGIC_VECTOR (31 downto 0);		--register1 data(rs)
		  read_register2_out         : out STD_LOGIC_VECTOR (31 downto 0);		--register2 data (rt)
		  decode_sign_extend_out     : out STD_LOGIC_VECTOR (31 downto 0);	--sign extend out
		  decode_control_signals_out : out STD_LOGIC_VECTOR (10 downto 0);	--control signals			  
		  decode_rs					 : out STD_LOGIC_VECTOR (4 downto 0);			--rs
		  decode_rt                  : out STD_LOGIC_VECTOR (4 downto 0);			--rt	
	      decode_rd                  : out STD_LOGIC_VECTOR (4 downto 0);			--rd		  
		  decode_branch_adder_out    : out STD_LOGIC_VECTOR (31 downto 0);	--add od branch			  
	      jump_result_out            : out STD_LOGIC_VECTOR (31 downto 0);		--jump
		  decode_instruction_out     : out STD_LOGIC_VECTOR (31 downto 0);  
	      branch_out                 : out STD_LOGIC;   
		  zero_flag_out              : out STD_LOGIC;
	      clk                        : in  STD_LOGIC); 
end Decode_stage;

architecture Behavioral of Decode_stage is
--------------------control unit---------------
component SC_CU is
    Port ( Opcode   : in   STD_LOGIC_VECTOR (5 downto 0);
           Branch   : out  STD_LOGIC;
           MemRead  : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           AluSrc   : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           RegDest  : out  STD_LOGIC;
           Jump     : out  STD_LOGIC;
		   halt     : out  STD_LOGIC;
           AluOp    : out  STD_LOGIC_VECTOR (1 downto 0));
			  
end component;
---------------------------------------------
---------------------register file-----------------------
component R_file is
	port(	read_address1 : in std_logic_vector(4 downto 0);
			read_address2 : in std_logic_vector(4 downto 0);
			write_address : in std_logic_vector(4 downto 0);
			write_data : in std_logic_vector(31 downto 0);
			reg_write_en : in std_logic;
			clk : in std_logic;
			data1 : out std_logic_vector(31 downto 0);
			data2 : out std_logic_vector(31 downto 0)
);
end component;
------------------------------------------------------
-------------------------------sign extend--------------------
component signextentest is
port (
 signin: in std_logic_vector(15 downto 0);
 signout: out std_logic_vector(31 downto 0)
					
);
end component;
------------------------------------------------------------
----------------------sign extend shift-----------------------

component signal_shift is
port(
 signin: in std_logic_vector(31 downto 0);
 signout: out std_logic_vector(31 downto 0)
 
);
end component;
-------------------------------------------------------------
-----------------------adder------------------------------
component adder is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
--------------------------------------------------------
---------------------------subtractor------------------
component subtractor is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           zeroFlag : out  STD_LOGIC;
			  clk:in std_logic);
end component;
----------------------------------------------------
-------------------------mux 11 bit----------------
component Mux_11 is
    Port ( input1 : in  STD_LOGIC_VECTOR (10 downto 0);
           input2 : in  STD_LOGIC_VECTOR (10 downto 0);
           output : out  STD_LOGIC_VECTOR (10 downto 0);
           selection : in  STD_LOGIC);
end component;
-------------------------------------------------------
---------------------------shift jump-----------------
component signal_shiftj is
port(
 signin: in std_logic_vector(25 downto 0);
  pc: in std_logic_vector(31 downto 0);
 signout: out std_logic_vector(31 downto 0)
 
);
end component;

--------------------------------------------------
---------------------mux 4*1---------------------
component mux_4_1 is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           input4 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_vector(1 downto 0));
end component;
------------------------------------------


signal Branch   :   STD_LOGIC:='0';
signal MemRead  :   STD_LOGIC:='0';
signal MemtoReg :   STD_LOGIC:='0';
signal MemWrite :   STD_LOGIC:='0';
signal AluSrc   :   STD_LOGIC:='0';
signal RegWrite :   STD_LOGIC:='0';
signal RegDest  :   STD_LOGIC:='0';
signal Jump     :   STD_LOGIC:='0';
signal halt	    :   STD_LOGIC:='0';
signal AluOp    :   STD_LOGIC_VECTOR (1 downto 0):="00";

signal register1_data:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";		--data of rs
signal register2_data:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";		--data of rt

signal sign_extend_out:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	--sign extend 
signal sign_extend_shift_out:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	--shift of sign extend out

signal branch_adder_out:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";		--adder of branch

signal zero_flag:std_logic:='0';											--zero flag

signal control_signals:STD_LOGIC_VECTOR (10 downto 0):="00000000000";		--control signals
signal mux_flush_out:STD_LOGIC_VECTOR (10 downto 0):="00000000000";			--mux flush out

signal sub_result:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	
signal jump_result:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	

signal forward_branch_rs:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	
signal forward_branch_rt:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";	

begin
control_unit:SC_CU port map(instruction(31 downto 26),Branch,MemRead,MemtoReg,MemWrite,AluSrc,RegWrite,RegDest,Jump,halt,AluOp);
register_file:R_file port map(instruction(25 downto 21),instruction(20 downto 16),register_destination,write_register_data,
write_register,clk,register1_data,register2_data);
sign_extend:signextentest port map(instruction(15 downto 0),sign_extend_out);
sign_extend_shift:signal_shift port map(sign_extend_out,sign_extend_shift_out);
adder_comp:adder port map(x"00000000",sign_extend_shift_out,branch_adder_out);
subtractor_com:subtractor port map(forward_branch_rs,forward_branch_rt,sub_result,zero_flag,clk);

control_signals<=Branch&MemRead&MemtoReg&MemWrite&AluSrc&RegWrite&RegDest&Jump&halt&AluOp;
mux_11_comp:Mux_11 port map("00000000000",control_signals,mux_flush_out,mux_flush);			--flush mux
decode_control_signals_out<=mux_flush_out;

jump_shift:signal_shiftj port map(instruction(25 downto 0),pc4,jump_result);

mux_4_1_rs_forwarding:mux_4_1 port map(register1_data,memory_forward_data,alu_forward_data,x"00000000",forward_branch_rs,forward_A(1 downto 0));
mux_4_1_rt_forwarding:mux_4_1 port map(register2_data,memory_forward_data,alu_forward_data,x"00000000",forward_branch_rt,forward_A(3 downto 2));

--sub_result<=forward_branch_rs-forward_branch_rt;
--zero_flag<= '1' when sub_result<=x"00000000" else '0';

decode_branch_adder_out<=branch_adder_out;

decode_instruction_out<=instruction;

decode_rs<=instruction(25 downto 21); 
decode_rt<=instruction(20 downto 16);
decode_rd<=instruction(15 downto 11);

read_register1_out<=register1_data;
read_register2_out<=register2_data;
 
jump_result_out<=jump_result;

branch_out<=Branch;
zero_flag_out<=zero_flag;

decode_sign_extend_out<=sign_extend_out;
end Behavioral;