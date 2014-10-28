library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity single_cycle_tb is
end single_cycle_tb;

architecture behv of single_cycle_tb is

component single_cycle 
	port ( 
		clk				:   in   	std_logic;
		program_counter	:	out		std_logic_vector(31 downto 0);
		instruction		:	out		std_logic_vector(31 downto 0);	
		ALUsrc_out		:	out		std_logic;
		RegDst_out		:	out		std_logic;
		RegWrite_out	:	out		std_logic;
		pc_rst			:	in		std_logic;
		shdir_out		:	out		std_logic;
		shamt_out		:	out		std_logic_vector(4 downto 0);
		ALUOp_out		:	out		std_logic_vector(2 downto 0);
		ALUControl_out	:	out		std_logic_vector(3 downto 0);
		RW_out			:	out 	std_logic_vector(4 downto 0);
		RD1_out			:	out		std_logic_vector(4 downto 0);
		RD0_out			:	out		std_logic_vector(4 downto 0);
		RegFileOut1		:	out		std_logic_vector(31 downto 0);
		RegFileOut0		:	out		std_logic_vector(31 downto 0);
		Extend_out		:	out		std_logic_vector(31 downto 0);
		ALU_Result_out	:	out		std_logic_vector(31 downto 0)		
    );   
end component;


signal		clk				:			std_logic := '0';
signal 		program_counter	:			std_logic_vector(31 downto 0);
signal		instruction		:			std_logic_vector(31 downto 0);	
signal		ALUsrc_out		:			std_logic;
signal		RegDst_out		:			std_logic;
signal		RegWrite_out	:			std_logic;
signal		shdir_out		:			std_logic;
signal		shamt_out		:			std_logic_vector(4 downto 0);
signal		ALUOp_out		:			std_logic_vector(2 downto 0);
signal		ALUControl_out	:			std_logic_vector(3 downto 0);
signal		RW_out			:	 		std_logic_vector(4 downto 0);
signal		RD1_out			:			std_logic_vector(4 downto 0);
signal		RD0_out			:			std_logic_vector(4 downto 0);
signal		RegFileOut1		:			std_logic_vector(31 downto 0);
signal		RegFileOut0		:			std_logic_vector(31 downto 0);
signal		Extend_out		:			std_logic_vector(31 downto 0);
signal		ALU_Result_out	:			std_logic_vector(31 downto 0);
signal 		pc_rst 			:			std_logic;


begin
 

single_cycle1: single_cycle 
	port map (
		clk 				=> 		clk, 
		program_counter		=>		program_counter,
		instruction			=>		instruction,	
		ALUsrc_out			=>		ALUsrc_out,
		RegDst_out			=>		RegDst_out,
		RegWrite_out		=>		RegWrite_out,
		pc_rst				=>		pc_rst,
		shdir_out			=>		shdir_out,
		shamt_out			=>		shamt_out,
		ALUOp_out			=>		ALUOp_out,
		ALUControl_out		=>		ALUControl_out,
		RW_out				=>	 	RW_out,
		RD1_out				=>		RD1_out,
		RD0_out				=>		RD0_out,
		RegFileOut1			=>		RegFileOut1,
		RegFileOut0			=>		RegFileOut0,
		Extend_out			=>		Extend_out,
		ALU_Result_out		=>		ALU_Result_out


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

