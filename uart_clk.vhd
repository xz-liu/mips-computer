library ieee;
use ieee.std_logic_1164.all;

entity uart_clk is
	port(	clk_50m: in std_logic;
			clr: in std_logic;
			bps_start: in std_logic;
			clk_bps: out std_logic);
end uart_clk;

architecture uart_clk_arch of uart_clk is
shared variable count: integer range 0 to 5208 := 0;
begin
	process(clk_50m, clr)
	begin
		if(clr = '1') then
			count := 0;
		elsif(rising_edge(clk_50m)) then
			if((count = 5208) or (bps_start = '0')) then
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	clk_bps <= '1' when count = 2604 else '0';
end uart_clk_arch;