library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg32_tb is
end reg32_tb;

architecture TB of reg32_tb is
	component reg32
		port(
		D		:	in  std_logic_vector(31 downto 0);
		clk		:	in	std_logic;
	    wr    	: 	in  std_logic;
	    clr  	: 	in  std_logic;
	    Q 		: 	out std_logic_vector(31 downto 0));
	end component;

signal D		:	std_logic_vector(31 downto 0);
signal clk		:	std_logic := '0';
signal wr		:	std_logic;
signal clr		:	std_logic;
signal Q		:	std_logic_vector(31 downto 0);
signal sim_done : 	std_logic := '0';

begin -- TB
	UUT: entity work.reg32
		port map(
			D => D,
			clk => clk,
			wr => wr,
			clr => clr,
			Q => Q);
			
-- toggle clock
  clk <= not clk after 20 ns when sim_done = '0' else clk;
	
process
begin	
	-- reset
	 D <= x"1234ABCD";  
    wr   <= '1';
    clr  <= '0';
    
    wait until rising_edge(clk);
    assert(Q = std_logic_vector(to_unsigned(0, 32))) report "Clear failed" severity warning;
    
    -- load 1
    D <= x"1234ABCD"; 
    wr   <= '1';
    clr  <= '1';
    
    for i in 0 to 9 loop
      wait until rising_edge(clk);
    end loop;
    assert(Q = std_logic_vector(to_unsigned(305441741, 32))) report "Clear failed" severity warning;
    
    
    -- load 2
    D <= x"ABCD1234"; 
    wr   <= '1';
    clr  <= '1';
    
    for i in 0 to 2 loop
      wait until rising_edge(clk);
    end loop;
    assert(Q = std_logic_vector(to_unsigned(305441741, 32))) report "Clear failed" severity warning;
    
	 clr  <= '1';
    
    report "SIMULATION FINISHED!";
    sim_done <= '1'; 
	
	end process;
end TB;
	    

