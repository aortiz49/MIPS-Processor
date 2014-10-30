library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_lib.all;

entity alu1_last is
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
end alu1_last;

architecture arch of alu1_last is 
	component add1
		port(	
			in1		:	in	std_logic;
			in0		:	in	std_logic;
			cin		:	in	std_logic;
			cout	:	out std_logic;
			sum		:	out	std_logic
		);
	end component;
---	
	component mux1		-- Negate mux
		port(
			in0		:	in	std_logic;
			in1		:	in 	std_logic;
			sel		:	in	std_logic;
			output	:	out std_logic
	);		
end component;

---
	component alu_mux
	port(
		control		:	in std_logic_vector(3 downto 0);
		sum_in		:	in	std_logic;
		sub_in		:	in	std_logic;
		and_in		:	in	std_logic;
		or_in		:	in	std_logic;
		nor_in		:	in	std_logic;
		slt_in		:	in std_logic;
		sltu_in		:	in	std_logic;
		mux_out		:	out	std_logic	
	);
	end component;

signal invB		:	std_logic;	-- inverted iB signal
signal newB		:	std_logic;	-- output of B mux
signal add_sub	:	std_logic;	-- add/sub enable (mux sel)
signal alu_sum	:	std_logic;	-- output of adder; input to function mux
signal alu_and	:	std_logic;	-- output of ANDing module 
signal alu_or	:	std_logic;	-- output of ORing module
signal alu_nor	:	std_logic;	-- output of NORing module
signal alu_slt	:	std_logic;	-- set if less than (unsigned) signal
signal alu_sltu	:	std_logic;	-- set if less than (unsigned) signal
signal cout_t	:	std_logic;	


begin
	add_sub <= control(2);	-- mux sel for add/sub
	
-- ANDing module
	alu_and <= ia and ib;

-- ORing module
	alu_or <= ia or ib;

-- NORing module
	alu_nor	<= ia nor ib;

-- port map the adder within alu. When subtracting, set carry bit [A-B = A+(~B+1)]
	ALU_ADD:	
	add1 port map(ia,newB,cin,cout_t,alu_sum);	
		
-- mux to select between iB being normal or complemented	
	invB <= not iB;
	ALU_NEG:
	mux1 port map(iB,invB,add_sub,newB);
	
-- port map the mux to select between different operations
	ALU_FUNCT:
	alu_mux port map(control,alu_sum,alu_sum,alu_and,alu_or,alu_nor,alu_slt,alu_sltu,output);

	ALU_LESS:
	mux1 port map(alu_sum,"not"(cout_t),control(3),slt_en);

-- signal for slt mux input
alu_slt <= less; 
	
-- signal for sltu mux input
alu_sltu <= less; 

-- cout output
cout	<=	cout_t;
end arch;