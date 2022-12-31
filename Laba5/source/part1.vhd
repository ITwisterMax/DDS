library ieee;
use ieee.std_logic_1164.all;

entity part1 is 
	port (
		CLK: in std_logic;
		IP: in std_logic_vector (3 downto 0);
		RST: in std_logic;
		OP: out std_logic_vector (1 downto 0)
	);
end part1;

architecture beh of part1 is
	type states_type is (
		S0, S1, S2, S3, S4
	);

	signal curr: states_type;

	begin
		main: process (CLK, RST) begin
			if RST = '1' then	
				curr <= S0;
			elsif rising_edge(CLK) then
				case curr is
					when S0 =>
						curr <= S1;
					when S1 =>
						if IP = "1101" then	
							curr <= S2;
						end if;
					when S2 =>
						if IP = "1111" then	
							curr <= S3;
						elsif IP = "0001" then	
							curr <= S4;
						end if;
					when S4 =>
						if IP = "1001" then	
							curr <= S2;
						elsif IP="1011" then	
							curr <= S0;
						end if;
					when others =>
						null;
				end case;
			end if;
		end process;

		U2: OP <=
			"00" when (curr = S0) else
			"01" when (curr = S1) else
			"10" when (curr = S2) else
			"11" when (curr = S3) else
			"01" when (curr = S4) else
			"00";
	end beh;
