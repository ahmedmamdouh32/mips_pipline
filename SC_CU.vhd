library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity SC_CU is
    Port ( Opcode   : in  STD_LOGIC_VECTOR (5 downto 0);
           Branch   : out  STD_LOGIC;
           MemRead  : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           AluSrc   : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           RegDest  : out  STD_LOGIC;
           Jump     : out  STD_LOGIC;
		   halt 	: out  STD_LOGIC;
           AluOp    : out  STD_LOGIC_VECTOR (1 downto 0));
			  
end SC_CU;

architecture Behavioral of SC_CU is

begin

process(Opcode)
begin

if Opcode="000000" then       --R/type
           Jump     <='0' ;
           Branch   <='0' ;
           MemRead  <='0' ;
           MemtoReg <='0' ;
           MemWrite <='0' ;
           AluSrc   <='0' ;
           RegWrite <='1' ;
           RegDest  <='1' ;
           AluOp    <="10";
		   halt	    <='0';

elsif Opcode="100011" then     --Load Word
           Jump     <='0'  ;
           Branch   <='0'  ;
           MemRead  <='1'  ;
           MemtoReg <='1'  ; 
           MemWrite <='0'  ;
           AluSrc   <='1'  ;
           RegWrite <='1'  ;
           RegDest  <='0'  ;
           AluOp    <="00" ;
		   halt	    <='0';
			


elsif Opcode="101011" then     --Store Word
           Jump     <='0'  ;
           Branch   <='0'  ; 
           MemRead  <='0'  ;
        -- MemtoReg <='x'  ;
           MemWrite <='1'  ;
           AluSrc   <='1'  ;
           RegWrite <='0'  ;
        -- RegDest  <='x'  ;
           AluOp    <="00" ;
		   halt	    <='0';
			 

elsif Opcode="000100" then    --branch equal
           Jump     <='0'  ;
           Branch   <='1'  ;
           MemRead  <='0'  ;
        -- MemtoReg <='x'  ;
           MemWrite <='0'  ;
           AluSrc   <='0'  ;
           RegWrite <='0'  ;
        -- RegDest  <='x'  ;
           AluOp    <="01" ;
		   halt	    <='0';
			 
   
elsif Opcode="000010" then    --Jump
           Jump     <='1'  ;
           Branch   <='0'  ;
           MemRead  <='0'  ;
        -- MemtoReg <='x'  ;
           MemWrite <='0'  ;
        -- AluSrc   <='x'  ;
           RegWrite <='0'  ;
        -- RegDest  <='x'  ; 
           AluOp    <="11" ;
		   halt	    <='0'  ;

elsif (Opcode="111111"  )then  --halt
			  Jump     <='0'  ;
           Branch   <='0'  ;
           MemRead  <='0'  ;
           MemtoReg <='0'  ; 
           MemWrite <='0'  ;
           AluSrc   <='0'  ;
           RegWrite <='0'  ;
           RegDest  <='0'  ;
           AluOp    <="00" ;
		   halt	    <='1'  ;
elsif (Opcode="001000"  )then  --addi
			  Jump     <='0'  ;
           Branch   <='0'  ;
           MemRead  <='0'  ;
           MemtoReg <='0'  ; 
           MemWrite <='0'  ;
           AluSrc   <='1'  ;
           RegWrite <='1'  ;
           RegDest  <='0'  ;
           AluOp    <="00" ;
		   halt	    <='0';	
			  
elsif (Opcode="001100"  )then  --andi
			  Jump     <='0'  ;
           Branch   <='0'  ;
           MemRead  <='0'  ;
           MemtoReg <='0'  ; 
           MemWrite <='0'  ;
           AluSrc   <='1'  ;
           RegWrite <='1'  ;
           RegDest  <='0'  ;
           AluOp    <="00" ;
		   halt	    <='0';	
else
	       Jump     <='0'  ;
           Branch   <='0'  ;
           MemRead  <='0'  ;
           MemtoReg <='0'  ; 
           MemWrite <='0'  ;
           AluSrc   <='0'  ;
           RegWrite <='0'  ;
           RegDest  <='0'  ;
           AluOp    <="00" ;
	       halt	    <='0'  ;
end if ;
end process ;
end Behavioral;