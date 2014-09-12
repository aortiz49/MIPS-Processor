library ieee;
use ieee.std_logic_1164.all;

entity reg32 is
	port (
		D		:	in  std_logic_vector(31 downto 0);
		clk		:	in	std_logic;
	    wr    	: 	in  std_logic;
	    clr  	: 	in  std_logic;
	    Q 		: 	out std_logic_vector(31 downto 0));
end reg32;

architecture ASYNC_RST of reg32 is
begin  -- ASYNC_RST
  process(clk,clr)
  begin
    if (clr = '0') then      
      Q <= (others => '0');      
    elsif (clk'event and clk='1') then
		if (wr = '1') then 
			Q <= D; 
		else
			null;
		end if;        
    end if;    
  end process;

end ASYNC_RST;


