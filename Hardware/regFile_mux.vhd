library ieee;
use ieee.std_logic_1164.all;

entity regFile_mux is
	port(
		in31		:	in		std_logic_vector(31 downto 0);
		in30		:	in  	std_logic_vector(31 downto 0);
		in29		:	in		std_logic_vector(31 downto 0);
		in28		:	in 		std_logic_vector(31 downto 0);
		in27		:	in		std_logic_vector(31 downto 0);
		in26		:	in 		std_logic_vector(31 downto 0);
		in25		:	in		std_logic_vector(31 downto 0);
		in24		:	in 		std_logic_vector(31 downto 0);
		in23		:	in		std_logic_vector(31 downto 0);
		in22		:	in 		std_logic_vector(31 downto 0);
		in21		:	in		std_logic_vector(31 downto 0);
		in20		:	in 		std_logic_vector(31 downto 0);
		in19		:	in		std_logic_vector(31 downto 0);
		in18		:	in 		std_logic_vector(31 downto 0);
		in17		:	in		std_logic_vector(31 downto 0);
		in16		:	in 		std_logic_vector(31 downto 0);
		in15		:	in		std_logic_vector(31 downto 0);
		in14		:	in 		std_logic_vector(31 downto 0);
		in13		:	in		std_logic_vector(31 downto 0);
		in12		:	in 		std_logic_vector(31 downto 0);
		in11		:	in		std_logic_vector(31 downto 0);
		in10		:	in 		std_logic_vector(31 downto 0);
		in09		:	in		std_logic_vector(31 downto 0);
		in08		:	in 		std_logic_vector(31 downto 0);
		in07		:	in		std_logic_vector(31 downto 0);
		in06		:	in 		std_logic_vector(31 downto 0);
		in05		:	in		std_logic_vector(31 downto 0);
		in04		:	in 		std_logic_vector(31 downto 0);
		in03		:	in		std_logic_vector(31 downto 0);
		in02		:	in 		std_logic_vector(31 downto 0);
		in01		:	in		std_logic_vector(31 downto 0);
		in00		:	in 		std_logic_vector(31 downto 0);
		sel			:	in		std_logic_vector(4 downto 0);
		output		:	out 	std_logic_vector(31 downto 0)
	);
end regFile_mux;

architecture bhv of regFile_mux is
begin
	process(in31,in30,in29,in28,in27,in26,in25,in24,
			in23,in22,in21,in20,in19,in18,in17,in16,
			in15,in14,in13,in12,in11,in10,in09,in08,
			in07,in06,in05,in04,in03,in02,in01,in00,		
			sel
	)
	
	begin
		case sel is
			when "00000" =>
					output <= in00;
				when "00001" => 
					output <= in01;
				when "00010" =>
					output <= in02;
				when "00011" =>
					output <= in03;
				when "00100" =>
					output <= in04;
				when "00101" =>
					output <= in05;
				when "00110" =>
					output <= in06;
				when "00111" =>
					output <= in07;
				when "01000" =>
					output <= in08;
				when "01001" =>
					output <= in09;
				when "01010" =>
					output <= in10;
				when "01011" =>
					output <= in11;
				when "01100" =>
					output <= in12;
				when "01101" =>
					output <= in13;
				when "01110" =>
					output <= in14;
				when "01111" =>
					output <= in15;
				when "10000" =>
					output <= in16;
				when "10001" =>
					output <= in17;
				when "10010" =>
					output <= in18;
				when "10011" =>
					output <= in19;
				when "10100" =>
					output <= in20;
				when "10101" =>
					output <= in21;
				when "10110" =>
					output <= in22;
				when "10111" =>
					output <= in23;
				when "11000" =>
					output <= in24;
				when "11001" =>
					output <= in25;
				when "11010" =>
					output <= in26;
				when "11011" =>
					output <= in27;
				when "11100" =>
					output <= in28;
				when "11101" =>
					output <= in29;
				when "11110" =>
					output <= in30;
				when "11111" =>
					output <= in31;
				when others =>
					output <= (others => 'X');
			end case;
	end process;
end bhv;

