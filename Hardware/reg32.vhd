library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


ENTITY reg32 IS 
PORT(
    d     :     IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    rst     :   in std_logic;
   en   :   in std_logic;
    clk     :     IN STD_LOGIC; -- clock.
    q     :     OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END reg32;

ARCHITECTURE description OF reg32 IS

BEGIN
    process(clk,rst)
    begin
        
     if rst = '1' then
          q   <= (others => '0');
       elsif (clk = '1' and clk'event) then
          if (en = '1') then
             q <= d;
            end if;
    end if;
      
    end process;
END description;