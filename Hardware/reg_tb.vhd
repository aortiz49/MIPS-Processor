library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_tb is
end reg_tb;

architecture behv of reg_tb is

signal   d       :    std_logic_vector(31 downto 0);
signal    rst     :     std_logic;
signal    en      :     std_logic;
 signal   clk     :     std_logic := '0';  -- clock.
 signal   q       :    std_logic_vector(31 DOWNTO 0);

begin
 

single_cycle1: entity work.reg32
	port map (
		d 				=> 		d, 
		rst				=>		rst,		
		en		=>		en,
		clk		=>		clk,
		q			=>		q

	);
	
	 clk <= not clk after 10 ns;
process
begin

rst <='0';
en <='0';
d <=x"AAFA5555";
rst <= '1';
wait for 5 ns;
rst <= '0';

en <= '1';
wait for 5 ns;
en <='0';


wait;


end process;

end behv;

