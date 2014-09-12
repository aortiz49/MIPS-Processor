library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zeroext_tb is
end zeroext_tb;

architecture TB of zeroext_tb is
	component zeroext
		port(
		in0			:	in	std_logic_vector(15 downto 0);
		out0		:	out	std_logic_vector(31 downto 0));		
	end component;

signal in0		:	std_logic_vector(15 downto 0);
signal out0		:	std_logic_vector(31 downto 0);

begin -- TB
	UUT: entity work.zeroext
		port map(
			in0 => in0,
			out0 => out0);


process
begin	
	
	in0 <= x"7FFF";  
	
	wait for 10 ns;
   	
    in0 <= x"FFFF";
  
  	wait for 10 ns;

    report "SIMULATION FINISHED!";
    wait;
	
	end process;
end TB;
	    

