library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity clkslower is
  port (
    clkIN:in std_logic;
    clkOUT:out std_logic
  ) ;
end clkslower ; 

architecture arch of clkslower is
    shared variable clk_cnt:integer:=0;
    signal clk_o:std_logic:='0';
    constant clk_max:integer:=50;--5000000;
begin
    proc : process( all )
    begin
        if(rising_edge(clkIN))then
            if(clk_cnt=clk_max)then
                clk_cnt:=0;
                clk_o<='1';
            else 
                clk_o<='0';
                clk_cnt:=clk_cnt+1;
            end if;
        end if;
    end process ; -- proc
    clkOUT<=clkIN;
end architecture ;