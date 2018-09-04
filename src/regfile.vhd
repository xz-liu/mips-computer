library ieee ;
    use ieee.std_logic_1164.all ;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity regfile is
    port (
        clk 		:in     std_logic;
		we3			:in 	std_logic;
		ra1,ra2,wa3	:in		std_logic_vector(4 downto 0);
		wd3			:in 	std_logic_vector(31 downto 0);
		rd1,rd2		:out	std_logic_vector(31 downto 0)
    ) ;
end regfile ; 

architecture arch of regfile is
	type reg_file is array(31 downto 0)
		of std_logic_vector(31 downto 0);
	signal reg:reg_file;
begin
    process(clk) begin
		if rising_edge(clk) then
            if we3='1' then
                reg(conv_integer(wa3))<=wd3;
			end if;
		end if;
    end process;
	process(ra1,ra2)begin
		if(conv_integer(ra1)=0)then rd1<= x"00000000";
		else rd1<=reg(conv_integer(ra1));
		end if;
		if(conv_integer(ra2)=0)then rd2<= x"00000000";
		else rd2<=reg(conv_integer(ra2));
		end if;
	end process;
end architecture ;