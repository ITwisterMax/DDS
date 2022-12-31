library ieee;
use ieee.std_logic_1164.all;

entity inv is
	port(
		A: in std_logic;
		nA: out std_logic
	);
end inv;

architecture beh of inv is
	begin
		nA <= not A;
	end;