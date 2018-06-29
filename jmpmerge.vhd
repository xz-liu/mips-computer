library IEEE; use IEEE.STD_LOGIC_1164.all;

entity jmpmerge is -- two-input multiplexer
    port(instr: in STD_LOGIC_VECTOR(25 downto 0);
        pchi: in STD_LOGIC_VECTOR(3 downto 0);
        y: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of jmpmerge is
begin
	y<= pchi & instr & "00";
end;