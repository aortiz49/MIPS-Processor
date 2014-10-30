library ieee;
use ieee.std_logic_1164.all;

package MIPS_lib is	
--ALU CONSTANTS-----------------------------------------------------------------------------
    constant 	F_SUM		: 		std_logic_vector(3 downto 0) 	:=	"0010";		-- Add 
    constant 	F_SUB      	: 		std_logic_vector(3 downto 0) 	:=	"0110";		-- Subtract 
    constant 	F_AND      	: 		std_logic_vector(3 downto 0) 	:=	"0000";		-- AND
    constant 	F_OR	    : 		std_logic_vector(3 downto 0) 	:=	"0001";		-- OR
    constant 	F_NOR      	: 		std_logic_vector(3 downto 0) 	:=	"1100";		-- NOR
    constant 	F_SLT		:		std_logic_vector(3 downto 0) 	:=	"0111";		-- Set if less than; signed	
	constant 	F_SLTU		:		std_logic_vector(3 downto 0) 	:=	"1111";		-- Set if less than; unsigned	
	constant 	F_SHFT		:		std_logic_vector(3 downto 0) 	:= 	"0011";		-- shift
--------------------------------------------------------------------------------------------

--ALU OP------------------------------------------------------------------------------------
	constant 	ADD			:		std_logic_vector(2 downto 0)	:=	"000";		-- add
	constant 	BEQ			:		std_logic_vector(2 downto 0)	:=	"001";		-- sub
	constant 	ANDI		:		std_logic_vector(2 downto 0)	:=	"010";		-- and
	constant 	ORI			:		std_logic_vector(2 downto 0)	:=	"011";		-- or
	constant	LUI			:		std_logic_vector(2 downto 0)	:=  "101";		-- shift
	constant 	R_TYPE		:		std_logic_vector(2 downto 0)	:=	"100";		-- R-type (varied)
	constant 	SLTI		:		std_logic_vector(2 downto 0)	:=	"110";		-- slti
	constant 	SLTIU		:		std_logic_vector(2 downto 0)	:=	"111";		-- sltiu
	
--------------------------------------------------------------------------------------------

--ALU FUNCT---------------------------------------------------------------------------------
	constant 	CTRL_ADD	:		std_logic_vector(5 downto 0)	:=	"100000";	-- add
	constant 	CTRL_ADDU	:		std_logic_vector(5 downto 0)	:=	"100001";	-- addu
	constant 	CTRL_SUB	:		std_logic_vector(5 downto 0)	:=	"100010";	-- subtract
	constant 	CTRL_AND	:		std_logic_vector(5 downto 0)	:=	"100100";	-- and
	constant 	CTRL_OR		:		std_logic_vector(5 downto 0)	:=	"100101";	-- or
	constant 	CTRL_NOR	:		std_logic_vector(5 downto 0)	:=	"100111";	-- nor
	constant 	CTRL_SLT	:		std_logic_vector(5 downto 0)	:=	"101010";	-- slt 
	constant	CTRL_SLL	:		std_logic_vector(5 downto 0)	:=	"000000";	-- sll
	constant	CTRL_SRL	:		std_logic_vector(5 downto 0)	:=	"000010";	-- srl
	constant 	CTRL_SLTU	:		std_logic_vector(5 downto 0)	:=	"101011";	-- sltu 
--------------------------------------------------------------------------------------------

--INSTRUCTIONS------------------------------------------------------------------------------
	constant	OPC_LUI		:		std_logic_vector(5 downto 0)	:=	"001111";	-- lui 
	constant	OPC_ANDI	:		std_logic_vector(5 downto 0)	:=	"001100";	-- andi
	constant	OPC_ORI		:		std_logic_vector(5 downto 0)	:=	"001101";	-- ori	
	constant	OPC_SLTI	:		std_logic_vector(5 downto 0)	:=	"001010";	-- slti
	constant	OPC_SLTIU	:		std_logic_vector(5 downto 0)	:=	"001011";	-- sltiu
	constant	OPC_ADDI	:		std_logic_vector(5 downto 0)	:=	"001000";	-- addi
	constant	OPC_ADDIU	:		std_logic_vector(5 downto 0)	:=	"001001";	-- addiu	
	constant	OPC_R		:		std_logic_vector(5 downto 0)	:=	"000000";	-- r-types

	
END MIPS_lib;