library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity single_cycle_tb is
end single_cycle_tb;

architecture behv of single_cycle_tb is



signal		clk				:			std_logic := '0';
signal		pc_rst			:			std_logic := '0';
signal 		programCounter	:			std_logic_vector(31 downto 0);
signal		instruction_out	:			std_logic_vector(31 downto 0);	
signal		instr_addr		:			std_logic_vector(7 downto 0);



begin
 

single_cycle1: entity work.single_cycle 
	port map (
		clk 				=> 		clk, 
		pc_rst				=>		pc_rst,		
		programCounter		=>		programCounter,
		instruction_out		=>		instruction_out,	
		instr_addr			=>		instr_addr

	);
	
	 clk <= not clk after 10 ns;
process
begin

pc_rst <= '1';
wait for 5 ns;
pc_rst <= '0';

wait;


end process;

end behv;

