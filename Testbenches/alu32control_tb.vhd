library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.MIPS_lib.all;

entity alu32control_tb is
end alu32control_tb;

architecture TB of alu32control_tb is
	component alu32control
	   port( 
	      ALUop		: in     std_logic_vector (2 downto 0);
	      funct		: in     std_logic_vector (5 downto 0);
	      control 	: out    std_logic_vector (3 downto 0)
	   );
	end component;

signal ALUop	:      	std_logic_vector (2 downto 0);
signal funct	:    	std_logic_vector (5 downto 0);
signal control	:		std_logic_vector(3 downto 0);

begin -- TB
	UUT: entity work.alu32control
		port map(
			ALUop => ALUop,
			funct => funct,
			control => control	
			);
		
	
process
begin	
	
ALUop <= LW_SW;
wait for 20 ns;

ALUop <= BEQ;
wait for 20 ns;

ALUop <= R_TYPE;
funct <= CTRL_ADD;
wait for 20 ns;

funct <= CTRL_SUB;
wait for 20 ns;

funct <= CTRL_AND;
wait for 20 ns;

funct <= CTRL_OR;
wait for 20 ns;

funct <= CTRL_NOR;
wait for 20 ns;

funct <= CTRL_SLT;
wait for 20 ns;

funct <= CTRL_SLTU;
wait for 380 ns;


    
    
    
    
	 wait;
	 
	end process;
end TB;
	    

