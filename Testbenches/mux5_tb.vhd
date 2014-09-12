library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux5_tb is
end mux5_tb;

architecture TB of mux5_tb is
	component mux5
		port(
			in0		:	in	std_logic_vector(4 downto 0);
			in1		:	in 	std_logic_vector(4 downto 0);
			sel		:	in	std_logic;
			output		:	out std_logic_vector(4 downto 0));
	end component;

signal in0		:	std_logic_vector(4 downto 0);
signal in1		:	std_logic_vector(4 downto 0);
signal sel		:	std_logic := '1';
signal output		:	std_logic_vector(4 downto 0);




begin -- TB
	UUT: entity work.mux5
		port map(in0 => in0,
			     in1 => in1,
			     sel => sel,
			     output   => output);
	
process 
	variable temp : std_logic_vector(5 downto 0);

begin	
		
	for i in 0 to 63 loop
				in1 <= std_logic_vector(to_unsigned(i,5));
      	for j in 0 to 63 loop
				
	        	in0 <= std_logic_vector(to_unsigned(j,5));	
	        	sel<= not sel;       		
	        	wait for 10 ns;

      end loop;  -- j
    end loop;  -- i
    wait;
	    report "SIMULATION FINISHED!";
	   
	    wait;
	end process;
end TB;
	    