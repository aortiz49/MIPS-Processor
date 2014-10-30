library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.MIPS_lib.all;


entity alu32control is
   port( 
      ALUop			:	in    	std_logic_vector (2 downto 0);
      funct			: 	in     	std_logic_vector (5 downto 0);
      control 		: 	out    	std_logic_vector (3 downto 0);
      shdir			:	out		std_logic		
   );
end alu32control ;


architecture bhv of alu32control is
begin
	process(ALUop, funct)
	begin
		 shdir		<=	'0';		-- shift left for lui (default))
	    case ALUop is
	      	when ADD	=>					-- Add for load/store/addi/addiu
		        control 	<= 	F_SUM;
			when BEQ 	=>					-- sub for branching 
		    	control 	<= 	F_SUB;
			when ANDI 	=>					-- and imm
				control 	<= 	F_AND;
			when ORI 	=>					-- or immediate
				control 	<= 	F_OR;		      			
			when LUI 	=>	 				-- lui	
				control 	<= 	F_SHFT;
			when SLTI	=>					-- set if less than imm
				control		<=	F_SLT;
			when SLTIU	=>					-- set if less than imm unsigned
				control		<=	F_SLTU;
			when R_TYPE =>					-- R-type instructions
				shdir		<=	funct(1);	-- for sll this bit is '0', for slr it's '1'
		        case funct IS
					when CTRL_ADD =>
						control <= 	F_SUM;
					when CTRL_ADDU =>
				   		control <= 	F_SUM;
				    when CTRL_SUB =>
				        control <= 	F_SUB;
				   	when CTRL_AND =>
				        control <= 	F_AND;
				    when CTRL_OR =>
				        control <= 	F_OR;
				    when CTRL_NOR =>
				        control <= 	F_NOR;
				    when CTRL_SLT =>
				        control <= 	F_SLT;
				    when CTRL_SLTU =>
				        control <= 	F_SLTU;
				    when CTRL_SLL =>
				        control	<=	F_SHFT;	
				    when CTRL_SRL =>
				        control	<=	F_SHFT;	
				    when others =>
				        control <= (others => '0');     
				end case;
			when others =>
		    	control <= (others => '0');
			end case;
	end process;
end bhv;