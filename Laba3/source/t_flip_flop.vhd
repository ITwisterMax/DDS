library ieee;
use ieee.std_logic_1164.all;

entity t_flip_flop is
	port(
		T: in std_logic;		
		CLK: in std_logic;	
		Q: out std_logic;
		CLR: in std_logic
	);
end t_flip_flop;

architecture beh of t_flip_flop is
	signal S: std_logic;
	begin
		process(T, CLK, CLR) begin
			if CLR = '1' then
				S <= '0';
			elsif T = '1' then
				if rising_edge(CLK) then
					S <= not S;
				end if;
			end if;
		end process;

		Q <= S;
	end beh;
