library IEEE; use IEEE.STD_LOGIC_1164.all;
entity aludec is -- ALU control decoder
    port(funct: in STD_LOGIC_VECTOR(5 downto 0);
        aluop: in STD_LOGIC_VECTOR(1 downto 0);
        alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
end;
architecture behave of aludec is
begin
    process(all) begin
        case aluop is
        when "00" => alucontrol <= "010"; -- add (for 1w/sw/addi)
        when "01" => alucontrol <= "110"; -- sub (for beq)
        when others => 
            case funct is -- R-type instructions
                when "100000" => alucontrol <= "010"; -- add
                when "100010" => alucontrol <= "110"; -- sub
                when "100100" => alucontrol <= "000"; -- and
                when "100101" => alucontrol <= "001"; -- or
                when "101010" => alucontrol <= "111"; -- slt
				when "100110" => alucontrol <= "011"; -- xor
                when others => alucontrol <= "---"; -- ???
            end case;
        end case;
    end process;
end;