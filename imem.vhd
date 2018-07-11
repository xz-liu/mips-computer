library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
	use IEEE.NUMERIC_STD.all;
	use IEEE.std_logic_arith.conv_std_logic_vector;
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
    process(all) is
			variable init: boolean :=true;
		begin
				if(reset='1')then
					mem(0):=		"10001100";
					mem(1):=		"00000001";
					mem(2):=		"00000000";
					mem(3):=		"00011100";
					mem(4):=		"00100000";
					mem(5):=		"00100010";
					mem(6):=		"00000000";
					mem(7):=		"00000100";
					mem(8):=		"10001100";
					mem(9):=		"00100001";
					mem(10):=		"00000000";
					mem(11):=		"00000000";
					mem(12):=		"10001100";
					mem(13):=		"01000010";
					mem(14):=		"00000000";
					mem(15):=		"00000000";
					mem(16):=		"00000000";
					mem(17):=		"00100010";
					mem(18):=		"00011000";
					mem(19):=		"00100000";
					mem(20):=		"10101100";
					mem(21):=		"00000011";
					mem(22):=		"00000000";
					mem(23):=		"00100000";
					mem(24):=		"00001000";
					mem(25):=		"00000000";
					mem(26):=		"00000000";
					mem(27):=		"00000000";
					mem(28):=		"11111111";
					mem(29):=		"11111111";
					mem(30):=		"00000000";
					mem(31):=		"00000001";
				elsif(rising_edge(clk)) then		
					if(we='1') then
						mem(to_integer(unsigned(a))+0)	:=wd(31 downto 24);
						mem(to_integer(unsigned(a))+1)	:=wd(23 downto 16);
						mem(to_integer(unsigned(a))+2)	:=wd(15 downto 8);
						mem(to_integer(unsigned(a))+3)	:=wd(7 downto 0);
					end if;
				end if;
    end process;
		rd <=mem(to_integer(unsigned(a)))
		&mem(to_integer(unsigned(a))+1)
		&mem(to_integer(unsigned(a))+2) 
		&mem(to_integer(unsigned(a))+3)
		when ((a and x"ffff0000")=x"00000000")
		else                       x"01010101";
		
										
end;