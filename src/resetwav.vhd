library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity resetwav is
  port (
    clock:in std_logic;
    rst:out std_logic
  ) ;
end resetwav ; 

architecture arch of resetwav is
	shared variable reset:std_logic:='1';
begin
    proc : process( clock )
    begin
        if(rising_edge(clock))then
            if(reset ='1')then
                rst<='1';
                reset:='0';
            else
                rst<='0';
            end if;
        end if;
    end process ; -- proc
end architecture ;