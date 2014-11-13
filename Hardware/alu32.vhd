library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu32 is
	port(
		ia		:	in	std_logic_vector(31 downto 0);
		ib		:	in	std_logic_vector(31 downto 0);
		shamt	:	in std_logic_vector(4 downto 0);
		shdir	:	in std_logic;
		C		:	out	std_logic;
		control	:	in	std_logic_vector(3 downto 0);
		output	:	out	std_logic_vector(31 downto 0);
		Z 		:	out	std_logic;
		S		:	out std_logic;
		V		:	out	std_logic
		
	);
end alu32;

architecture arch of alu32 is


signal temp_c	: 	std_logic_vector(32 downto 0);
signal temp_o	:	std_logic_vector(31 downto 0);
signal temp_less:	std_logic_vector(31 downto 0);
signal temp_out	:	std_logic_vector(31 downto 0);
signal temp_shift	: std_logic_vector(31 downto 0);
signal sh_en		: std_logic;


begin
	alu: for i in 0 to 30 generate	--generate 32 1-bit adders for alu32 entity
		alu: entity work.alu1 
			port map(
				ia	=> ia(i),
				ib	=> ib(i),	
				less => temp_less(i),
				cout=>	temp_c(i+1),-- Cin will be previous value temp signal 
				cin => temp_c(i),	-- cout will feed into cin
				control => control,
				output => temp_o(i)				
			);
			
	end generate;
	
	alu32: entity work.alu1_last
		port map(
			ia	=> ia(31),
			ib	=> ib(31),	
			less => temp_less(31),
			cout=>	temp_c(32),-- Cin will be previous value temp signal 
			cin => temp_c(31),	-- cout will feed into cin
			control => control,
			slt_en => temp_less(0),
			output => temp_o(31)				
		);
		
	shift: entity work.shifter
		port map(
		ib => ib,
		shdir => shdir,
		shamt => shamt,
		q	=> temp_shift
		);
		
	mux: entity work.mux_gen
		generic map(width => 32)
		port map(
			in0 => temp_o,
			in1 => temp_shift,
			sel => sh_en,
			output => temp_out
			
		);

		
	
	
	
temp_c(0) <= control(2);	-- Set cin to first adder to 0. Leaving it blank will result in an 'X' for sum(0)
C <= temp_c(32);

-- Z flag
Z	<= not (temp_out(31) or temp_out(30) or temp_out(29) or temp_out(28) or temp_out(27) or temp_out(26) or
	 temp_out(25) or temp_out(24) or temp_out(23) or temp_out(22) or temp_out(21) or temp_out(20) or 
	 temp_out(19) or temp_out(18) or temp_out(17) or temp_out(16) or temp_out(15) or temp_out(14) or 
	 temp_out(13) or temp_out(12) or temp_out(11) or temp_out(10) or temp_out(9) or temp_out(8)or 
	 temp_out(7) or temp_out(6) or temp_out(5) or temp_out(4) or temp_out(3) or temp_out(2) or temp_out(1) or
	  temp_out(0)); 

-- S flag 
S	<= temp_out(31);

-- V flag
V	<= (temp_c(32) xor temp_c(31));

-- shift enable 
sh_en <= (not control(3) and not control(2) and control(1) and control(0));

temp_less(31 downto 1) <= (others => '0');

output <= temp_out;


 
end arch;

		
	
	