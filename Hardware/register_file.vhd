library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity register_file is
	port ( 
		clk				:   in   	std_logic;
     	data			:   in   	std_logic_vector (31 downto 0);
		rst		:		in		std_logic;
		reg_write		:	in		std_logic_vector(4 downto 0);
		wr_en			:	in		std_logic;
		reg_read1		:	in 		std_logic_vector(4 downto 0);
		reg_read0		:	in 		std_logic_vector(4 downto 0);
		output1			:	out		std_logic_vector(31 downto 0);
		output0			:	out		std_logic_vector(31 downto 0)
    ); 
end entity;

architecture ARCH of register_file is


	
	
	
type t_interconnect is array (0 to 31) of std_logic_vector(31 downto 0); -- the new type
signal interconnect		: 	t_interconnect;
signal en_t				:	std_logic_vector(31 downto 0);


	begin	
	regs: for i in 1 to 31 generate	
		reg_bank: entity work.reg32 
			port map(
				d => data,
				rst => rst,
				en => en_t(i),
				clk => clk,
				q => interconnect(i)
			);
	end generate;
	
	decode : entity work.decoder
		port map(
			enable => reg_write,
			wr_en => wr_en,
			decode_out => en_t(31 downto 0)	
		);
		
	mux1 : entity work.regFile_mux
		port map(
			in31 => interconnect(31),
			in30 => interconnect(30),
			in29 => interconnect(29),
			in28 => interconnect(28),
			in27 => interconnect(27),
			in26 => interconnect(26),
			in25 => interconnect(25),
			in24 => interconnect(24),
			in23 => interconnect(23),
			in22 => interconnect(22),
			in21 => interconnect(21),
			in20 => interconnect(20),
			in19 => interconnect(19),
			in18 => interconnect(18),
			in17 => interconnect(17),
			in16 => interconnect(16),
			in15 => interconnect(15),
			in14 => interconnect(14),
			in13 => interconnect(13),
			in12 => interconnect(12),
			in11 => interconnect(11),
			in10 => interconnect(10),
			in09 => interconnect(09),
			in08 => interconnect(08),
			in07 => interconnect(07),
			in06 => interconnect(06),
			in05 => interconnect(05),
			in04 => interconnect(04),
			in03 => interconnect(03),
			in02 => interconnect(02),
			in01 => interconnect(01),
			in00 => interconnect(00),
			sel => reg_read1,
			output => output1		
		);
	
		mux2 : entity work.regFile_mux
		port map(
			in31 => interconnect(31),
			in30 => interconnect(30),
			in29 => interconnect(29),
			in28 => interconnect(28),
			in27 => interconnect(27),
			in26 => interconnect(26),
			in25 => interconnect(25),
			in24 => interconnect(24),
			in23 => interconnect(23),
			in22 => interconnect(22),
			in21 => interconnect(21),
			in20 => interconnect(20),
			in19 => interconnect(19),
			in18 => interconnect(18),
			in17 => interconnect(17),
			in16 => interconnect(16),
			in15 => interconnect(15),
			in14 => interconnect(14),
			in13 => interconnect(13),
			in12 => interconnect(12),
			in11 => interconnect(11),
			in10 => interconnect(10),
			in09 => interconnect(09),
			in08 => interconnect(08),
			in07 => interconnect(07),
			in06 => interconnect(06),
			in05 => interconnect(05),
			in04 => interconnect(04),
			in03 => interconnect(03),
			in02 => interconnect(02),
			in01 => interconnect(01),
			in00 => interconnect(00),
			sel => reg_read0,
			output => output0		
		);
		
		zero: entity work.zeroReg
			port map(
				
				clk   	=>	clk,
			    rst     =>	rst,  
			    en     	=>	'0',  
			    input   => 	data,
			    output  => interconnect(00)
  		);
  		
		
end architecture;