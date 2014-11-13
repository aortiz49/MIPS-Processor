library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity shifter is
	port( 
		ib				: in std_logic_vector(31 downto 0);
		shdir			: in std_logic;
		shamt			: in std_logic_vector(4 downto 0);
		q				: out std_logic_vector(31 downto 0)
		);

end shifter;

architecture behv of shifter is
--function to do the shifting
function barrel_shift(

in_data: in std_logic_vector(31 downto 0);
dir: in std_logic;
count: in std_logic_vector(4 downto 0)) return std_logic_vector is

begin
	if (dir = '1') then
		return std_logic_vector((shr(unsigned(in_data), unsigned(count))));
	else
		return std_logic_vector((SHL(unsigned(in_data), unsigned(count))));
	end if;

end barrel_shift;

begin
process(ib,shdir,shamt)
begin

q <= barrel_shift(ib, shdir, shamt);
end process;

end behv;