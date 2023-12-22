library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
    
entity pipeline_19_12_2019 is
Port ( clk : in  STD_LOGIC);
end pipeline_19_12_2019;

architecture Behavioral of pipeline_19_12_2019 is
--------------------pc------------------------------
component pc is
    Port ( load : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0);
			  flush : in std_logic);
end component;
---------------------end of pc-----------------------
----------------------alu control------------------
component ALU_CONTROL is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (1 downto 0);
           INST : in  STD_LOGIC_VECTOR (5 downto 0);
           control : out  STD_LOGIC_VECTOR (3 downto 0));
end component;
---------------------------end------------------
-----------------alu-----------------------
component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUCONTROL : in  STD_LOGIC_VECTOR (3 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC);
end component;
------------------------end-----------------------
--------------------data memory---------------------
 component DM is
    Port ( WriteSig    : in   STD_LOGIC:='0';
           ReadSig     : in   STD_LOGIC:='1';
           Clock       : in   STD_LOGIC;
			  Address     : in   STD_LOGIC_VECTOR (31 downto 0);
           DataInput   : in   STD_LOGIC_VECTOR (31 downto 0);       
			  DataOutput  : out  STD_LOGIC_VECTOR (31 downto 0));			
end component;
---------------------------end--------------
-----------------instruction memory--------------
component IM is
    Port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component ;
--------------------------end--------------------
-----------------------mux32----------------
component Mux_32 is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  selector: in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
-------------------------end---------------------
--------------------------mux 5 bit------------------
component Mux_5 is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           b : in  STD_LOGIC_VECTOR (4 downto 0);
           s : in  STD_LOGIC;
           out_mux : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

