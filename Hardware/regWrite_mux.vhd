library ieee;
use ieee.std_logic_1164.all;

entity regWrite_mux is
	port(
		in0		:	in	std_logic_vector(4 downto 0);
		in1		:	in std_logic_vector(4 downto 0);
		sel		:	in	std_logic;
		output	:	out std_logic_vector(4 downto 0)
	);
end regWrite_mux;

architecture bhv of regWrite_mux is
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

