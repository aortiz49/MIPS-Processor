library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity single_cycle_tb is
end single_cycle_tb;

architecture behv of single_cycle_tb is

component single_cycle 
	port ( 
		clk				:   in   	std_logic;
		wr_en			:	in		std_logic;
		ALUsrc			:	in		std_logic;
		
		temp_control 	:	in		std_logic_vector(3 downto 0);
		temp_output		:	out		std_logic_vector(31 downto 0);
		temp_sel		:	in		std_logic;
		temp_rst		:	in		std_logic;
		
		temp_pc			: 	out 	std_logic_vector(7 downto 0);
		temp_memory_out	:	out		std_logic_vector(31 downto 0);
		temp_imm		:	out		std_logic_vector(15 downto 0);
		
		temp_out1		:	out 	std_logic_vector(31 downto 0);
		temp_out0		:	out 	std_logic_vector(31 downto 0);
		temp_extend		:	out		std_logic_vector(31 downto 0);
		
		temp_read1		:	out		std_logic_vector(4 downto 0);
		temp_read0		:	out		std_logic_vector(4 downto 0);
		shamt			:	in		std_logic_vector(4 downto 0);
		shdir			:	in		std_logic;
		en				:	in		std_logic;
		temp_write :	 out std_logic_vector(4 downto 0)
		
	
    );   
end component;


signal		clk				:			std_logic := '0';
signal		wr_en			:			std_logic;
signal 		ALUsrc			:			std_logic;
		
signal		temp_control 	:			std_logic_vector(3 downto 0);
signal		temp_output		:			std_logic_vector(31 downto 0);
signal		temp_sel		:			std_logic;
signal		temp_rst		:			std_logic;
		
signal		temp_pc			: 	 		std_logic_vector(7 downto 0);
signal		temp_memory_out	:			std_logic_vector(31 downto 0);
signal 		temp_imm		:			std_logic_vector(15 downto 0);
signal 		temp_out1		:		 	std_logic_vector(31 downto 0);
signal		temp_out0		:			std_logic_vector(31 downto 0);
signal		temp_extend		:			std_logic_vector(31 downto 0);

signal 		temp_read1		:			std_logic_vector(4 downto 0);
signal 		temp_read0		:			std_logic_vector(4 downto 0);
signal 		shamt			:			std_logic_vector(4 downto 0);
signal		shdir			:			std_logic;
signal		en				:			std_logic;
signal temp_write :	std_logic_vector(4 downto 0);

begin
 

single_cycle1: single_cycle 
	port map (
		clk => clk, 
		wr_en => wr_en,
		ALUsrc	=>	ALUsrc,
		temp_control => temp_control,
		temp_output => temp_output,
		temp_sel => temp_sel,
		temp_rst=>temp_rst,
		temp_pc=>temp_pc,
		temp_memory_out => temp_memory_out,
		temp_imm => temp_imm,
		temp_out1 => temp_out1,
		temp_out0 => temp_out0,
		temp_extend => temp_extend,
		temp_read1 => temp_read1,
		temp_read0 => temp_read0,
		shamt => shamt,
		shdir => shdir,
		en => en,
		temp_write => temp_write

	);
	
	 clk <= not clk after 10 ns;
process
begin
en <= '1';
temp_sel <= '0';
temp_rst <='1';
wr_en <= '1';
ALUsrc <= '1';
temp_control <= "0011";
shdir <= '0'; -- sh left
shamt <= "10000";
wait for 5 ns;
temp_rst <='0';


wait for 45 ns;
temp_sel <= '1';
ALUsrc <='0';
temp_control <= "0010";

wait;


end process;

end behv;

