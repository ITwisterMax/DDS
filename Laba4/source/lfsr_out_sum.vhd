library ieee;
use ieee.std_logic_1164.all;

entity lfsr_out_sum is generic (n: integer := 4; init: std_logic_vector := "1111");	
	port(
		CLK: in std_logic;
		RST: in std_logic;		
		State: out std_logic_vector(0 to n - 1);
		Qout: out std_logic
	);	 
end lfsr_out_sum;

architecture beh of lfsr_out_sum is	
	signal S: std_logic_vector(0 to n - 1) := init;

	begin
		main: process (CLK, RST) begin
			if RST = '1' then
				S <= init;
			elsif rising_edge(CLK) then			
				S <= (S(0) xor S(n - 1)) & S(0 to n - 2);
			end if;
		end process;	
		
		Qout <= S(n - 1);
		State <= S;
	end beh;
