library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.MIPS_lib.all;


entity alu32control is
   port( 
      ALUop		: in     std_logic_vector (2 downto 0);
      funct		: in     std_logic_vector (5 downto 0);
      control 	: out    std_logic_vector (3 downto 0)
   );
end alu32control ;


architecture bhv of alu32control is
begin
	process(ALUop, funct)
		begin
	    	case ALUop is
	      		when LW_SW	=>						-- Add for load/store 
		        	control <= F_SUM;
		      	when BEQ 	=>							-- sub for branching 
		      		control <= F_SUB;
				when ANDI 	=>						-- and immetiate
					control <= F_AND;
				when ORI 	=>							-- or immediate
					control <= F_OR;		      			
				when LUI 	=>	 
					control <= F_SHFT;
		      	when R_TYPE =>						-- R-type instructions
		        	case funct IS
				        when CTRL_ADD =>
				            control <= F_SUM;
				        when CTRL_SUB =>
				            control <= F_SUB;
				        when CTRL_AND =>
				            control <= F_AND;
				        when CTRL_OR =>
				            control <= F_OR;
				        when CTRL_NOR =>
				        	control <= F_NOR;
				        when CTRL_SLT =>
				        	control <= F_SLT;
				        when CTRL_SLTU =>
				            control <= F_SLTU;
				         when others =>
				         	control <= (others => '0');     
					end case;
		      	when others =>
		        	control <= (others => '0');
			end case;
	end process;
end bhv;