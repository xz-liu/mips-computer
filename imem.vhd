library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
    use IEEE.NUMERIC_STD.all;
entity imem is -- instruction memory
    port(clk,we:in std_logic;
		a: in STD_LOGIC_VECTOR(5 downto 0);
		wd: in STD_LOGIC_VECTOR(31 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of imem is
begin
    process(clk) is
			type ramtype is array (63 downto 0) of
				STD_LOGIC_VECTOR(31 downto 0);
			variable mem: ramtype;
			variable init: boolean :=true;
		begin
			if(init)then
				init:=false;
			
			end if;
			if(rising_edge(clk)) then
				if(we='1') then
					mem(to_integer(unsigned(a))):=wd;
				else
					rd <= mem(to_integer(unsigned(a)));
				end if;
			end if;
    end process;
end;