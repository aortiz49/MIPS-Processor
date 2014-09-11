library ieee;
use ieee.std_logic_1164.all;

entity mux1 is
	port(
		in0		:	in	std_logic;
		in1		:	in 	std_logic;
		Sel		:	in	std_logic;
		O		:	out std_logic
	);
end mux1;

architecture bhv of mux1 is
begin
	process(in0,in1,Sel)
	begin
		case sel is
			when '0' => 
				O <= in0;
			when others =>
				O <= in1;
		end case;
	end process;
end bhv;