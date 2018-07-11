library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity outputctrl is
  port (
    adr:in std_logic_vector(31 downto 0) ;
    wi:in std_logic;
    we :out std_logic
  ) ;
end outputctrl ; 

architecture arch of outputctrl is

begin
    we<='1'when((wi='1') and (adr >= x"FFFF0000"))
        else '0';
end architecture ;