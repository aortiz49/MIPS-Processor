library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext_tb is
end signext_tb;

architecture TB of signext_tb is
	component signext
		port(
		in0			:	in	std_logic_vector(15 downto 0);
		out0		:	out	std_logic_vector(31 downto 0));		
	end component;

signal in0		:	std_logic_vector(15 downto 0);
signal out0		:	std_logic_vector(31 downto 0);

begin -- TB
	UUT: entity work.signext
		port map(
			in0 => in0,
			out0 => out0);


process
begin	
	
	in0 <= x"7FFF";  
	
	wait for 20 ns;
   	
    in0 <= x"FFFF";
  
  	wait for 20 ns;

    report "SIMULATION FINISHED!";
    wait;
	
	end process;
end TB;
	    

