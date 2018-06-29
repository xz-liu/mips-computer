library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
    use IEEE.NUMERIC_STD.all;
entity imem is -- instruction memory
    port(clk,we:in std_logic;
		a: in STD_LOGIC_VECTOR(31 downto 0);
		wd: in STD_LOGIC_VECTOR(31 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of imem is
begin
    process(clk) is
			type ramtype is array (63 downto 0) of
				STD_LOGIC_VECTOR(7 downto 0);
			variable mem: ramtype;
			variable init: boolean :=true;
			variable adr : natural;
		begin
			if(rising_edge(clk)) then
			
				if(init)then
					init:=false;
					mem(0):="00000000";
					mem(1):="00000000";
					mem(2):="00000000";
					mem(3):="00100110"; --xor $s0,$s0,$s0
					mem(4):="10001100";
					mem(5):="00000001";
					mem(6):="00000000";
					mem(7):="00010000";--lw $s1,10h($s0)
					mem(8):="00100000";
					mem(9):="01000001";
					mem(10):="00000000";
					mem(11):="00010000";--addi $s2,$s1,10h
					--mem(3):="";--sw $s2,offset($s0)
				end if;
				
				adr:=to_integer(unsigned(a));
				if(we='1') then
					mem(adr)	:=wd(31 downto 24);
					mem(adr+1)	:=wd(23 downto 16);
					mem(adr+2)	:=wd(15 downto 8);
					mem(adr+3)	:=wd(7 downto 0);
				else
					rd <=mem(adr+3)&mem(adr+2)&mem(adr+1) &mem(adr);
				end if;
			end if;
    end process;
end;