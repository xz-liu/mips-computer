library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mux2_sl is
  port (
    d0,d1:in std_logic;
    s:in std_logic ;
    y:out std_logic
  ) ;
end mux2_sl ; 

architecture arch of mux2_sl is

begin
    y <= d1 when s = '1' else d0;
end architecture ;