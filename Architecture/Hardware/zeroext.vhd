library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity zeroext is
	port(
		in0			:	in	std_logic_vector(15 downto 0);
		out0		:	out	std_logic_vector(31 downto 0));		
end zeroext;

architecture bhv of zeroext is
begin
	out0 <= (31 downto 16 => '0') & in0;
end bhv;