
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity add1 is
	port(	
		in1		:	in	std_logic;
		in0		:	in	std_logic;
		cin		:	in	std_logic;
		cout		:	out std_logic;
		sum		:	out	std_logic
	);
end add1;


architecture bhv of add1 is
begin	
	 sum <= in1 xor in0 xor cin;
	 cout <= (in1 and in0) or (cin and in1) or (cin and in0);
end bhv;
