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
					mem(6):=x"00";
					mem(7):=x"20";--lw $s1,20h($s0)
					mem(8):="00100000";
					mem(9):="00100001";
					mem(10):=x"00";
					mem(11):=x"10";--addi $s1,$s1,10h
					mem(12):="10101100";
					mem(13):="00100001";
					mem(14):="00000000";
					mem(15):="00000000";--sw $s1,0h($s1)
					mem(32):="00000000";
					mem(33):="11111111";
					mem(34):="11111111";
					mem(35):="11111111";--test data
					--mem(3):="";--sw $s2,offset($s0)
				end if;
				
				adr:=to_integer(unsigned(a));
				if(we='1') then
					mem(adr+0)	:=wd(31 downto 24);
					mem(adr+1)	:=wd(23 downto 16);
					mem(adr+2)	:=wd(15 downto 8);
					mem(adr+3)	:=wd(7 downto 0);
				else
					rd <=mem(adr)&mem(adr+1)&mem(adr+2) &mem(adr+3);
				end if;
			end if;
    end process;
end;