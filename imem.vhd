library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
    use IEEE.NUMERIC_STD.all;
entity imem is -- instruction memory
    port(clk,reset,we:in std_logic;
		a: in STD_LOGIC_VECTOR(31 downto 0);
		wd: in STD_LOGIC_VECTOR(31 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of imem is
			type ramtype is array (63 downto 0) of
				STD_LOGIC_VECTOR(7 downto 0);
			shared variable mem:ramtype;
begin
    process(clk,a) is
			variable init: boolean :=true;
		begin
				if(reset='1')then						
						mem(0):="00001000";
						mem(1):=x"00";
						mem(2):=x"00";
						mem(3):=x"03"; --j 3
						
						mem(12):="00000000";
						mem(13):="00000000";
						mem(14):="00001000";
						mem(15):="00100110";	 --xor $1,$0,$0
						mem(16):="10001100";
						mem(17):="00000001";
						mem(18):=x"00";
						mem(19):=x"2A";			--lw $1,2Ah($0)
						mem(20):="00100000";
						mem(21):="00100001";
						mem(22):=x"00";
						mem(23):=x"02";			--addi $1,$1,02h
						mem(24):="10101100";
						mem(25):="00000001";
						mem(26):=x"00";
						mem(27):=x"2A";			--sw $1,2Ah($s0)
						mem(28):="10001100";
						mem(29):="00000010";
						mem(30):=x"00";
						mem(31):=x"30";			--lw $2,30h($0)
						mem(32):="00000000";
						mem(33):="00100010";
						mem(34):="00011000";
						mem(35):="00100101"; --or $3,$1,$2
										
						
						mem(42):="11111111";
						mem(43):="11111111";	--test data (2Ah)
						mem(44):="00000000";
						mem(45):="00000000";
						
						mem(48):="00000000";
						mem(49):="00000000";
						mem(50):="00000000";
						mem(51):="11111111";	--test data (30h)
				elsif(rising_edge(clk)) then		
					if(we='1') then
						mem(to_integer(unsigned(a))+0)	:=wd(31 downto 24);
						mem(to_integer(unsigned(a))+1)	:=wd(23 downto 16);
						mem(to_integer(unsigned(a))+2)	:=wd(15 downto 8);
						mem(to_integer(unsigned(a))+3)	:=wd(7 downto 0);
					end if;
				end if;
    end process;
		rd <=mem(to_integer(unsigned(a)))&mem(to_integer(unsigned(a))+1)&mem(to_integer(unsigned(a))+2) &mem(to_integer(unsigned(a))+3);
end;