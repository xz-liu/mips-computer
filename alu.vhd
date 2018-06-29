library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
	use ieee.std_logic_unsigned.all;

entity alu is
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
        alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
        result: buffer STD_LOGIC_VECTOR(31 downto 0);
        zero: out STD_LOGIC);
end alu ; 

architecture arch of alu is
    -- when "100000" => alucontrol <= "010"; -- add
    -- when "100010" => alucontrol <= "110"; -- sub
    -- when "100100" => alucontrol <= "000"; -- and
    -- when "100101" => alucontrol <= "001"; -- or
    -- when "101010" => alucontrol <= "111"; -- slt
begin
	with alucontrol select
        result <= a + b when "010",
				  a - b when "110",
        		  a and b when "000",
        		  a or b when "001",
        		  a-b when "111" ,
				  a when others;
	zero<= '1' when result =x"00000000"	 else '0';

end architecture ;