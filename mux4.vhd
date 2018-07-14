library IEEE; use IEEE.STD_LOGIC_1164.all;
entity mux4 is -- four-input multiplexer
generic(width: integer := 32);
    port(d0, d1,d2,d3: in STD_LOGIC_VECTOR(width-1 downto 0);
        s: in STD_LOGIC_VECTOR(1 downto 0);
        y: out STD_LOGIC_VECTOR(width-1 downto 0));
end;
architecture behave of mux4 is
begin
	with s select 
		y <= d0 when "00",
			 d1 when "01",
			 d2 when "10",
			 d3 when "11";
end;