library ieee;
use ieee.std_logic_1164.all;

entity rs_flip_flop is
	port(
		R: in std_logic;
		S: in std_logic;
		CLK: in std_logic;	
		Q: out std_logic
	);
end rs_flip_flop;

architecture beh of rs_flip_flop is
	signal T: std_logic;
	begin
		process(R, S, CLK) begin
			if rising_edge(CLK) then
				if (R = '1' and S = '1') then
					T <= 'Z';
				elsif R = '1' then
					T <= '0';
				elsif S = '1' then
					T <= '1';
				end if;
			end if;
		end process;

		Q <= T;
	end beh;