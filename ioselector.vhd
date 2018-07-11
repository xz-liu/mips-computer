library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ioselector is
  port (
    adr     :in std_logic_vector(31 downto 0) ;
    wd1,wd2 :in std_logic_vector(31 downto 0) ;
    wdf     :out std_logic_vector(31 downto 0) 
  ) ;
end ioselector ; 

architecture arch of ioselector is

begin
    wdf<= wd1 when ((adr and x"FFFF0000") = x"00000000")
        else wd2;   
end architecture ;