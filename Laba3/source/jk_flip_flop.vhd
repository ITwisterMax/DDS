library ieee;
use ieee.std_logic_1164.all;

entity jk_flip_flop is
	port(
		J: in std_logic;
		K: in std_logic;
		CLK: in std_logic;	
		Q: out std_logic
	);
end jk_flip_flop;

architecture beh of jk_flip_flop is
	signal T: std_logic;
	begin
		process(J, K, CLK) begin
			if rising_edge(CLK) then 
				if (J = '1' and K = '1') then
					T <= not T;
				elsif K = '1' then
					T <= '0';
				elsif J = '1' then
					T <= '1';
				end if; 
			end if;
		end process; 

		Q <= T;
	end beh;
