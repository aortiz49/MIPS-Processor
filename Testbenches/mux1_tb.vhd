library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux1_tb is
end mux1_tb;

architecture TB of mux1_tb is
	component mux1
		port(
			in0		:	in	std_logic;
			in1		:	in 	std_logic;
			Sel		:	in	std_logic;
			O		:	out std_logic);
	end component;

signal in0		:	std_logic;
signal in1		:	std_logic;
signal Sel		:	std_logic;
signal O		:	std_logic;


begin -- TB
	UUT: entity work.mux1
		port map(in0 => in0,
			     in1 => in1,
			     Sel => Sel,
			     O   => O);
	
process 
	variable temp : std_logic_vector(2 downto 0);
		
begin	
		
	for i in 0 to 7 loop
		temp := std_logic_vector(to_unsigned(i, 3));
      in1 <= temp(2);
      in0 <= temp(1);
      Sel <= temp(0);
      wait for 10 ns;
	
	end loop;  -- i
	    
	    report "SIMULATION FINISHED!";
	    wait;
	end process;
end TB;
	    