library IEEE; use IEEE.STD_LOGIC_1164.all;
entity sl2 is -- shift left by 2
    port(a: in STD_LOGIC_VECTOR(31 downto 0);
         y: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of sl2 is
begin
    y <= a(29 downto 0) & "00";
end;