library ieee;
use ieee.std_logic_1164.all;

entity and3 is
	port(
		A, B, C: in std_logic;
		Q: out std_logic
	);
end and3;

architecture struct of and3 is

component and2
	port(
		A, B: in std_logic;
		Q: out std_logic
	);
end component;

signal T: std_logic;
begin
	U1: and2 port map(A, B, T);
	U2: and2 port map(C, T, Q);
end struct;