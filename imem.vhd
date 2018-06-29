library IEEE;
    use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
    use IEEE.NUMERIC_STD.all;
entity imem is -- instruction memory
    port(clk,we:in std_logic;
		a: in STD_LOGIC_VECTOR(5 downto 0);
		wd: in STD_LOGIC_VECTOR(31 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of imem is
begin
    process(clk) is
			type ramtype is array (63 downto 0) of
				STD_LOGIC_VECTOR(31 downto 0);
			variable mem: ramtype;
		begin
			if(rising_edge(clk)) then
				if(we='1') then
					mem(to_integer(unsigned(a))):=wd;
				else
					rd <= mem(to_integer(unsigned(a)));
				end if;
			end if;
		--   mem(0) := x"00000000";
		--   mem(1) := x"10000001";
		--   mem(2) := x"00000000";
		--   mem(3) := x"3c08beff";
		--   mem(4) := x"3508fff8";
		--   mem(5) := x"240900ff";
		--   mem(6) := x"ad090000";
		--   mem(7) := x"3c10be00";
		--   mem(8) := x"240f0000";
		--   mem(9) := x"020f7821";
		--   mem(10) := x"8de90000";
		--   mem(11) := x"8def0004";
		--   mem(12) := x"000f7c00";
		--   mem(13) := x"012f4825";
		--   mem(14) := x"3c08464c";
		--   mem(15) := x"3508457f";
		--   mem(16) := x"11090003";
		--   mem(17) := x"00000000";
		--   mem(18) := x"10000042";
		--   mem(19) := x"00000000";
		--   mem(20) := x"240f0038";
		--   mem(21) := x"020f7821";
		--   mem(22) := x"8df10000";
		--   mem(23) := x"8def0004";
		--   mem(24) := x"000f7c00";
		--   mem(25) := x"022f8825";
		--   mem(26) := x"240f0058";
		--   mem(27) := x"020f7821";
		--   mem(28) := x"8df20000";
		--   mem(29) := x"8def0004";
		--   mem(30) := x"000f7c00";
		--   mem(31) := x"024f9025";
		--   mem(32) := x"3252ffff";
		--   mem(33) := x"240f0030";
		--   mem(34) := x"020f7821";
		--   mem(35) := x"8df30000";
		--   mem(36) := x"8def0004";
		--   mem(37) := x"000f7c00";
		--   mem(38) := x"026f9825";
		--   mem(39) := x"262f0008";
		--   mem(40) := x"000f7840";
		--   mem(41) := x"020f7821";
		--   mem(42) := x"8df40000";
		--   mem(43) := x"8def0004";
		--   mem(44) := x"000f7c00";
		--   mem(45) := x"028fa025";
		--   mem(46) := x"262f0010";
		--   mem(47) := x"000f7840";
		--   mem(48) := x"020f7821";
		--   mem(49) := x"8df50000";
		--   mem(50) := x"8def0004";
		--   mem(51) := x"000f7c00";
		--   mem(52) := x"02afa825";
		--   mem(53) := x"262f0004";
		--   mem(54) := x"000f7840";
		--   mem(55) := x"020f7821";
		--   mem(56) := x"8df60000";
		--   mem(57) := x"8def0004";
		--   mem(58) := x"000f7c00";
		--   mem(59) := x"02cfb025";
		--   mem(60) := x"12800010";
		--   mem(61) := x"00000000";
		--   mem(62) := x"12a0000e";
		--   mem(63) := x"00000000";
        -- read memory
    end process;
end;