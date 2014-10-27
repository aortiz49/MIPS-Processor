library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_cycle is
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
		temp_write	:	out	std_logic_vector(4 downto 0)
		
    ); 
end single_cycle;

architecture bhv of single_cycle is
	
	component register_File 
		port ( 
			clk				:   in   	std_logic;
	      data			    :   in   	std_logic_vector (31 downto 0);
			rst			:		in		std_logic;
			reg_write		:	in		std_logic_vector(4 downto 0);
			wr_en			:	in		std_logic;
			reg_read1		:	in 		std_logic_vector(4 downto 0);
			reg_read0		:	in 		std_logic_vector(4 downto 0);
			output1			:	out		std_logic_vector(31 downto 0);
			output0			:	out		std_logic_vector(31 downto 0)
			
			
    	); 
    end component;
    
    component instruction_mem is 
		port (
		
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
		
	component alu32 is 
		port(
		ia		:	in	std_logic_vector(31 downto 0);
		ib		:	in	std_logic_vector(31 downto 0);
		shamt	:	in std_logic_vector(4 downto 0);
		shdir	:	in std_logic;
		C		:	out	std_logic;
		control	:	in	std_logic_vector(3 downto 0);
		output	:	out	std_logic_vector(31 downto 0);
		Z 		:	out	std_logic;
		S		:	out std_logic;
		V		:	out	std_logic
		
	);
	end component;

	component regWrite_mux is 
		port(
			in1		:	in	std_logic_vector(4 downto 0);
			in0		:	in std_logic_vector(4 downto 0);
			sel		:	in	std_logic;
			output	:	out std_logic_vector(4 downto 0)
		);
	end component;
	
	component programCounter is 
		port(
						
		  	clk		: 	in  std_logic;
		    rst     :	in  std_logic;
		    en		:	in	std_logic;
		    input   : 	in  std_logic_vector(7 downto 0);
		    output  : 	out std_logic_vector(7 downto 0)
 		 );
 	end component;
 	
 	component add8 is
		port(
			in1		:	in	std_logic_vector(7 downto 0);
			in0		:	in	std_logic_vector(7 downto 0);
			sum		:	out	std_logic_vector(7 downto 0)
		);
	end component;
	
	component zeroext is
		port(
			in0		:	in	std_logic_vector(15 downto 0);
			out0	:	out	std_logic_vector(31 downto 0)			
		);
	end component; 
	
	component mux32 is
		port(
			in1			:	in	std_logic_vector(31 downto 0);
			in0			:	in 	std_logic_vector(31 downto 0);
			sel			:	in	std_logic;
			output		:	out std_logic_vector(31 downto 0)		
		);
	end component;



	
signal reg_file_out_1	:	std_logic_vector(31 downto 0);
signal reg_file_out_0	:	std_logic_vector(31 downto 0);
signal ALUsrc_out		:	std_logic_vector(31 downto 0);
signal ALU_result		:	std_logic_vector(31 downto 0);

signal temp_ram_out		:	std_logic_vector(31 downto 0);
signal temp_mux_out		:	std_logic_vector(4 downto 0);
signal temp_PC_inc_in	:	std_logic_vector(7 downto 0);
signal temp_PC_inc_out	:	std_logic_vector(7 downto 0);
signal zero_ext_signal	:	std_logic_vector(31 downto 0);



signal 		temp_c	:	std_logic;
signal		C		:		std_logic;
signal		control	:	std_logic_vector(3 downto 0);
signal		Z 		:		std_logic;
signal		S		:	 std_logic;
signal		V		:		std_logic;

    
begin
	
	reg_file : register_File
		port map(
			clk => clk,
			data => ALU_result,
			rst => temp_rst,
			reg_write => temp_mux_out,
			wr_en => wr_en,
			reg_read1 => temp_ram_out(25 downto 21), -- rs
			reg_read0 => temp_ram_out(20 downto 16), -- rt
			output1 => reg_file_out_1,
			output0 => reg_file_out_0			
		);
		
	ram : instruction_mem
		port map(
			address	=>temp_PC_inc_out,
			clock=>clk,		
			q=> temp_ram_out  			
		);
		
	alu: alu32
		port map(
			ia			=> 	reg_file_out_1,
			ib 			=>  ALUsrc_out,
			shamt => shamt,
			shdir => shdir,
			C			=> temp_c,
			control 	=> temp_control,
			output		=>	ALU_result,
			z => z,
			s => s,
			v => v		
		);
		
	write_mux: regWrite_mux
		port map(
			in1 => temp_ram_out(15 downto 11), -- rd
			in0 => temp_ram_out(20 downto 16), -- rt
			sel => temp_sel,
			output => temp_mux_out		
		);
		
	PC:	programCounter
		port map(
			clk => clk,
			rst => temp_rst,
			en	=> en,
			input => temp_PC_inc_in,
			output => temp_PC_inc_out					
		);
		
	adder: add8
		port map(
			in1 => "00000001",
			in0 => temp_PC_inc_out,
			sum => temp_PC_inc_in			
		);
		
	zero:zeroext
		port map(
			in0 => temp_ram_out(15 downto 0), -- imm
			out0	=> zero_ext_signal			
		);
		
	alu_src_mux: mux32
		port map(
			in1	=>	zero_ext_signal,
			in0 => 	reg_file_out_0,
			sel => 	ALUsrc,
			output => ALUsrc_out					
		);
		
		
temp_pc <= temp_pc_inc_out;
temp_memory_out <= temp_ram_out;
temp_output <= ALU_result;
temp_imm <= temp_ram_out(15 downto 0);
			
temp_out1 <= reg_file_out_1;
temp_out0 <= reg_file_out_0;
temp_extend <= zero_ext_signal;
temp_read1 <= temp_ram_out(25 downto 21);
temp_read0 <= temp_ram_out(20 downto 16);
temp_write <= temp_mux_out;

 
end bhv;

	
	
	