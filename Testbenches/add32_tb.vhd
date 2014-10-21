library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity add32_tb is
end add32_tb;

architecture TB of add32_tb is
	component add32
	port(
		in1		:	in	std_logic_vector(31 downto 0);
		in0		:	in	std_logic_vector(31 downto 0);
		cin		:	in 	std_logic;
		cout	:	out std_logic;
		sum		:	out	std_logic_vector(31 downto 0)
	);
	end component;

signal in1		:	std_logic_vector(31 downto 0);
signal in0		:	std_logic_vector(31 downto 0);
signal sum		:	std_logic_vector(31 downto 0);
signal cin		:  	std_logic;
signal cout 	:   std_logic;

begin -- TB
	UUT: entity work.add32
		port map(
			in1 => in1,
			in0 => in0,
			cin => cin,
			cout => cout,
			sum => sum
			);
		
	
process
begin	
	
-- test two positive numbers
	cin <= '0';
    in1 <= conv_std_logic_vector(1234, in1'length);
    in0 <= conv_std_logic_vector(4321, in0'length);
    wait for 20 ns;

-- test 2 negatve nums	 
	  in1 <= conv_std_logic_vector(-500, in1'length);
    in0 <= conv_std_logic_vector(-250, in0'length);
	 wait for 20 ns;
--test one + and one -	 
	  in1 <= conv_std_logic_vector(2048, in1'length);
   	  in0 <= conv_std_logic_vector(-1000, in0'length);
		wait for 20 ns;
-- oth unsigned		
		 in1 <= conv_std_logic_vector(5000, in1'length);
   	  in0 <= conv_std_logic_vector(1000, in0'length);
		wait for 20 ns;
		
-- oth FFFF
 in1 <= x"FFFFFFFF";
    in0 <= x"FFFFFFFF";
		wait for 20 ns;
		
--oth are 0		
		 in1 <= x"00000000";
    in0 <= x"00000000";
		wait for 20 ns;
		
		
-- oth are 80 80
 		 in1 <= x"80000000";
    in0 <= x"80000000";
		wait for 20 ns;		
	 wait;
	 
	end process;
end TB;
	    

