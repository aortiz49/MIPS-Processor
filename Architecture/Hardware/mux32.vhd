library ieee;
use ieee.std_logic_1164.all;

entity mux32 is
	port(
		in0		:	in	std_logic_vector(31 downto 0);
		in1		:	in 	std_logic_vector(31 downto 0);
		sel		:	in	std_logic;
		output		:	out std_logic_vector(31 downto 0)
	);
end mux32;

architecture bhv of mux32 is
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
