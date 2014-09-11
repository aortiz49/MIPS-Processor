library ieee;
use ieee.std_logic_1164.all;

entity mux32 is
	port(
		in0		:	in	std_logic_vector(31 downto 0);
		in1		:	in 	std_logic_vector(31 downto 0);
		Sel		:	in	std_logic;
		O		:	out std_logic_vector(31 downto 0)
	);
end mux32;

architecture bhv of mux32 is
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
