library IEEE; use IEEE.STD_LOGIC_1164.all;

entity beqctrl is -- two-input multiplexer
    port(zero,branch,pcwrite:in std_logic;
		pcen				:out std_logic
	);
end;
architecture behave of beqctrl is
begin
	pcen<=(zero and branch) or pcwrite;
end;