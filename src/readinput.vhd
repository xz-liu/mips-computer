library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity readinput is
  port (clk:in std_logic;
    a,b,c,d :in std_logic ;
    we  :out std_logic;
    inputvec:out std_logic_vector(3 downto 0) 
  ) ;
end readinput ; 

architecture arch of readinput is
	signal before:std_logic_vector(3 downto 0):="0000";
	signal current:std_logic_vector(3 downto 0):="0000";
	signal w:std_logic:='0';
begin
    process(all) is 
		variable clk_mul:integer:=0;
		constant clk_max:integer:=5;
	begin
		if(rising_edge(clk))then
			current(3)<=a;
			current(2)<=b;
			current(1)<=c;
			current(0)<=d;	
			if (clk_mul=0) then
				clk_mul:=clk_max;
				before<=current;
			else
				clk_mul:=clk_mul-1;
			end if ;
			-- if((a&b&c&d)=before)then 
			-- 	if(clk_mul=0)then
			-- 		w<='0';
			-- 	else	clk_mul:=clk_mul-1;
			-- 	end if;
			-- else
			-- 	clk_mul:=15;
			-- 	w<='1';
			-- 	before<=current;
			-- end if;
		end if;
	end process;
	inputvec<=before;	
	we<='1';
end;