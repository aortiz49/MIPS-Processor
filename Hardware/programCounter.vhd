library ieee;
use ieee.std_logic_1164.all;

entity programCounter is
  port(clk       : in  std_logic;
       rst       : in  std_logic;
       input     : in  std_logic_vector(31 downto 0);
       output    : out std_logic_vector(31 downto 0)
       );
end programCounter;

architecture bhv of programCounter is
begin
  process(clk, rst)
  begin
    if rst = '1' then
      output   <= x"00400000";
  elsif (clk = '1' and clk'event) then
  		output <= input;
    end if;
  end process;
end bhv;

