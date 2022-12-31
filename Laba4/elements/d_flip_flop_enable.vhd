library ieee;
use ieee.std_logic_1164.ALL;

entity d_flip_flop_enable is 
	port (
		D, CLK, E: in std_logic;
		Q: out std_logic
	);
end d_flip_flop_enable;

architecture beh of d_flip_flop_enable is		   
	signal s: std_logic;

	begin
		process(CLK)
		begin
			if E = '1' then
				if rising_edge(CLK) then
					s <= D;
				end if;					
			end if;
		end process;	
		
		Q <= s;
	end beh;