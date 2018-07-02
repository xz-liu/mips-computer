library ieee;
use ieee.std_logic_1164.all;

entity digtube is 
	generic (wid : integer := 4);
	port(
		clk, reset, en : in std_logic;
		data : in std_logic_vector(wid*4-1 downto 0);
		dt_sel : out std_logic_vector(wid-1 downto 0);
		dt_data : out std_logic_vector(7 downto 0)
);
end digtube;

architecture arch of digtube is

	function decode (code : std_logic_vector--; l : integer; r : integer
	) 
		return std_logic_vector is
	begin
		case code is
			when "0000" => return "00000011";--0
			when "0001" => return "10011111";
			when "0010" => return "00100101";
			when "0011" => return "00001101";
			when "0100" => return "10011001";--4
			when "0101" => return "01001001";
			when "0110" => return "01000001";
			when "0111" => return "00011111";
			when "1000" => return "00000001";--8
			when "1001" => return "00011001";
			when "1010" => return "00010001";
			when "1011" => return "11000001";
			when "1100" => return "01100011";--c
			when "1101" => return "10000101";
			when "1110" => return "01100001";
			when "1111" => return "01110001";
			when others => return "11111110";
		end case;
	end function decode;
	
	type dtarr is array (wid-1 downto 0) of std_logic_vector(7 downto 0);
	signal dt_arr : dtarr;
	
begin
	
	process (en, reset) is
	begin
		if reset = '1' then
		
--			for i in 3 downto 0 loop
--				dt_arr(0) <= "01100011";
--				dt_arr(1) <= "10000101";
--				dt_arr(2) <= "01100001";
--				dt_arr(3) <= "01110001";
--				
--			end loop;

			for i in wid-1 downto 0 loop
				dt_arr(i) <= "00000011";
			end loop;
		elsif en = '1' then

			for i in wid-1 downto 0 loop
				dt_arr(i) <= decode(data(3 + i*4 downto i*4));
			end loop;
			
		end if;
	end process;
	
	process (clk) is
		variable ff : integer range -1 to wid := 0;
		variable counter : integer range 0 to 2500;
	begin

		if clk'event and clk = '1' then
			counter := counter + 1;
			if counter = 2500 then
				counter := 0;
				
				for i in wid-1 downto 0 loop
					if i = ff then dt_sel(i) <= '0';
					else dt_sel(i) <= '1';
					end if;
				end loop;
				
				if ff = wid then ff := -1;
				else dt_data <= dt_arr(ff);
				end if;
				
				ff := ff + 1;
				
			end if;
			
		end if;
		

	end process;
	
end;