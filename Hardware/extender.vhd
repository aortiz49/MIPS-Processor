library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity extender is
	port(
		in0		:	in	std_logic_vector(15 downto 0);
		ExtOp	:	in	std_logic;
		out0	:	out	std_logic_vector(31 downto 0)
		);		
end extender;

architecture bhv of extender is
begin
	process(in0,ExtOp)
	begin
		case ExtOp is
			when '0' => 
				out0 <= (31 downto 16 => '0') & in0;
			when others =>
				out0 <= (31 downto 16 => in0(15)) & in0;
		end case;
	end process;
end bhv;