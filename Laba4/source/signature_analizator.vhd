library ieee;
use ieee.std_logic_1164.all;

entity signature_analizator is generic (n: integer := 4);	
	port(
		CLK: in std_logic;
		RST: in std_logic;
		Pin: in std_logic;
		State: out std_logic_vector(0 to n - 1);
		Qout: out std_logic
	);	 
	constant init: std_logic_vector(0 to n - 1) := (others => '0');
end signature_analizator;

architecture beh of signature_analizator is	
	signal S: std_logic_vector(0 to n - 1) := init;

	begin
		main: process (CLK, RST) begin
			if RST = '1' then
				S <= init;
			elsif rising_edge(CLK) then			
				S <= (S(n - 1) xor Pin) & (S(0) xor S(n - 1)) & S(1 to n - 2);			
			end if;
		end process;	

		Qout <= S(n - 1);
		State <= S;
	end beh;