------------------------------end-----------------
--------------------------control unit--------------
component SC_CU is
    Port ( Opcode   : in  STD_LOGIC_VECTOR (5 downto 0);
           Branch   : out  STD_LOGIC;
           MemRead  : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           AluSrc   : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           RegDest  : out  STD_LOGIC;
           Jump     : out  STD_LOGIC;
			  halt 	  : out  STD_LOGIC;
           AluOp    : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
-------------------------end----------------------
---------------------adder-------------------------
component adder is
    Port ( input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
---------------------------end-------------------
-------------------------jump shift left---------------
component signal_shiftj is
port(
 signin: in std_logic_vector(25 downto 0);
  pc: in std_logic_vector(31 downto 0);
 signout: out std_logic_vector(31 downto 0)
 
);
end component;
-------------------------end----------------------
---------------------branch shift left--------------
component signal_shift is
port(
 signin: in std_logic_vector(31 downto 0);
 signout: out std_logic_vector(31 downto 0)
 
);
end component;
----------------------------end---------------
-----------------sign extend-----------------
component signextentest is
port (
 signin: in std_logic_vector(15 downto 0);
 signout: out std_logic_vector(31 downto 0)
					
);
end component;
--------------------------------end--------------
-------------------------register file----------------
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
--------------------------------end--------------
-------------------------if/id state reg----------------
component if_id_reg is
Port (	   instruction_in : in  STD_LOGIC_vector(31 downto 0);
				pc_in : in  STD_LOGIC_vector(31 downto 0);
				branch :in std_logic_vector(31 downto 0);
				instruction_out : out  STD_LOGIC_vector(31 downto 0);
				pc_out : out  STD_LOGIC_vector(31 downto 0);
				clk: in std_logic;
				stall : in std_logic ;
				flush :in std_logic
				);
end component;
--------------------------------end--------------
-------------------------id/ex state reg----------------
component id_ex_reg is
 Port (		
				branch : in std_logic;
				reg1_in : in  STD_LOGIC_vector(31 downto 0);
				reg2_in : in  STD_LOGIC_vector(31 downto 0);
				sign_in : in  STD_LOGIC_vector(31 downto 0);
				pc_in : 	 in  STD_LOGIC_vector(31 downto 0);
				rt_in :  in  STD_LOGIC_vector(4 downto 0);
				rs_in :  in  STD_LOGIC_vector(4 downto 0);
				rd_in :  in  STD_LOGIC_vector(4 downto 0);
				instruction : in std_logic_vector (5 downto 0);
				
				ex_in : 	 in  std_logic_vector(3 downto 0);
				mem_in :  in  std_logic_vector(1 downto 0);
				wb_in : 	 in  std_logic_vector(1 downto 0);
				
				branch_out : out std_logic;
				reg1_out : 	out  STD_LOGIC_vector(31 downto 0);
				reg2_out : 	out  STD_LOGIC_vector(31 downto 0);
				sign_out : 	out  STD_LOGIC_vector(31 downto 0);
				pc_out : 	out  STD_LOGIC_vector(31 downto 0);
				rt_out :  out  STD_LOGIC_vector(4 downto 0);
				rs_out :  out  STD_LOGIC_vector(4 downto 0);
				rd_out :  out  STD_LOGIC_vector(4 downto 0);
				instruction_out : out std_logic_vector (5 downto 0);
				
				ex_out : 	out  std_logic_vector(3 downto 0);
				mem_out :	out  std_logic_vector(1 downto 0);
				wb_out : 	out  std_logic_vector(1 downto 0);
				
				clk: in std_logic
				);
	 
end component;
--------------------------------end--------------
-------------------------ex_mem_reg ----------------
component ex_mem_reg is
    Port ( input  : in  STD_LOGIC_vector(72 downto 0);
			  output : out STD_LOGIC_vector(72 downto 0);
			  clk : in std_logic
	 );
end component;
--------------------------------end--------------
-------------------------mem_wb_reg ----------------
component mem_wb_reg is
    Port ( input : in  STD_LOGIC_vector(70 downto 0);
				output: out STD_LOGIC_vector(70 downto 0);
				clk : in STD_LOGIC
	 );
end component;
--------------------------------end--------------
-------------------------hazzard unit----------------
component HAZZARD_UNIT is
    Port ( 	mem_read	 : in  STD_LOGIC;
				id_ex_rt : in std_logic_vector(4 downto 0);
				if_id_rs : in std_logic_vector(4 downto 0);
				if_id_rt : in std_logic_vector(4 downto 0);
				pc_flush : out std_logic;
				if_id_flush : out std_logic;
				mux_flush : out std_logic
	 );
end component;

--------------------------------end--------------
-------------------------ForwardingUnit----------------
component ForwardingUnit is
port( XM_RegWrite:in std_logic;
      MW_RegWrite:in std_logic;
      DX_Rs:in std_logic_vector(4 downto 0);
      DX_Rt:in std_logic_vector(4 downto 0);
		XM_Rd:in std_logic_vector(4 downto 0);
		MW_Rd:in std_logic_vector(4 downto 0);
		ForwardA:out std_logic_vector(1 downto 0);
		ForwardB:out std_logic_vector(1 downto 0));
end component;

--------------------------------end--------------
-------------------------control_mux----------------
component control_mux is
    Port ( control: in  STD_LOGIC_vector(9 downto 0);
				sel : in std_logic;
				control_out : out std_logic_vector(9 downto 0)
	 );
end component;
--------------------------------end--------------
-------------------------forward_mux----------------
component forward_mux is
    Port ( input1 : in  STD_LOGIC_vector(31 downto 0);
				input2 : in  STD_LOGIC_vector(31 downto 0);
				input3 : in  STD_LOGIC_vector(31 downto 0);
				output : out  STD_LOGIC_vector(31 downto 0);
				sel: in std_logic_vector(1 downto 0)
	 
	 );
	
end component;



COMPONENT TwoBitPredictor is
	PORT(
		BranchAndGate : IN std_logic;
		Branch : IN std_logic;
		clk : IN std_logic;     
		flush		  : out std_logic;	
		Prediction : OUT std_logic
		);
	END COMPONENT;





-------------fetch signals----------------------------------------------------------------
signal pc_load , pc_F , pc_out , pc4 , instruction , jump_pos  : std_logic_vector(31 downto 0):=x"00000000";
signal pc_stall , F_D_REG_stall , jump_or_branch , en_pc: std_logic:='0';

-------------decode signals--------------------------------------------------------------	
--instruction devide
signal instruction_D , pc_D 	:	std_logic_vector(31 downto 0):=x"00000000";
signal F_D_flush 					: 	std_logic:='1';
signal opcode_D 					:	std_logic_vector(5 downto 0):="000000";
signal rs_D ,rt_D , rd_D 		:  std_logic_vector(4 downto 0):="00000";
signal imm_D 						:  std_logic_vector(15 downto 0):="0000000000000000";
signal fun_D 						:	std_logic_vector(5 downto 0):="000000";
signal j_D 							:  std_logic_vector(25 downto 0):="00000000000000000000000000";
--control signals
signal Branch_D , MemRead_D , MemtoReg_D , MemWrite_D , AluSrc_D , RegWrite_D , RegDest_D , Jump_D , halt_D 	   :   STD_LOGIC:='0';
signal AluOp_D    :   STD_LOGIC_VECTOR (1 downto 0):="00";
--control signal 1 vector 
signal control_d : std_logic_vector(9 downto 0):= "0000000000";
signal control_dMux : std_logic_vector(9 downto 0):= "0000000000";

signal zero : std_logic:='0';
--sign extend
signal sign_extended : std_logic_vector(31 downto 0);
signal sign_extended_shif : std_logic_vector(31 downto 0):=x"00000000";
--register file 
signal data1_D , data2_D : std_logic_vector(31 downto 0):= x"00000000";
-------------excute signals--------------------------------------------------------------	
signal control_EX : std_logic_vector (9 downto 0):= "0000000000";
signal data1_ex ,data2_ex ,sign_extended_ex , pc_ex: std_logic_vector(31 downto 0):=x"00000000";
signal rs_ex , rt_ex ,rd_ex , Dest_reg_ex: std_logic_vector (4 downto 0):= "00000";

---contro signals
signal Branch_ex, AluSrc_ex , RegDest_ex , MemRead_ex , MemWrite_ex , MemtoReg_ex , RegWrite_ex , Jump_ex , haz_cntrl_flush: std_logic := '0';

  
--forward 
signal forward_A , forward_B : std_logic_vector(1 downto 0):="00"; 
signal mux1_output , mux2_output : std_logic_vector(31 downto 0):=x"00000000";
 
--alu
signal AluOp_ex : std_logic_vector(1 downto 0):= "00";
signal fun_ex : std_logic_vector(5 downto 0):="000000";
signal alu_cntrl : std_logic_vector(3 downto 0):="0000";
signal alu_output ,alu_input_2: std_logic_vector(31 downto 0):=x"00000000";
signal zero_ex : std_logic:='0';
signal ex_mem_in : std_logic_vector(72 downto 0):=(others => '0');

-------------mem signals--------------------------------------------------------------	
signal ex_mem_out : std_logic_vector(72 downto 0):=(others => '0');

signal data_mem , data_mem_add  , data_mem_output : std_logic_vector(31 downto 0):= x"00000000";
signal dest_reg_mem : std_logic_vector(4 downto 0):= "00000"; 
--control mem
signal control_mem : std_logic_vector(3 downto 0);
signal MemRead_mem ,MemWrite_mem ,MemtoReg_mem ,RegWrite_mem: std_logic:='0'; 
signal mem_wb_in : std_logic_vector (70 downto 0):=(others =>'0');

-------------write back signals--------------------------------------------------------------	
signal mem_wb_out : std_logic_vector (70 downto 0):=(others =>'0');
signal data_WB : std_logic_vector(31 downto 0):= x"00000000";
signal RegWrite_WB ,MemtoReg_WB: std_logic:='0';
signal mem_data_mem , alu_data_mem : std_logic_vector(31 downto 0):=x"00000000";
signal rd_WB : std_logic_vector(4 downto 0):="00000";




begin 


------ fetch cycle------------------------------------
pc_component : pc port map(pc_load , clk , pc_F , en_pc );
en_pc <= (pc_stall and not halt_d);
pc_4 : adder port map(pc_F,x"00000004",pc4);
pc_mux : mux_32 port map (pc4 , jump_pos , jump_or_branch , pc_load );
jump_or_branch <= jump_D or (branch_D and zero);
instructions : IM port map ( pc_F , instruction );
F_D_REG : if_id_reg port map ( instruction , pc4 , x"00000000" , instruction_D , pc_D , clk , F_D_REG_stall , F_D_flush );

----- decode cycle----------------------------------------
opcode_D <= instruction_D(31 downto 26);
rs_D		<=	instruction_D(25 downto 21);
rt_D		<= instruction_D(20 downto 16);
rd_D		<= instruction_D(15 downto 11);	
fun_D	<= instruction_D(5 downto 0);	
imm_D		<= instruction_D(15 downto 0);	
j_D		<= instruction_D(25 downto 0);

control_unit : SC_CU port map ( opcode_D , Branch_D , MemRead_D , MemtoReg_D , MemWrite_D , AluSrc_D , RegWrite_D , RegDest_D , Jump_D , halt_D, AluOp_D);

register_file : R_file port map ( rs_D , rt_D , rd_WB , data_WB , RegWrite_WB , clk , data1_D , data2_D );
-- comparator------------------------------
combarator : process(Branch_D , data1_D , data2_D )
begin
	if(Branch_D = '1') then
		if(data1_D = data2_D)then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end if;
end process; 



sign_extended <=	("0000000000000000" & imm_D) 	when AluOp_D = "00" else
						("0000000000000000" & imm_D)	when Branch_D = '1' else
						("000000"& j_D) 					when jump_d = '1' else
						x"00000000";

 ----------------------excute cycle--------------------------------
 ------------------------------------------------------------------
shift : signal_shift port map ( sign_extended , sign_extended_shif );
branch_jump_adder : adder port map(sign_extended_shif , x"00000000" , jump_pos); --jump pos return to pc mux --should add to "pc_D" but for the assyembler

control_d <= Branch_D & AluOp_D & AluSrc_D & RegDest_D & MemRead_D & MemWrite_D & MemtoReg_D & RegWrite_D & Jump_D;
--					9		   8-7				6				5				4				 3				 2					1			 0
control_muxx :control_mux port map ( control_d , haz_cntrl_flush ,control_dmux ) ;

hazzard_unitt : HAZZARD_UNIT PORT MAP ( MemRead_EX , rt_ex , rs_D , rt_D , pc_stall , F_D_REG_stall , haz_cntrl_flush ) ;

D_X_REG : id_ex_reg port map (control_dmux(9) , data1_D , data2_D , sign_extended ,   pc_D ,  rs_D , rt_D  , rd_D  , fun_D , control_dmux(8 downto 5) , control_dmux(4 downto 3) , control_dmux(2 downto 1),
										 control_EX(9) , data1_ex , data2_ex , sign_extended_ex ,pc_ex, rs_ex , rt_ex ,rd_ex , fun_ex,  control_EX(8 downto 5) , 	control_EX(4 downto 3 ) , control_EX(2 downto 1) , clk);
--control signals  ex
Branch_ex 	<= control_EX(9);
AluOp_ex 	<= control_EX(8 downto 7);
AluSrc_ex	<= control_EX(6);
RegDest_ex 	<= control_EX(5);
MemRead_ex 	<= control_EX(4);
MemWrite_ex <= control_EX(3);
MemtoReg_ex <= control_EX(2);
RegWrite_ex <= control_EX(1);
Jump_ex 		<= control_EX(0);


--imm vs r_type mux
rd_rt_mux : mux_5 port map( rt_ex ,rd_ex , RegDest_ex , Dest_reg_ex );
forward: forwardingunit port map(RegWrite_mem , RegWrite_wb , rs_ex , rt_ex , Dest_reg_mem , rd_wb , forward_A , forward_B);
forward_mux_1 : forward_mux port map (data1_ex , data_WB , data_mem_add , mux1_output , forward_A);
forward_mux_2 : forward_mux port map (data2_ex , data_WB , data_mem_add , mux2_output , forward_B);
imm_mux : mux_32 port map ( mux2_output , sign_extended_ex , AluSrc_ex, alu_input_2 );
aluControl : alu_control port map (AluOp_ex , fun_ex , alu_cntrl); 
aluComponent : ALU port map( mux1_output , alu_input_2 , alu_cntrl , alu_output );
ex_mem_in <=control_EX(4 downto 1) & alu_output & mux2_output & Dest_reg_ex;
					
X_MEM_REG : ex_mem_reg port map(ex_mem_in , ex_mem_out , clk);
--------------mem cycle ------------------------------------------------------
---------------------------------------------------------------------------
 control_mem 	<= ex_mem_out(72 downto 69);
 data_mem_add	<= ex_mem_out(68 downto 37);
 data_mem		<= ex_mem_out(36 downto 5);
 dest_reg_mem	<= ex_mem_out(4 downto 0);

--control signals 
MemRead_mem 	<= control_mem(3);
MemWrite_mem <= control_mem(2);
MemtoReg_mem <= control_mem(1);
RegWrite_mem <= control_mem(0);

data_memm : DM port map (MemWrite_mem , MemRead_mem , clk , data_mem_add , data_mem , data_mem_output);
mem_wb_in <= MemtoReg_mem & RegWrite_mem & data_mem_output & data_mem_add & dest_reg_mem ;
MEM_WB_REGg :mem_wb_reg port map (mem_wb_in , mem_wb_out , clk ) ;

------------------ WB cycle-------------------------------------
----------------------------------------------------------------
MemtoReg_WB <= mem_wb_out(70);
RegWrite_WB <= mem_wb_out(69);
mem_data_mem <= mem_wb_out(68 downto 37);
alu_data_mem <= mem_wb_out(36 downto 5);
rd_WB <= mem_wb_out(4 downto 0);
write_back_mux : mux_32 port map(alu_data_mem , mem_data_mem , MemtoReg_WB , data_WB);



end Behavioral;


