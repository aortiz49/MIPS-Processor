library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_lib.all;

entity main_control is

	port(									
		op_code		  			: 	in		std_logic_vector(5 downto 0);		
		pc_rst					:	out		std_logic;						-- Reset program counter
		pc_en					:	out 	std_logic;						-- enable a pc inc
		RegDst					:	out		std_logic;
		RegWr					:	out		std_logic;
		ALUsrc					:	out		std_logic;
		shdir					:	out		std_logic;
		shamt					:	out		std_logic_vector(4 downto 0);
		ALUctrl					:	out		std_logic_vector(3 downto 0)	-- Set actual opcode(temp cheap solution for now)
	);	
end main_control;		


architecture BHV of main_control is
begin

	process(op_code)					-- process for state determination
	begin		
		pc_rst <='1';
		case op_code is
			when OPC_LUI =>
				pc_en <= '1';
				RegDst <= '0';				
				RegWr <= '1';
				ALUsrc <= '1';
				ALUctrl <= "0011";
				shdir <= '0'; -- sh left
				shamt <= "10000";
		end case;
	end process;
end BHV;
			
	
			
		






