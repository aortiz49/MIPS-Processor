library ieee;
use ieee.std_logic_1164.all;

entity mux5 is
	port(
		in0		:	in	std_logic_vector(4 downto 0);
		in1		:	in 	std_logic_vector(4 downto 0);
		Sel		:	in	std_logic;
		O		:	out std_logic_vector(4 downto 0)
	);
end mux5;

architecture bhv of mux5 is
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