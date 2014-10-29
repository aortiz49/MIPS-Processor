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


	component reg32
		port(
			d			:	in		std_logic_vector(31 DOWNTO 0);
			rst	:	in	std_logic;
			en			:   in 		std_logic;
			clk 		: 	in 		std_logic; -- clock.
			q    		: 	out 	std_logic_vector(31 DOWNTO 0) -- output
		);
	end component;

	component zeroReg
		port(
		  	clk       : in  std_logic;
		    rst       : in  std_logic;
		    en        : in  std_logic;
		    input     : in  std_logic_vector(31 downto 0);
		    output    : out std_logic_vector(31 downto 0)
  		);
	end component;
	
	component decoder
		port(
			enable			:	in		std_logic_vector(4 downto 0);
			wr_en			:	in		std_logic;
			decode_out		:	out		std_logic_vector(31 downto 0)
		);
	end component;
	
	component regFile_mux
		port(
			in31		:	in		std_logic_vector(31 downto 0);
			in30		:	in  	std_logic_vector(31 downto 0);
			in29		:	in		std_logic_vector(31 downto 0);
			in28		:	in 		std_logic_vector(31 downto 0);
			in27		:	in		std_logic_vector(31 downto 0);
			in26		:	in 		std_logic_vector(31 downto 0);
			in25		:	in		std_logic_vector(31 downto 0);
			in24		:	in 		std_logic_vector(31 downto 0);
			in23		:	in		std_logic_vector(31 downto 0);
			in22		:	in 		std_logic_vector(31 downto 0);
			in21		:	in		std_logic_vector(31 downto 0);
			in20		:	in 		std_logic_vector(31 downto 0);
			in19		:	in		std_logic_vector(31 downto 0);
			in18		:	in 		std_logic_vector(31 downto 0);
			in17		:	in		std_logic_vector(31 downto 0);
			in16		:	in 		std_logic_vector(31 downto 0);
			in15		:	in		std_logic_vector(31 downto 0);
			in14		:	in 		std_logic_vector(31 downto 0);
			in13		:	in		std_logic_vector(31 downto 0);
			in12		:	in 		std_logic_vector(31 downto 0);
			in11		:	in		std_logic_vector(31 downto 0);
			in10		:	in 		std_logic_vector(31 downto 0);
			in09		:	in		std_logic_vector(31 downto 0);
			in08		:	in 		std_logic_vector(31 downto 0);
			in07		:	in		std_logic_vector(31 downto 0);
			in06		:	in 		std_logic_vector(31 downto 0);
			in05		:	in		std_logic_vector(31 downto 0);
			in04		:	in 		std_logic_vector(31 downto 0);
			in03		:	in		std_logic_vector(31 downto 0);
			in02		:	in 		std_logic_vector(31 downto 0);
			in01		:	in		std_logic_vector(31 downto 0);
			in00		:	in 		std_logic_vector(31 downto 0);
			sel			:	in		std_logic_vector(4 downto 0);
			output		:	out 	std_logic_vector(31 downto 0)
	);
	end component;
	
	
	
type t_interconnect is array (0 to 31) of std_logic_vector(31 downto 0); -- the new type
signal interconnect		: 	t_interconnect;
signal en_t				:	std_logic_vector(31 downto 0);
signal zero_reg			:	std_logic_vector(31 downto 0);

	begin	
	regs: for i in 1 to 31 generate	
		reg_bank: reg32 
			port map(
				d => data,
				rst => rst,
				en => en_t(i),
				clk => clk,
				q => interconnect(i)
			);
	end generate;
	
	decode : decoder
		port map(
			enable => reg_write,
			wr_en => wr_en,
			decode_out => en_t(31 downto 0)	
		);
		
	mux1 : regFile_mux
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
	
		mux2 : regFile_mux
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
		
		zero:zeroReg
			port map(
				
				clk   	=>	clk,
			    rst     =>	rst,  
			    en     	=>	'0',  
			    input   => 	data,
			    output  => interconnect(00)
  		);
  		
		
		
	

end architecture;