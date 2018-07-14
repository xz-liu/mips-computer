library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
	use IEEE.NUMERIC_STD.all;
	use IEEE.std_logic_arith.conv_std_logic_vector;
entity imem is -- instruction/data memory
	port(clk,reset,we:in std_logic;
		a: in STD_LOGIC_VECTOR(31 downto 0);
		wd: in STD_LOGIC_VECTOR(31 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of imem is
			type ramtype is array (127 downto 0) of
				STD_LOGIC_VECTOR(7 downto 0);
			shared variable mem:ramtype;
begin
    process(all) is
			variable init: boolean :=true;
		begin
				if(reset='1')then
mem(0):=		"10001100";--lw $1,60($0)
mem(1):=		"00000001";
mem(2):=		"00000000";
mem(3):=		"00111100";
mem(4):=		"00100000";--addi $2,$1,4
mem(5):=		"00100010";
mem(6):=		"00000000";
mem(7):=		"00000100";
mem(8):=		"00100000";--addi $3,$2,4
mem(9):=		"01000011";
mem(10):=		"00000000";
mem(11):=		"00000100";
mem(12):=		"10001100";--lw $1,0($1)
mem(13):=		"00100001";
mem(14):=		"00000000";
mem(15):=		"00000000";
mem(16):=		"10001100";--lw $2,0($2)
mem(17):=		"01000010";
mem(18):=		"00000000";
mem(19):=		"00000000";
mem(20):=		"10001100";--lw $3,0($3)
mem(21):=		"01100011";
mem(22):=		"00000000";
mem(23):=		"00000000";
mem(24):=		"00100000";--addi $4,$0,0
mem(25):=		"00000100";
mem(26):=		"00000000";
mem(27):=		"00000000";
mem(28):=		"00010000";--beq $4,$3 add_pos
mem(29):=		"10000011";
mem(30):=		"00000000";
mem(31):=		"00000010";
mem(32):=		"00100000";--addi $4,$0,1
mem(33):=		"00000100";
mem(34):=		"00000000";
mem(35):=		"00000001";
mem(36):=		"00010000";--beq $4,$3 sub_pos
mem(37):=		"10000011";
mem(38):=		"00000000";
mem(39):=		"00000010";
mem(40):=		"00000000";--add $5,$1,$2
mem(41):=		"00100010";
mem(42):=		"00101000";
mem(43):=		"00100000";
mem(44):=		"00010000";--beq $0,$0 sav_pos
mem(45):=		"00000000";
mem(46):=		"00000000";
mem(47):=		"00000001";
mem(48):=		"00000000";--sub $5,$1,$2
mem(49):=		"00100010";
mem(50):=		"00101000";
mem(51):=		"00100010";
mem(52):=		"10101100";--sw $5,64($0)
mem(53):=		"00000101";
mem(54):=		"00000000";
mem(55):=		"01000000";
mem(56):=		"00001000";--j 0
mem(57):=		"00000000";
mem(58):=		"00000000";
mem(59):=		"00000000";
mem(60):=		"11111111";--ffff0001
mem(61):=		"11111111";
mem(62):=		"00000000";
mem(63):=		"00000001";
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