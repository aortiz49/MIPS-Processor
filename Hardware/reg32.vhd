library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


ENTITY reg32 IS 
PORT(
    d     :     IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   en   :   in std_logic;
    clk     :     IN STD_LOGIC; -- clock.
    q     :     OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END reg32;

ARCHITECTURE description OF reg32 IS

BEGIN
    process(clk)
    begin
        
      if rising_edge(clk) then
        if (en = '1') then 
                q <= d;
            end if;
      end if;
      
    end process;
END description;