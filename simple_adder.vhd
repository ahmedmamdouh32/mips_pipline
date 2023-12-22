library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Simple_Adder is
    Port ( Operand1  : in   STD_LOGIC_vector(63 downto 0);
           Operand2  : in   STD_LOGIC_vector(63 downto 0);
			   Control  : in   std_logic;
            Output   : Out  STD_LOGIC_vector(63 downto 0));
end Simple_Adder;

architecture Behavioral of Simple_Adder is
Signal Operand1Sig :  STD_LOGIC_vector(63 downto 0);
Signal Operand2Sig :  STD_LOGIC_vector(63 downto 0);
Signal ControlSig  :  std_logic;
Signal OutputSig   :  STD_LOGIC_vector(63 downto 0);
begin

Operand1Sig<=Operand1;
Operand1Sig<=Operand2;
Output<=OutputSig;
process(ControlSig,Operand1Sig,Operand2Sig)
begin
if(ControlSig='1')then
OutputSig<=Operand1Sig+Operand2Sig;
end if;
end process;
end Behavioral;

