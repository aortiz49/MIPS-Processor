library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add8 is
	port(
		in1		:	in	std_logic_vector(7 downto 0);
		in0		:	in	std_logic_vector(7 downto 0);
		sum		:	out	std_logic_vector(7 downto 0)
	);
end add8;

architecture arch of add8 is
	component add1
	port(	
		in1		:	in	std_logic;
		in0		:	in	std_logic;
		cin		:	in	std_logic;
		cout	:	out std_logic;
		sum		:	out	std_logic
	);
	end component;

signal temp_c	: std_logic_vector(31 downto 0);
	

begin
	add: for i in 0 to 7 generate	--generate 8 1-bit adders for add8 entity
		add32: add1 
			port map(
				in1 => in1(i),
				in0 => in0(i),
				cin => temp_c(i),	-- Cin will be previous value temp signal 
				cout => temp_c(i+1),	-- cout will feed into cin
				sum => sum(i)				
			);
			
	end generate;



end arch;

		
	
	