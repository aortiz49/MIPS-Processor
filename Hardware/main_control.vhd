library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_lib.all;

entity main_control is

	port(									
		op_code		  			: 	in		std_logic_vector(5 downto 0);	
		RegDst					:	out		std_logic;	
		ALUsrc					:	out		std_logic;
		MemtoReg				:	out 	std_logic;
		RegWrite				:	out		std_logic;					
		shdir					:	out		std_logic;
		shamt					:	out		std_logic_vector(4 downto 0);
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
		MemtoReg 	<= 	'0';
		RegWrite 	<= 	'0';
		shdir		<= 	'0';
		shamt		<=	(others => '0');
		ALUOp		<=	(others => '0');	
		ExtOp		<=	'0';	
		case op_code is
			when OPC_LUI		=>
				ALUsrc		<=	'1';		-- Select zero-extended 32-bit value	
				RegWrite	<=	'1';		-- Enable register write to store value in destination reg
				shamt		<=	"10000";	-- Shift left 16 bits
				ALUOp		<=	LUI;		-- Set ALUOp to LUI
			when OPC_R 			=>
				RegDst		<=	'1';		-- Set RegWrite mux write to Rd
				RegWrite	<=	'1';		-- Write result to RegFile
				ALUOp		<=	R_TYPE;		-- ALUop is an R-Type
			when OPC_ADDI		=>
				ALUsrc		<=	'1';		-- Select sign-extended 32-bit value
				RegWrite	<=	'1';		-- Write result to RegFile
				ALUOp		<=	ADDI;		-- Set ALUOp to ADDI
				ExtOp		<=	'1';		-- Set extender to sign extend
			when OPC_ANDI		=>
				ALUsrc		<=	'1';		-- Select zero-extended 32-bit value
				RegWrite	<=	'1';		-- Write result to RegFile
				ALUOp		<=	ANDI;		-- Set ALUOp to ANDI			
			when OPC_ORI		=>
				ALUsrc		<=	'1';		-- Select zero-extended 32-bit value
				RegWrite	<=	'1';		-- Write result to RegFile
				ALUOp		<=	ORI;		-- Set ALUOp to ANDI			
			when others			=>
				
				
				
		end case;
	end process;
end BHV;
			
	
			
		






