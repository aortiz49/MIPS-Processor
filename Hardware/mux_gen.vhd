library ieee;
use ieee.std_logic_1164.all;

entity mux_gen is
	generic ( width : integer := 32 );
	port(
		in1		:	in	std_logic_vector(width-1 downto 0);
		in0		:	in 	std_logic_vector(width-1 downto 0);
		sel		:	in	std_logic;
		output		:	out std_logic_vector(width-1 downto 0)
	);
end mux_gen;

architecture bhv of mux_gen is
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

