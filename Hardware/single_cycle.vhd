library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_cycle is
	port ( 
		clk					:   in   	std_logic;
		pc_rst				:	in		std_logic;
		programCounter		:	out		std_logic_vector(31 downto 0);
		instruction_out		:	out		std_logic_vector(31 downto 0);
		instr_addr			:	out		std_logic_vector(7 downto 0)		
		
    ); 
end single_cycle;

architecture bhv of single_cycle is
	
signal 	pc_inc4		:	std_logic_vector(31 downto 0);		
signal 	pc_out		:	std_logic_vector(31 downto 0);	
signal 	instruction	:	std_logic_vector(31 downto 0);
signal	ALU_out		:	std_logic_vector(31 downto 0);
signal	regFileOut1	:	std_logic_vector(31 downto 0);
signal	regFileOut0	:	std_logic_vector(31 downto 0);
signal 	extendOut	:	std_logic_vector(31 downto 0);
signal	ALUMux_out	:	std_logic_vector(31 downto 0);


signal	extendIn	:	std_logic_vector(15 downto 0);


signal	address		:	std_logic_vector(7 downto 0);
signal	opCode		:	std_logic_vector(5 downto 0);
signal	funct		:	std_logic_vector(5 downto 0);



	
signal 	rs			:	std_logic_vector(4 downto 0);
signal 	rt			:	std_logic_vector(4 downto 0);
signal 	rd			:	std_logic_vector(4 downto 0);
signal	writeReg	:	std_logic_vector(4 downto 0);
signal	shamt_in	:	std_logic_vector(4 downto 0);
signal	shamt_out	:	std_logic_vector(4 downto 0);



signal 	ALUcontrol	:	std_logic_vector(3 downto 0);


signal	ALUOp		:	std_logic_vector(2 downto 0);	


signal	regWrite	:	std_logic;
signal	shdir		:	std_logic;
signal	C,Z,S,V		:	std_logic;
signal	regDst		:	std_logic;
signal	ExtOp		:	std_logic;
signal	ALUsrc		:	std_logic;


  
begin
	
	
rs			<=		instruction(25 downto 21);
rt			<=		instruction(20 downto 16);
rd			<=		instruction(15 downto 11);
address		<=		pc_out(9 downto 2);
opcode		<=		instruction(31 downto 26);
funct		<=		instruction(5 downto 0);
extendIn	<=		instruction(15 downto 0);
shamt_in	<=		instruction(10 downto 6);


pc: entity work. programCounter
	port map(clk		=>		clk,
			 rst		=>		pc_rst,
			 input		=> 		pc_inc4,
			 output		=>		pc_out );
		
extender: entity work.extender
	port map(in0   		=>		extendIn,
			 ExtOp 		=> 		ExtOp,
			 out0  		=> 		extendOut);		
	
pc_add: entity work.add32
	port map(in1		=>		pc_out,
			 in0		=>		x"00000004",
			 sum		=>		pc_inc4 );
		
alu: entity work.alu32
	port map(ia      	=> 		regFileOut1,
			 ib      	=> 		ALUMux_out,
			 shamt   	=> 		shamt_out,
			 shdir   	=> 		shdir,
			 C       	=> 		C,
			 control 	=> 		ALUcontrol,
			 output  	=> 		ALU_out,
			 Z       	=> 		Z,
			 S       	=> 		S,
			 V       	=> 		V );
		     
aluMux: entity work.mux_gen
	generic map(width => 32)
	port map(in1    	=> 		extendOut,
		     in0    	=> 		regFileOut0,
		     sel    	=> 		ALUsrc,
		     output 	=> 		ALUMux_out);		     
	
regFile: entity work.register_file
	port map(clk       	=> 		clk,
		     data      	=> 		ALU_out,
		     rst       	=> 		pc_rst,
		     reg_write 	=> 		writeReg,
		     wr_en     	=> 		regWrite,
		     reg_read1 	=> 		rs,
		     reg_read0 	=> 		rt,
		     output1   	=> 		regFileout1,
		     output0   	=> 		regFileout0 );
		     
regDstMux: entity work.mux_gen
	generic map(width => 5)
	port map(in1    	=> 		rd,
		     in0    	=> 		rt,
		     sel    	=> 		regDst,
		     output 	=> 		writeReg);
		     
instructionMem: entity work.instruction
	port map(address 	=> 		address,
		     clock   	=> 		clk,
		     q       	=> 		instruction);
		     
mainController: entity work.main_control
	port map(op_code  	=> 		opCode,
		     RegDst   	=> 		RegDst,
		     ALUsrc   	=> 		ALUsrc,
		     RegWrite 	=> 		RegWrite,
		     ALUOp    	=> 		ALUOp,
		     ExtOp    	=> 		ExtOp);	
		    
aluController: entity work.alu_control
	port map(ALUop     	=> 		ALUop,
		     funct     	=> 		funct,
		     shamt_in  	=> 		shamt_in,
		     shamt_out 	=> 		shamt_out,
		     control   	=> 		ALUcontrol,
		     shdir     	=> 		shdir);	
		     
		     
programCounter		<=	pc_out;
instruction_out		<=	instruction;
instr_addr			<=	address;		    

end bhv;

	
	
	