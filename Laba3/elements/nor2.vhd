library ieee;
use ieee.std_logic_1164.all;

entity nor2 is
	port(
		A, B: in std_logic;
		Q: out std_logic
	);
end nor2;

architecture beh of nor2 is
	begin
		Q <= A nor B;
	end;

architecture param of nor2 is
	begin
		Q <= A nor B after 4 ps;
	end;
