library ieee;
use ieee.std_logic_1164.all;

entity mux1 is
	port(
		in0		:	in	std_logic;
		in1		:	in 	std_logic;
		sel		:	in	std_logic;
		output	:	out std_logic
	);
end mux1;

architecture bhv of mux1 is
begin
	process(in0,in1,sel)
	begin
		case sel is
			when '1' => 
				output <= in1;
			when others =>
				output <= in0;
		end case;
	end process;
end bhv;

