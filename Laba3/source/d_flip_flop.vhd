library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is
	port (
		D, CLK: in std_logic;
		Q: out std_logic
	);
end d_flip_flop;

architecture beh of d_flip_flop is
	signal T: std_logic;
	begin
		process(CLK) begin
			if rising_edge(CLK) then
				T <= D;
			end if;
		end process;

		Q <= T;
	end beh;
