library ieee;
use ieee.std_logic_1164.all;

entity uart_rx is
	port(	clk_50m: in std_logic;
			clr: in std_logic;
			clk_bps: in std_logic;
			rxd: in std_logic;
			bps_start: out std_logic;
			wr: out std_logic := '0';
			addr: out std_logic_vector(7 downto 0);
			ram_in: out std_logic_vector(7 downto 0));
end uart_rx;

architecture uart_rx_arch of uart_rx is
signal temp: std_logic_vector(3 downto 0) := "0000";
signal rx_active: std_logic;
signal num: integer range 0 to 9 := 0;
shared variable count: integer range 0 to 10000000 := 0;
begin
	process(clk_50m, clr)
	begin
		if(clr = '1') then
			temp <= "0000";
		elsif(rising_edge(clk_50m)) then
			temp <= temp(2 downto 0) & rxd;
		end if;
	end process;
	rx_active <= '1' when temp = "1100" else '0';
	process(clk_50m, clr)
	begin
		if(clr = '1') then
			bps_start <= '0';
		elsif(rising_edge(clk_50m)) then
			if(rx_active = '1') then
				bps_start <= '1';
			elsif((clk_bps = '1') and (num = 9)) then
				bps_start <= '0';
			end if;
		end if;
	end process;
	process(clk_50m, clr)
	begin
		if(clr = '1') then
			num <= 0;
			count := 0;
			addr <= x"00";
			ram_in <= x"00";
		elsif(rising_edge(clk_50m)) then
			if(clk_bps = '1') then
				if(num = 9) then
					num <= 0;
				else
					num <= num + 1;
				end if;
				if(count <= 9) then
					case num is 
						when 1 => addr(0) <= rxd;
						when 2 => addr(1) <= rxd;
						when 3 => addr(2) <= rxd;
						when 4 => addr(3) <= rxd;
						when 5 => addr(4) <= rxd;
						when 6 => addr(5) <= rxd;
						when 7 => addr(6) <= rxd;
						when 8 => addr(7) <= rxd;
						when others => null;
					end case;
				elsif(count <= 19) then
					case num is
						when 1 => ram_in(0) <= rxd;
						when 2 => ram_in(1) <= rxd;
						when 3 => ram_in(2) <= rxd;
						when 4 => ram_in(3) <= rxd;
						when 5 => ram_in(4) <= rxd;
						when 6 => ram_in(5) <= rxd;
						when 7 => ram_in(6) <= rxd;
						when 8 => ram_in(7) <= rxd;
						when others => null;
					end case;
				end if;
				count := count + 1;
			end if;
			if(count >= 20) then
				count := count + 1;
			end if;
			if(count = 10000000) then
				count := 0;
			end if;
		end if;
	end process;
	wr <= '1' when (count > 20) and (count < 10000000) else '0';
end uart_rx_arch;