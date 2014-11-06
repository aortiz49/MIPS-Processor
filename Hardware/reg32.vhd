library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity reg32 is 
port(
    d       :   in  std_logic_vector(31 downto 0);
    rst     :   in  std_logic;
    en      :   in  std_logic;
    clk     :   in  std_logic;  -- clock.
    q       :   out std_logic_vector(31 DOWNTO 0) -- output
);
end reg32
architecture description of reg32 is
begin
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