library ieee;
use ieee.std_logic_1164.all;

package MIPS_lib is	
--ALU CONSTANTS-----------------------------------------------------------------------------
    constant F_SUM		: 		std_logic_vector(3 downto 0) 	:=	"0010";		-- Add 
    constant F_SUB      : 		std_logic_vector(3 downto 0) 	:=	"0110";		-- Subtract 
    constant F_AND      : 		std_logic_vector(3 downto 0) 	:=	"0000";		-- AND
    constant F_OR	    : 		std_logic_vector(3 downto 0) 	:=	"0001";		-- OR
    constant F_NOR      : 		std_logic_vector(3 downto 0) 	:=	"1100";		-- NOR
    constant F_SLT		:		std_logic_vector(3 downto 0) 	:=	"0111";		-- Set if less than; signed	
	constant F_SLTU		:		std_logic_vector(3 downto 0) 	:=	"1111";		-- Set if less than; unsigned	
--------------------------------------------------------------------------------------------

--ALU OP------------------------------------------------------------------------------------
	constant LW_SW		:		std_logic_vector(2 downto 0)	:=	"010";		-- add
	constant BEQ		:		std_logic_vector(2 downto 0)	:=	"001";		-- sub
	constant ANDI		:		std_logic_vector(2 downto 0)	:=	"000";		-- and
	constant ORI		:		std_logic_vector(2 downto 0)	:=	"011";		-- or
	constant R_TYPE		:		std_logic_vector(2 downto 0)	:=	"100";		-- R-type (varied)
--------------------------------------------------------------------------------------------

--ALU FUNCT---------------------------------------------------------------------------------
	constant CTRL_ADD	:		std_logic_vector(5 downto 0)	:=	"100000";	-- add
	constant CTRL_SUB	:		std_logic_vector(5 downto 0)	:=	"100010";	-- subtract
	constant CTRL_AND	:		std_logic_vector(5 downto 0)	:=	"100100";	-- and
	constant CTRL_OR	:		std_logic_vector(5 downto 0)	:=	"100101";	-- or
	constant CTRL_NOR	:		std_logic_vector(5 downto 0)	:=	"100111";	-- nor
	constant CTRL_SLT	:		std_logic_vector(5 downto 0)	:=	"101010";	-- slt 
	constant CTRL_SLTU	:		std_logic_vector(5 downto 0)	:=	"101011";	-- sltu 
--------------------------------------------------------------------------------------------

	

	
END MIPS_lib;