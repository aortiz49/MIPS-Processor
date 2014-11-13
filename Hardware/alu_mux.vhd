library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_lib.all;


entity alu_mux is
	port(
		control		:	in std_logic_vector(3 downto 0);
		sum_in		:	in	std_logic;
		sub_in		:	in	std_logic;
		and_in		:	in	std_logic;
		or_in		:	in	std_logic;
		nor_in		:	in	std_logic;
		slt_in		:	in	std_logic;
		sltu_in		:	in	std_logic;
		mux_out		:	out	std_logic	
	);
end alu_mux;

architecture arch of alu_mux is
begin
	process(control,sum_in,sub_in,and_in,or_in,nor_in,slt_in,sltu_in)
	begin
		case control is
			when F_SUM =>
				mux_out <= sum_in;
			when F_SUB =>
				mux_out <= sub_in;	-- Same as sum, but this control signal enables add_sub and carry
			when F_AND =>
				mux_out <= and_in;
			when F_OR =>
				mux_out <= or_in;
			when F_NOR =>
				mux_out <= nor_in;
			when F_SLT	=>
				mux_out	<= slt_in;
			when F_SLTU	=>
				mux_out	<= sltu_in;
			when others =>
				mux_out <= '0';	-- removes inferred latch warnings
		end case;
	end process;
end arch;
	
	
	