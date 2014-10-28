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
		ALUOp					:	out		std_logic_vector(2 downto 0)	-- Set actual opcode(temp cheap solution for now)
	);	
end main_control;		


architecture BHV of main_control is
begin

	process(op_code)					-- process for state determination
	begin		
		RegDst		<=	'0';
		ALUsrc 		<= 	'0';
		MemtoReg 	<= 	'0';
		RegWrite 	<= 	'0';
		shdir		<= 	'0';
		shamt		<=	(others => '0');
		ALUop		<=	(others => '0');		
		case op_code is
			when OPC_LUI =>
				ALUsrc		<=	'1';			-- Select extended 32-bit value	
				RegWrite	<=	'1';			-- Enable register write to store value in destination reg
				shamt		<=	"10000";		-- Shift left 16 bits
				ALUOp		<=	LUI;			-- Set ALUOp to LUI
			when others =>
				
		end case;
	end process;
end BHV;
			
	
			
		






