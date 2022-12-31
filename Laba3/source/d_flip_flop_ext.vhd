library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop_ext is
	port(
		CLR: in std_logic;
		PRE: in std_logic;
		D: in std_logic;
		E: in std_logic;
		CLK: in std_logic;	
		Q: out std_logic
	);
end d_flip_flop_ext;

architecture beh of d_flip_flop_ext is
	signal T: std_logic;
	begin
		process(CLR, PRE, D, E, CLK) begin
			if CLR = '1' then
				T <= '0';
			elsif PRE = '1' then
				T <= '1';
			elsif E = '1' then
				if rising_edge(CLK) then
					T <= D;
				end if;
			end if;
		end process; 

		Q <= T;
	end beh;
