library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extender_tb is
end extender_tb;

architecture TB of extender_tb is
	component extender
		port(
		in0		:	in	std_logic_vector(15 downto 0);
		Sel		:	in std_logic;
		out0	:	out	std_logic_vector(31 downto 0));		
	end component;

signal in0		:	std_logic_vector(15 downto 0);
signal Sel		:	std_logic;
signal out0		:	std_logic_vector(31 downto 0);


begin -- TB
	UUT: entity work.extender
		port map(
			in0 => in0,
			Sel => Sel,
			out0 => out0);

process
begin	
	
	in0 <= x"7FFF";  
	Sel <= '0';	
	wait for 20 ns;
	
	in0 <= x"7FFF";  
	Sel <= '1';	
	wait for 20 ns;
	
   	
    in0 <= x"FFFF";
  	Sel <= '0';
  	wait for 20 ns;
  	
    in0 <= x"FFFF";
  	Sel <= '1';
  	wait for 20 ns;

    report "SIMULATION FINISHED!";
    wait;
	
	end process;
end TB;
	    

