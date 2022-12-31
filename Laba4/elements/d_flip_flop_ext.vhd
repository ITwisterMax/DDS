library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop_ext is
	port(
		CLR: in std_logic;		
		D: in std_logic;
		E: in std_logic;
		CLK: in std_logic;
		Q: out std_logic
	);
end d_flip_flop_ext;

architecture beh of d_flip_flop_ext is
	signal S: std_logic;

	begin
		process(CLR, D, E, CLK)
		begin
			if CLR = '1' then
				S <= '0';		
			elsif E = '1' then
				if rising_edge(CLK) then
					S <= D;	 
				end if;
			end if;
		end process; 

		Q <= S;
	end beh;
