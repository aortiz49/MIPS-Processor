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
		MemWrite_out	:	out		std_logic;
		C				:	out		std_logic;
		S				:	out		std_logic;
		V				:	out		std_logic;
		Z				:	out		std_logic;
		ExtOp_out		:	out		std_logic		
    ); 
end single_cycle;

architecture bhv of single_cycle is
	

	
signal 	reg_file_out_1	:	std_logic_vector(31 downto 0);
signal 	reg_file_out_0	:	std_logic_vector(31 downto 0);
signal	ALUsrc_mux		:	std_logic_vector(31 downto 0);
signal 	ALU_result		:	std_logic_vector(31 downto 0);
signal	dataOut			:	std_logic_vector(31 downto 0);
signal 	temp_ram_out	:	std_logic_vector(31 downto 0);
signal 	temp_mux_out	:	std_logic_vector(4 downto 0);
signal 	temp_PC_inc_in	:	std_logic_vector(31 downto 0);
signal 	temp_PC_inc_out	:	std_logic_vector(31 downto 0);
signal 	zero_ext_signal	:	std_logic_vector(31 downto 0);
signal	MemtoRegOut		:	std_logic_vector(31 downto 0);

---

signal	RegDst			:	std_logic;
signal	ALUsrc			:	std_logic;
signal	MemtoReg		:	std_logic;
signal 	RegWrite		:	std_logic;
signal 	MemWrite		:	std_logic;
signal	shdir			:	std_logic;
signal 	shamt			:	std_logic_vector(4 downto 0);
signal 	ALUOp			:	std_logic_vector(2 downto 0);
signal 	ALUControl		:	std_logic_vector(3 downto 0);
signal 	ExtOp			:	std_logic;
signal	ByteEn			:	std_logic_vector(3 downto 0);




    
begin
	
	reg_file : entity work.register_File
		port map(
			clk => clk,
			data => MemtoRegOut,
			rst => pc_rst,
			reg_write => temp_mux_out,
			wr_en => RegWrite,
			reg_read1 => temp_ram_out(25 downto 21), -- rs
			reg_read0 => temp_ram_out(20 downto 16), -- rt
			output1 => reg_file_out_1,
			output0 => reg_file_out_0			
		);
		
	ram : entity work.instruction_mem
		port map(
			address	=>temp_PC_inc_out(7 downto 0),
			clock=>clk,		
			q=> temp_ram_out  			
		);
		
	alu: entity work.alu32
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
		
	write_mux: entity work.regWrite_mux
		port map(
			in1 => temp_ram_out(15 downto 11), -- rd
			in0 => temp_ram_out(20 downto 16), -- rt
			sel => RegDst,
			output => temp_mux_out		
		);
		
	PC:	entity work.programCounter
		port map(
			clk => clk,
			rst => pc_rst,
			input => temp_PC_inc_in,
			output => temp_PC_inc_out					
		);
		
	adder: entity work.add32
		port map(
			in1 => x"00000001",
			in0 => temp_PC_inc_out,
			sum => temp_PC_inc_in			
		);
		
	extend:	entity work.extender
		port map(
			in0 		=> 	temp_ram_out(15 downto 0), 
			ExtOp		=>	ExtOp,	
			out0		=> 	zero_ext_signal			
		);
		
	alu_src_mux: entity work.mux32
		port map(
			in1	=>	zero_ext_signal,
			in0 => 	reg_file_out_0,
			sel => 	ALUsrc,
			output => ALUsrc_mux					
		);
		
	controller: entity work.main_control
		port map(
			op_code		=> 	temp_ram_out(31 downto 26),	
			shamt_in	=>	temp_ram_out(10 downto 6),
			RegDst		=>	RegDst,						
			ALUsrc		=>	ALUsrc,		
			MemtoReg	=>	MemtoReg,		
			MemWrite	=>	MemWrite,
			RegWrite	=>	RegWrite,	
			ByteEn		=>	ByteEn,									
			shamt_out	=>	shamt,		
			ALUOp		=> 	ALUOp,
			ExtOp		=>	ExtOp	
		);
		
	alucontroller: entity work.alu32control
		port map(
			ALUOp		=>	ALUOp,
			funct		=> 	temp_ram_out(5 downto 0),
			control		=>	ALUControl,
			shdir		=>	shdir
		);
			
	datamemory: entity work.data_mem
		port map(
			address 	=> 	ALU_result(7 downto 0),
			byteena 	=> 	ByteEn,
			clock   	=> 	clk,
			data    	=> 	reg_file_out_0,
			wren    	=> 	MemWrite,		
			q       	=> 	dataOut
		);
		
	memMux:	entity work.mux32
		port map(
			in1    		=>	dataOut,
			in0    		=> 	ALU_result,
			sel   		=> 	MemtoReg,
			output 		=>  MemtoRegOut 
		);
		
		
program_counter		<=		temp_PC_inc_out;
instruction			<=		temp_ram_out ;
ALUsrc_out			<=		ALUsrc;
RegDst_out			<=		RegDst;
RegWrite_out		<=		RegWrite;
MemWrite_out		<=		MemWrite;
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
ExtOp_out			<=		Extop;
		

end bhv;

	
	
	