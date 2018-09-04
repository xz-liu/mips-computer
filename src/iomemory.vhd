library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
	use IEEE.NUMERIC_STD.all;
	use IEEE.std_logic_arith.conv_std_logic_vector;
entity iomemory is -- io buffer memory
	port(clk,wr:in std_logic;
		a: in STD_LOGIC_VECTOR(31 downto 0);
		a8:in std_logic_vector(7 downto 0) ;
		w8:in std_logic_vector(7 downto 0) ;
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of iomemory is
	function minus_ffff (
		org    : in std_logic_vector)
		return std_logic_vector is
	  begin
		return org and x"0000ffff" ;
	  end function minus_ffff;
			type ramtype is array (63 downto 0) of
				STD_LOGIC_VECTOR(7 downto 0);
			shared variable mem:ramtype;
begin
    process(all) is
			variable top_val:integer:=0;
		begin
                if(rising_edge(clk)) then		
                    if(wr='1')then
						mem(to_integer(unsigned(a8))):=w8;
					end if;
				end if;
    end process;
        rd <=mem(to_integer(unsigned(minus_ffff(a))))
                    &mem(to_integer(unsigned(minus_ffff(a)))+1)
                    &mem(to_integer(unsigned(minus_ffff(a)))+2) 
                    &mem(to_integer(unsigned(minus_ffff(a)))+3) 
                    when ((a and x"ffff0000")/=x"00000000")
                    else                       x"01010101";
		
										
end;