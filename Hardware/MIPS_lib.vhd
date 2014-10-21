library ieee;
use ieee.std_logic_1164.all;

package MIPS_lib is	
--ALU CONSTANTS-----------------------------------------------------------------------------
    constant F_SUM			: 		std_logic_vector(3 downto 0) := "0010";	-- Add 
    constant F_SUB      	: 		std_logic_vector(3 downto 0) := "0011";	-- Subtract 
    constant F_AND      	: 		std_logic_vector(3 downto 0) := "0000";	-- AND
    constant F_OR	      	: 		std_logic_vector(3 downto 0) := "0001";	-- OR
    constant F_NOR      	: 		std_logic_vector(3 downto 0) := "1100";	-- NOR


	
END MIPS_lib;