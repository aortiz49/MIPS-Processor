library ieee;
use ieee.std_logic_1164.all;

entity zeroReg is
  port(
  	clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    input     : in  std_logic_vector(31 downto 0);
    output    : out std_logic_vector(31 downto 0)
  );
end zeroReg;

architecture bhv of zeroReg is
begin
  process(clk, rst)
  begin
    if rst = '1' then
      output   <= (others => '0');
    elsif (clk = '1' and clk'event) then
      if (en = '1') then
        output <= input;
      end if;
    end if;
  end process;
end bhv;
