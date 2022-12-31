library ieee;
use ieee.std_logic_1164.all;

entity johnson_counter is generic (n: integer := 8);
	port(
		CLK: in std_logic;
		RST: in std_logic;		
		Qout: out std_logic_vector(0 to n - 1)
	);
end johnson_counter;

architecture beh of johnson_counter is
	signal S: std_logic_vector(0 to n - 1);

	begin
		main: process (CLK, RST) begin
			if RST = '1' then
				S <= (others => '0');
			elsif rising_edge(CLK) then
				S <= not(S(n - 1)) & S(0 to n - 2);
			end if;
		end process;	

		Qout <= S;
	end beh;
