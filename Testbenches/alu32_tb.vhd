library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.MIPS_lib.all;

entity alu32_tb is
end alu32_tb;

architecture TB of alu32_tb is
	component alu32

	port(
		ia		:	in	std_logic_vector(31 downto 0);
		ib		:	in	std_logic_vector(31 downto 0);
		C		:	out	std_logic;
		control	:	in	std_logic_vector(3 downto 0);
		output	:	out	std_logic_vector(31 downto 0);
		Z 		:	out	std_logic;
		S		:	out std_logic;
		V		:	out	std_logic		
	);
	end component;

signal ia		:	std_logic_vector(31 downto 0);
signal ib		:	std_logic_vector(31 downto 0);
signal cout		:	std_logic;
signal control	:	std_logic_vector(3 downto 0);
signal output	:	std_logic_vector(31 downto 0);
signal Z		:	std_logic;
signal S		:	std_logic;
signal V		:	std_logic;

begin -- TB
	UUT: entity work.alu32
		port map(
			ia => ia,
			ib => ib,
			C => cout,
			control => control,
			output => output,
			Z	=>	Z,
			S	=>	S,
			V	=>	V		
			);
		
	
process
begin	
	
-- test two positive numbers
    ia <= conv_std_logic_vector(1000, ia'length);
    ib <= conv_std_logic_vector(350, ib'length);
    control <= F_SUM;
    wait for 20 ns;
  
	 
    ia <= conv_std_logic_vector(100, ia'length);
    ib <= conv_std_logic_vector(5, ib'length);
    control <= F_SUB;
    wait for 20 ns;
    
    ia <= conv_std_logic_vector(5, ia'length);
    ib <= conv_std_logic_vector(10, ib'length);
    control <= F_AND;
    wait for 20 ns;  
    
    ia <= conv_std_logic_vector(5, ia'length);
    ib <= conv_std_logic_vector(10, ib'length);
    control <= F_OR;
    wait for 20 ns; 
    
    ia <= conv_std_logic_vector(7, ia'length);
    ib <= conv_std_logic_vector(8, ib'length);
    control <= F_NOR;
    wait for 20 ns;
    
    ia <= conv_std_logic_vector(-200, ia'length);
    ib <= conv_std_logic_vector(100, ib'length);
    control <= F_SLT;
    wait for 20 ns;
    
    ia <= conv_std_logic_vector(1, ia'length);
    ib <= conv_std_logic_vector(-500, ib'length);
    control <= F_SLT;
    wait for 20 ns;
    
    ia <= conv_std_logic_vector(101, ia'length);
    ib <= conv_std_logic_vector(800, ib'length);
    control <= F_SLTU;
    wait for 20 ns;
    
    ia <= x"AAAAAAAB";
    ib <= x"AAAAAAAA";
    control <= F_SLTU;
    wait for 300 ns;
    
    
    
    
    
	 wait;
	 
	end process;
end TB;
	    


