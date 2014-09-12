library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux32_tb is
end mux32_tb;

architecture TB of mux32_tb is
	component mux32
		port(
			in0		:	in	std_logic_vector(31 downto 0);
			in1		:	in 	std_logic_vector(31 downto 0);
			sel		:	in	std_logic;
			output		:	out std_logic_vector(31 downto 0));
	end component;

signal in0		:	std_logic_vector(31 downto 0);
signal in1		:	std_logic_vector(31 downto 0);
signal sel		:	std_logic := '1';
signal output		:	std_logic_vector(31 downto 0);


begin -- TB
	UUT: entity work.mux32
		port map(in0 => in0,
			     in1 => in1,
			     sel => sel,
			     output   => output);
	
process 
begin	
		
	for i in 2048 to 4096  loop --random values. since 2^32-1 values is way too much
				in1 <= std_logic_vector(to_unsigned(i,32));
      	for j in 0 to 255 loop				
	        	in0 <= std_logic_vector(to_unsigned(j,32));	
	        	sel<= not sel;       		
	        	wait for 10 ns;

      end loop;  -- j
    end loop;  -- i
    wait;
	    report "SIMULATION FINISHED!";
	   
	    wait;
	end process;
end TB;
	    