library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
    use IEEE.NUMERIC_STD.all;
entity dmem is -- data memory
    port(clk, we: in STD_LOGIC;
        a, wd: in STD_LOGIC_VECTOR (31 downto 0);
        rd: out STD_LOGIC_VECTOR (31 downto 0));
end;
architecture behave of dmem is
	signal sel :natural;
begin
    sel<= to_integer(unsigned(a(7 downto 2)));
    process(clk,a) is
        type ramtype is array (63 downto 0) of
            STD_LOGIC_VECTOR(31 downto 0);
        variable mem: ramtype;
        begin
        -- read or write memory
            if rising_edge(clk) then
                if (we='1') then mem (sel):= wd;
                end if;
            end if;
			rd <= mem (sel);
    end process;
end;