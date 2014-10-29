library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_cycle is
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
		ALU_Result_out	:	out		std_logic_vector(31 downto 0);
		pc_rst_out		:	out		std_logic;
		C				:	out		std_logic;
		S				:	out		std_logic;
		V				:	out		std_logic;
		Z				:	out		std_logic;
		ExtOp_out		:	out		std_logic		
    ); 
end single_cycle;

architecture bhv of single_cycle is
	
	component register_File 
		port ( 
			clk			:   in   	std_logic;
	      	data		:   in   	std_logic_vector (31 downto 0);
			rst			:	in		std_logic;
			reg_write	:	in		std_logic_vector(4 downto 0);
			wr_en		:	in		std_logic;
			reg_read1	:	in 		std_logic_vector(4 downto 0);
			reg_read0	:	in 		std_logic_vector(4 downto 0);
			output1		:	out		std_logic_vector(31 downto 0);
			output0		:	out		std_logic_vector(31 downto 0)
			
			
    	); 
    end component;
    
    component instruction_mem is 
		port (
		
			address		: 	IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: 	IN STD_LOGIC  := '1';
			q			: 	OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
		
	component alu32 is 
		port(
			ia			:	in	std_logic_vector(31 downto 0);
			ib			:	in	std_logic_vector(31 downto 0);
			shamt		:	in std_logic_vector(4 downto 0);
			shdir		:	in std_logic;
			C			:	out	std_logic;
			control		:	in	std_logic_vector(3 downto 0);
			output		:	out	std_logic_vector(31 downto 0);
			Z 			:	out	std_logic;
			S			:	out std_logic;
			V			:	out	std_logic
			
	);
	end component;

	component regWrite_mux is 
		port(
			in1			:	in	std_logic_vector(4 downto 0);
			in0			:	in std_logic_vector(4 downto 0);
			sel			:	in	std_logic;
			output		:	out std_logic_vector(4 downto 0)
		);
	end component;
	
	component programCounter is 
		port(
						
		  	clk			: 	in  std_logic;
		    rst     	:	in  std_logic;
		    input   	: 	in  std_logic_vector(31 downto 0);
		    output  	: 	out std_logic_vector(31 downto 0)
 		 );
 	end component;
 	
 	component add32 is
		port(
			in1			:	in	std_logic_vector(31 downto 0);
			in0			:	in	std_logic_vector(31 downto 0);
			sum			:	out	std_logic_vector(31 downto 0)
		);
	end component;
	
	component extender is
		port(
			in0			:	in	std_logic_vector(15 downto 0);
			ExtOp		:	in	std_logic;
			out0		:	out	std_logic_vector(31 downto 0)
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
	
	component main_control is
		port(
			op_code		: 	in		std_logic_vector(5 downto 0);	
			RegDst		:	out		std_logic;	
			ALUsrc		:	out		std_logic;
			MemtoReg	:	out 	std_logic;
			RegWrite	:	out		std_logic;					
			shdir		:	out		std_logic;
			shamt		:	out		std_logic_vector(4 downto 0);
			ALUOp		:	out		std_logic_vector(2 downto 0);
			ExtOp		:	out		std_logic
		);
	end component;
	
	component alu32control is
		port( 
	      ALUop			: in     std_logic_vector (2 downto 0);
	      funct			: in     std_logic_vector (5 downto 0);
	      control 		: out    std_logic_vector (3 downto 0)
  		 );
  	end component;
		



	
signal 	reg_file_out_1	:	std_logic_vector(31 downto 0);
signal 	reg_file_out_0	:	std_logic_vector(31 downto 0);
signal	ALUsrc_mux		:	std_logic_vector(31 downto 0);
signal 	ALU_result		:	std_logic_vector(31 downto 0);
signal 	temp_ram_out	:	std_logic_vector(31 downto 0);
signal 	temp_mux_out	:	std_logic_vector(4 downto 0);
signal 	temp_PC_inc_in	:	std_logic_vector(31 downto 0);
signal 	temp_PC_inc_out	:	std_logic_vector(31 downto 0);
signal 	zero_ext_signal	:	std_logic_vector(31 downto 0);

---

signal	RegDst			:	std_logic;
signal	ALUsrc			:	std_logic;
signal	MemtoReg		:	std_logic;
signal 	RegWrite		:	std_logic;
signal	shdir			:	std_logic;
signal 	shamt			:	std_logic_vector(4 downto 0);
signal 	ALUOp			:	std_logic_vector(2 downto 0);
signal 	ALUControl		:	std_logic_vector(3 downto 0);
signal 	ExtOp			:	std_logic;



    
begin
	
	reg_file : register_File
		port map(
			clk => clk,
			data => ALU_result,
			rst => pc_rst,
			reg_write => temp_mux_out,
			wr_en => RegWrite,
			reg_read1 => temp_ram_out(25 downto 21), -- rs
			reg_read0 => temp_ram_out(20 downto 16), -- rt
			output1 => reg_file_out_1,
			output0 => reg_file_out_0			
		);
		
	ram : instruction_mem
		port map(
			address	=>temp_PC_inc_out(7 downto 0),
			clock=>clk,		
			q=> temp_ram_out  			
		);
		
	alu: alu32
		port map(
			ia			=> 	reg_file_out_1,
			ib 			=>  ALUsrc_mux,
			shamt 		=> shamt,
			shdir 		=> shdir,
			C			=> C,
			control 	=> ALUControl,
			output		=>	ALU_result,
			z => Z,
			s => S,
			v => V		
		);
		
	write_mux: regWrite_mux
		port map(
			in1 => temp_ram_out(15 downto 11), -- rd
			in0 => temp_ram_out(20 downto 16), -- rt
			sel => RegDst,
			output => temp_mux_out		
		);
		
	PC:	programCounter
		port map(
			clk => clk,
			rst => pc_rst,
			input => temp_PC_inc_in,
			output => temp_PC_inc_out					
		);
		
	adder: add32
		port map(
			in1 => x"00000001",
			in0 => temp_PC_inc_out,
			sum => temp_PC_inc_in			
		);
		
	extend:extender
		port map(
			in0 		=> 	temp_ram_out(15 downto 0), 
			ExtOp		=>	ExtOp,	
			out0		=> 	zero_ext_signal			
		);
		
	alu_src_mux: mux32
		port map(
			in1	=>	zero_ext_signal,
			in0 => 	reg_file_out_0,
			sel => 	ALUsrc,
			output => ALUsrc_mux					
		);
		
	controller: main_control
		port map(
			op_code		=> 	temp_ram_out(31 downto 26),	
			RegDst		=>	RegDst,						
			ALUsrc		=>	ALUsrc,		
			MemtoReg	=>	MemtoReg,		
			RegWrite	=>	RegWrite,							
			shdir		=> 	shdir,			
			shamt		=>	shamt,		
			ALUOp		=> 	ALUOp,
			ExtOp		=>	ExtOp	
		);
		
	alucontroller: alu32control
		port map(
			ALUOp		=>	ALUOp,
			funct		=> 	temp_ram_out(5 downto 0),
			control		=>	ALUControl
		);
		
		
program_counter		<=		temp_PC_inc_out;
instruction			<=		temp_ram_out ;
ALUsrc_out			<=		ALUsrc;
RegDst_out			<=		RegDst;
RegWrite_out		<=		RegWrite;

shdir_out			<=		shdir;
shamt_out			<=		shamt;		
ALUOp_out			<=		ALUOp;
ALUControl_out		<=		ALUControl;
RW_out				<=		temp_mux_out;
RD1_out				<= 		temp_ram_out(25 downto 21);
RD0_out				<=		temp_ram_out(20 downto 16);
RegFileOut1			<=		reg_file_out_1;
RegFileOut0			<=		reg_file_out_0;		
Extend_out			<=		zero_ext_signal;
ALU_Result_out		<=		ALU_result;
pc_rst_out			<=		pc_rst;
ExtOp_out			<=		Extop;
		

end bhv;

	
	
	