library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity main_control_tb is
end main_control_tb;

architecture behv of main_control_tb is

component main_control 
	port(
		global_rst,clk			: 	in		std_logic;													
		op_code		  			: 	in		std_logic_vector(5 downto 0);		
		pc_rst					:	out		std_logic;						-- Reset program counter
		pc_en					:	out 	std_logic;						-- enable a pc inc
		RegDst					:	out		std_logic;
		RegWr					:	out		std_logic;
		ALUsrc					:	out		std_logic;
		shdir					:	out		std_logic;
		shamt					:	out		std_logic_vector(4 downto 0);
		ALUctrl					:	out		std_logic_vector(3 downto 0)	-- Set actual opcode(temp cheap solution for now)
	);   
end component;


signal		clk				:			std_logic := '0';
signal		op_code			:			std_logic_vector(5 downto 0);
signal 		global_rst		:			std_logic;
signal		pc_rst			:			std_logic;
signal		pc_en			: 	 		std_logic;
signal		RegDst			:			std_logic;
signal 		RegWr			:			std_logic;
signal 		ALUsrc			:		 	std_logic;
signal		shdir			:			std_logic;
signal		shamt			:			std_logic_vector(4 downto 0);
signal 		ALUctrl			:			std_logic_vector(3 downto 0);


begin
 

controllerr: main_control 
	port map (
		global_rst => global_rst,
		clk => clk, 
		op_code => op_code,
		pc_rst=>pc_rst,
		pc_en => pc_en,
		RegDst => RegDst,
		RegWr => RegWr,
		ALUsrc => ALUsrc,
		shdir => shdir,
		shamt => shamt,
		ALUctrl => ALUctrl

	);
	
	 clk <= not clk after 10 ns;
process
begin

global_rst <='1';
wait for 10 ns;

global_rst <='0';

wait;


end process;

end behv;

