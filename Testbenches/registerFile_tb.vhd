library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity registerFile_tb is
end registerFile_tb;

architecture behv of registerFile_tb is

component register_file 
	port ( 
		clk				:   in   	std_logic;
      	data			:   in   	std_logic_vector (31 downto 0);
		reg_write		:	in		std_logic_vector(4 downto 0);
		wr_en			:	in		std_logic;
		reg_read1		:	in 		std_logic_vector(4 downto 0);
		reg_read0		:	in 		std_logic_vector(4 downto 0);
		output1			:	out		std_logic_vector(31 downto 0);
		output0			:	out		std_logic_vector(31 downto 0)
    ); 
end component;


signal	clk				:		std_logic := '0';
signal  data			:       std_logic_vector (31 downto 0);
signal	reg_write		:		std_logic_vector(4 downto 0);
signal 	wr_en			:		std_logic;
signal 	reg_read1		:		std_logic_vector(4 downto 0);
signal 	reg_read0		:		std_logic_vector(4 downto 0);
signal	output1			:		std_logic_vector(31 downto 0);
signal	output0			:		std_logic_vector(31 downto 0);


	
begin
 

reg_bank: register_file 
port map (
	clk => clk, 
	data => data,
	reg_write => reg_write,
	wr_en => wr_en,
	reg_read1 => reg_read1,
	reg_read0 => reg_read0,
	output1 => output1,
	output0 => output0
	);
	 clk <= not clk after 10 ns;
process
begin
reg_read1 <="00";
reg_read0 <="00";

data <= x"EEEEAAAA";
reg_write <= conv_std_logic_vector(9, 5);
wr_en <='1';
wait for 20 ns;


data <= x"BABABABA";
reg_write <= "00000";
wr_en <='1';
wait for 20 ns;

data <= x"00000000";
reg_write <= "00000";
wr_en <='0';
wait for 20 ns;


data <= x"FFFFBABA";
reg_write <= "00000";
wr_en <='1';
wait for 20 ns;


data <= x"55555555";
reg_write <= "00000";
wr_en <='1';
wait for 20 ns;

data <= x"FEEDBEEF";
reg_write <= "00000";
wr_en <='1';
wait for 20 ns;


reg_read1 <="01001";
reg_read0 <="00000";
wr_en <='0';
wait for 20 ns;

reg_read1 <="00000";
reg_read0 <="00000";
wr_en <='0';
wait for 20 ns;






wait;


end process;

end behv;
