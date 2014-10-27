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
	component alu1
	port(
		ia		:	in	std_logic;
		ib		:	in	std_logic;
		less	:	in	std_logic;
		cout	:	out	std_logic;
		cin		:	in 	std_logic;
		control	:	in	std_logic_vector(3 downto 0);
		output	:	out	std_logic
	);
	end component;

	component alu1_last
		port(
			ia		:	in	std_logic;
			ib		:	in	std_logic;
			less	:	in	std_logic;
			cout	:	out	std_logic;
			cin		:	in 	std_logic;
			control	:	in	std_logic_vector(3 downto 0);
			slt_en	:	out	std_logic;
			output	:	out	std_logic
		);
	end component;
	
	component shifter
		port( 
			ib				: in std_logic_vector(31 downto 0);
			shdir			: in std_logic;
			shamt			: in std_logic_vector(4 downto 0);
			q				: out std_logic_vector(31 downto 0)
			);
	end component;
	
	component mux32
	port(
		in0		:	in	std_logic_vector(31 downto 0);
		in1		:	in std_logic_vector(31 downto 0);
		sel		:	in	std_logic;
		output	:	out std_logic_vector(31 downto 0)
	);
	end component;

signal temp_c	: 	std_logic_vector(32 downto 0);
signal temp_o	:	std_logic_vector(31 downto 0);
signal temp_less:	std_logic_vector(31 downto 0);
signal temp_ib	:	std_logic_vector(31 downto 0);
signal temp_shift	: std_logic_vector(31 downto 0);
signal sh_en		: std_logic;


begin
	alu: for i in 0 to 30 generate	--generate 32 1-bit adders for alu32 entity
		alu: alu1 
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
	
	alu32: alu1_last
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
		
	shift: shifter
		port map(
		ib => ib,
		shdir => shdir,
		shamt => shamt,
		q	=> temp_shift
		);
		
	mux: mux32
		port map(
			in0 => temp_o,
			in1 => temp_shift,
			sel => sh_en,
			output => output
			
		);

		
	
	
	
temp_c(0) <= control(2);	-- Set cin to first adder to 0. Leaving it blank will result in an 'X' for sum(0)
C <= temp_c(32);

-- Z flag
Z	<= not (temp_o(31) or temp_o(30) or temp_o(29) or temp_o(28) or temp_o(27) or temp_o(26) or temp_o(25) or temp_o(24) or temp_o(23) or temp_o(22) or temp_o(21) or temp_o(20) or temp_o(19) or temp_o(18) or temp_o(17) or temp_o(16) or temp_o(15) or temp_o(14) or temp_o(13) or temp_o(12) or temp_o(11) or temp_o(10) or temp_o(9) or temp_o(8)or temp_o(7) or temp_o(6) or temp_o(29) or temp_o(28) or temp_o(27) or temp_o(26) or temp_o(25) or temp_o(24)
or temp_o(5) or temp_o(4) or temp_o(3) or temp_o(2) or temp_o(1) or temp_o(0)); 

-- S flag 
S	<= temp_o(31);

-- V flag
V	<= (temp_c(32) xor temp_c(31));

-- shift enable 
sh_en <= (not control(3) and not control(2) and control(1) and control(0));



temp_less(31 downto 1) <= (others => '0');




 
end arch;

		
	
	