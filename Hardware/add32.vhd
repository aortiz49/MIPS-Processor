library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add32 is
	port(
		in1		:	in	std_logic_vector(31 downto 0);
		in0		:	in	std_logic_vector(31 downto 0);
		sum		:	out	std_logic_vector(31 downto 0)
	);
end add32;

architecture arch of add32 is


signal temp_c	: std_logic_vector(32 downto 0);
	

begin
	add: for i in 0 to 31 generate	--generate 32 1-bit adders for add32 entity
		add32: entity work.add1 
			port map(
				in1 => in1(i),
				in0 => in0(i),
				cin => temp_c(i),	-- Cin will be previous value temp signal 
				cout => temp_c(i+1),	-- cout will feed into cin
				sum => sum(i)				
			);
			
	end generate;
temp_c(0) <= '0';	-- Set cin to first adder to 0. Leaving it blank will result in an 'X' for sum(0)



end arch;

		
	
	