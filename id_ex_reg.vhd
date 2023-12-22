library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity id_ex_reg is
 Port (	branch		    : in  STD_LOGIC;
		reg1_in 		: in  STD_LOGIC_vector(31 downto 0);
		reg2_in 		: in  STD_LOGIC_vector(31 downto 0);
		sign_in 		: in  STD_LOGIC_vector(31 downto 0);
		pc_in 			: in  STD_LOGIC_vector(31 downto 0);
		rt_in 			: in  STD_LOGIC_vector(4 downto 0);
		rs_in 			: in  STD_LOGIC_vector(4 downto 0);
		rd_in 			: in  STD_LOGIC_vector(4 downto 0);
		instruction 	: in  STD_LOGIC_vector(5 downto 0);	
		ex_in 			: in  STD_LOGIC_vector(3 downto 0);
		mem_in 			: in  STD_LOGIC_vector(1 downto 0);
		wb_in 			: in  STD_LOGIC_vector(1 downto 0);
		branch_out 		: out STD_LOGIC;
		reg1_out 		: out STD_LOGIC_vector(31 downto 0);
		reg2_out 		: out STD_LOGIC_vector(31 downto 0);
		sign_out 		: out STD_LOGIC_vector(31 downto 0);
		pc_out 			: out STD_LOGIC_vector(31 downto 0);
		rt_out 			: out STD_LOGIC_vector(4 downto 0);
		rs_out 			: out STD_LOGIC_vector(4 downto 0);
		rd_out 			: out STD_LOGIC_vector(4 downto 0);
		instruction_out : out STD_LOGIC_vector(5 downto 0);
		ex_out          : out STD_LOGIC_vector(3 downto 0);
		mem_out 		: out STD_LOGIC_vector(1 downto 0);
		wb_out 			: out STD_LOGIC_vector(1 downto 0);		
		clk				: in STD_LOGIC
		);
	 
end id_ex_reg;

architecture Behavioral of id_ex_reg is
signal branch_alt : STD_LOGIC:='0';
signal inst_alt   : STD_LOGIC_vector(5 downto 0):="000000";
signal pc_alt     : STD_LOGIC_vector(31 downto 0):=x"00000000";
signal reg2_alt   : STD_LOGIC_vector(31 downto 0):=x"00000000";
signal reg1_alt   : STD_LOGIC_vector(31 downto 0):=x"00000000";
signal sign_alt   : STD_LOGIC_vector(31 downto 0):=x"00000000";
signal rt_alt     : STD_LOGIC_vector(4 downto 0):="00000";
signal rs_alt     : STD_LOGIC_vector(4 downto 0):="00000";
signal rd_alt     : STD_LOGIC_vector(4 downto 0):="00000";
signal ex_alt     : STD_LOGIC_vector(3 downto 0):="0000";
signal mem_alt    : STD_LOGIC_vector(1 downto 0):="00";
signal wb_alt     : STD_LOGIC_vector(1 downto 0):="00";

begin

process (clk ) 
begin
if(clk'event and clk = '0')then
		branch_alt <= branch; 
		inst_alt   <= instruction;
		pc_alt     <= pc_in;
		reg2_alt   <= reg2_in;
		reg1_alt   <= reg1_in;
		sign_alt   <= sign_in;
		rt_alt     <= rt_in;
		rs_alt     <= rs_in;
		rd_alt     <= rd_in;
		ex_alt     <= ex_in;
		mem_alt    <= mem_in;
		wb_alt     <= wb_in;
	end if;

end process;
		instruction_out <= inst_alt;
		pc_out          <= pc_alt;
		reg2_out        <= reg2_alt;
		reg1_out  	    <= reg1_alt;
		sign_out 	    <= sign_alt;
		rt_out          <= rt_alt;
		rs_out          <= rs_alt;
		rd_out          <= rd_alt;
		ex_out          <= ex_alt;
		mem_out    	    <= mem_alt;
		wb_out          <= wb_alt;
		branch_out      <= branch_alt;
end Behavioral;

