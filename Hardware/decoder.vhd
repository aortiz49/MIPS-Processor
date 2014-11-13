library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity decoder is 
	port(
		enable			:	in		std_logic_vector(4 downto 0);
		wr_en			:	in		std_logic;
		decode_out		:	out		std_logic_vector(31 downto 0)		
	);
end entity;

architecture BHV of decoder is
begin
	process(wr_en, enable)
	begin	
		if(wr_en = '1' ) then
			case enable is
				when "00000" =>
					decode_out <= "00000000000000000000000000000001";
				when "00001" => 
					decode_out <= "00000000000000000000000000000010";
				when "00010" =>
					decode_out <= "00000000000000000000000000000100";
				when "00011" =>
					decode_out <= "00000000000000000000000000001000";
				when "00100" =>
					decode_out <= "00000000000000000000000000010000";
				when "00101" =>
					decode_out <= "00000000000000000000000000100000";
				when "00110" =>
					decode_out <= "00000000000000000000000001000000";
				when "00111" =>
					decode_out <= "00000000000000000000000010000000";
				when "01000" =>
					decode_out <= "00000000000000000000000100000000";
				when "01001" =>
					decode_out <= "00000000000000000000001000000000";
				when "01010" =>
					decode_out <= "00000000000000000000010000000000";
				when "01011" =>
					decode_out <= "00000000000000000000100000000000";
				when "01100" =>
					decode_out <= "00000000000000000001000000000000";
				when "01101" =>
					decode_out <= "00000000000000000010000000000000";
				when "01110" =>
					decode_out <= "00000000000000000100000000000000";
				when "01111" =>
					decode_out <= "00000000000000001000000000000000";
				when "10000" =>
					decode_out <= "00000000000000010000000000000000";
				when "10001" =>
					decode_out <= "00000000000000100000000000000000";
				when "10010" =>
					decode_out <= "00000000000001000000000000000000";
				when "10011" =>
					decode_out <= "00000000000010000000000000000000";
				when "10100" =>
					decode_out <= "00000000000100000000000000000000";
				when "10101" =>
					decode_out <= "00000000001000000000000000000000";
				when "10110" =>
					decode_out <= "00000000010000000000000000000000";
				when "10111" =>
					decode_out <= "00000000100000000000000000000000";
				when "11000" =>
					decode_out <= "00000001000000000000000000000000";
				when "11001" =>
					decode_out <= "00000010000000000000000000000000";
				when "11010" =>
					decode_out <= "00000100000000000000000000000000";
				when "11011" =>
					decode_out <= "00001000000000000000000000000000";
				when "11100" =>
					decode_out <= "00010000000000000000000000000000";
				when "11101" =>
					decode_out <= "00100000000000000000000000000000";
				when "11110" =>
					decode_out <= "01000000000000000000000000000000";
				when others =>
					decode_out <= "10000000000000000000000000000000";
			end case;
		else
			decode_out <= "00000000000000000000000000000000";			
		end if;
	end process;
end BHV;
	
		
		
		