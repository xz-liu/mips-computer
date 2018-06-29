library IEEE; use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity intvec is -- two-input multiplexer
generic(width: integer := 32; int:integer:=0);
    port(y: out STD_LOGIC_VECTOR(width-1 downto 0));
end;
architecture behave of intvec is
begin
	y<=conv_std_logic_vector(int,width);
end;