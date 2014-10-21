library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_cycle is
	port ( 
		clk				:   in   	std_logic;
      	data			:   in   	std_logic_vector (31 downto 0);
		reg_write		:	in		std_logic_vector(4 downto 0);
		wr_en			:	in		std_logic;
		reg_read1		:	in 		std_logic_vector(4 downto 0);
		reg_read0		:	in 		std_logic_vector(4 downto 0);
		output1			:	out		std_logic_vector(31 downto 0);
		output0			:	out		std_logic_vector(31 downto 0)	
    ); 
end single_cycle;

architecture bhv of single_cycle is
	
	component registerFile 
		port ( 
			clk				:   in   	std_logic;
	      	data			:   in   	std_logic_vector (31 downto 0);
			reg_write		:	in		std_logic_vector(4 downto 0);
			wr_en			:	in		std_logic;
			reg_read1		:	in 		std_logic_vector(4 downto 0);
			reg_read0		:	in 		std_logic_vector(4 downto 0);
			output1			:	out		std_logic_vector(31 downto 0);
			output0			:	out		std_logic_vector(31 downto 0)
    	); 
    end component;
    
    	component instruction_mem is 
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;
    
begin
	
	reg_file : registerFile
		port map(
			clk => clk,
			data => data,
			reg_write => reg_write,
			wr_en => wr_en,
			reg_read1 => reg_read1,
			reg_read0 => reg_read0,
			output1 => output1,
			output0 => output0			
		);
		
	ram : instruction_mem
		port map(
			address	=>address_out(8 downto 0)  ,
			clock=>clk,		
			data=> external_bus,
			wren=>WEN_out,
			q=> ram_out  
			
		);
	
 
end bhv;

	
	
	