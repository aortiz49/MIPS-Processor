library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_lib.all;

entity alu1 is
	port(
		ia		:	in	std_logic;
		ib		:	in	std_logic;
		cout	:	out	std_logic;
		control	:	in	std_logic_vector(3 downto 0);
		output	:	out	std_logic
	);
end alu1;

architecture arch of alu1 is 
	component add1
		port(	
			in1		:	in	std_logic;
			in0		:	in	std_logic;
			cin		:	in	std_logic;
			cout	:	out std_logic;
			sum		:	out	std_logic
		);
	end component;
	
signal invB		:	std_logic;	-- enable signal for output of inverter on ib
signal add_sub	:	std_logic;	-- signal for add/sub enable
signal alu_cin	:	std_logic;	-- carry signal for sub to work
signal alu_sum	:	std_logic;	-- signal for output of adder; input to function mux
signal alu_and	:	std_logic;	-- signal for output of ANDing module 
signal alu_or	:	std_logic;	-- signal for output of ORing module
signal alu_nor	:	std_logic;	-- signal for output of NORing module

begin
add_sub <= control(2);
alu_cin <= control(2);

-- port map the adder within alu. When subtracting, set carry bit [A-B = A+(~B+1)]
	ALU_ADD:	
	add1 port map(ia,invB,alu_cin,cout,alu_sum);	
		
-- mux to select between iB being normal or complemented	
	ALU_NEG:	
	process(iB,add_sub)
	begin
		if(add_sub = '1') then	--sum
			invB <= not iB;
		else
			invB <= iB;	-- sub
		end if;
	end process;
	
-- ANDing module
	alu_and <= ia and ib;

-- ORing module
	alu_or <= ia or ib;

-- NORing module
	alu_nor	<= ia nor ib;

	ALU_SEL:
	process(alu_sum,alu_and,alu_or,alu_nor,control)
	begin
		case control is
			when F_SUM =>
				output <= alu_sum;
			when F_SUB =>
				output <= alu_sum;	-- Same as sum, but this control signal enables add_sub and carry
			when F_AND =>
				output <= alu_and;
			when F_OR =>
				output <= alu_or;
			when F_NOR =>
				output <= alu_nor;
			when others =>
				output <= '0';	-- removes inferred latch warnings
		end case;
								
				
	
	end process;
	
	
	
	
	
	
	
	
		
		
		
		
	
	
	
	

end arch;