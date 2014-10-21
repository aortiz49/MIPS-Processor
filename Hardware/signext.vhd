library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity signext is
	port(
		in0			:	in	std_logic_vector(15 downto 0);
		out0		:	out	std_logic_vector(31 downto 0));		
end signext;

architecture bhv of signext is
begin
	out0 <= (31 downto 16 => in0(15)) & in0;
end bhv;