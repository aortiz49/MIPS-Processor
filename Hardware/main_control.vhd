library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_lib.all;

entity main_control is

	port(									
		op_code		  			: 	in		std_logic_vector(5 downto 0);	
		RegDst					:	out		std_logic;	
		ALUsrc					:	out		std_logic;
		RegWrite				:	out		std_logic;	
		ALUOp					:	out		std_logic_vector(2 downto 0);
		ExtOp					:	out		std_logic
	);	
end main_control;		

architecture BHV of main_control is
begin
	process(op_code)						-- process for state determination
	begin		
		RegDst		<=	'0';				-- RegDst is Rt	
		ALUsrc 		<= 	'0';
		RegWrite 	<= 	'0';
		ALUOp		<=	(others => '0');	
		ExtOp		<=	'0';	
		
		case op_code is
			when OPC_R 			=>
				RegDst		<=	'1';		-- 	Set RegWrite mux write to Rd
				RegWrite	<=	'1';		-- 	Enable register write to store value in destination reg
				ALUOp		<=	R_TYPE;		-- 	ALUop is an R-Type		
			when OPC_ORI		=>
				ALUsrc		<=	'1';		-- Select zero-extend 32-bit value
				RegWrite	<=	'1';		-- Write to Regfile
				ALUOp		<=	ORI;		-- Do an or operation
			when OPC_LUI		=>
				ALUsrc		<=	'1';		-- 	Select zero-extended 32-bit value	
				RegWrite	<=	'1';		-- 	Enable register write to store value in destination reg
				ALUOp		<=	LUI;		-- 	Set ALUOp to LUI
			when OPC_ADDI		=>
				ALUsrc		<=	'1';		-- 	Select zero-extended 32-bit value	
				ExtOp		<=	'1';		-- 	Sign extend
				RegWrite	<=	'1';		-- 	Enable register write to store value in destination reg
				ALUOp		<=	ADD;		-- 	Set ALUOp to ADD
			when OPC_ADDIU		=>
				ALUsrc		<=	'1';		-- 	Select zero-extended 32-bit value	
				ExtOp		<=	'1';		-- 	Sign extend
				RegWrite	<=	'1';		-- 	Enable register write to store value in destination reg
				ALUOp		<=	ADD;		-- 	Set ALUOp to ADD
			when OPC_ANDI		=>
				ALUsrc		<=	'1';		-- 	Select zero-extend 32-bit value
				RegWrite	<=	'1';		-- 	Write to Regfile
				ALUOp		<=	ANDI;		-- 	Do an and operation
			when OPC_SLTI		=>
				ALUsrc		<=	'1';		-- 	Select zero-extend 32-bit value
				ExtOp		<=	'1';		--	Sign extend		
				RegWrite	<=	'1';		-- 	Write to Regfile
				ALUOp		<=	SLTI;		-- 	Do an slt operation
			when OPC_SLTIU		=>
				ALUsrc		<=	'1';		-- 	Select zero-extend 32-bit value
				ExtOp		<=	'1';		--	Sign extend		
				RegWrite	<=	'1';		-- 	Write to Regfile
				ALUOp		<=	SLTIU;		-- 	Do an slt operation	
			when OPC_BEQ		=>
				ALUsrc		<=	'1';		-- 	Select zero-extend 32-bit value
				ExtOp		<=	'1';		--	Sign extend		
				RegWrite	<=	'1';		-- 	Write to Regfile
				ALUOp		<=	BEQ;		-- 	Do an subtract operation			
			when others			=>												
		end case;
	end process;
end BHV;
			

			
		






