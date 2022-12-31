library ieee;
use ieee.std_logic_1164.all;

entity bistable is
	port(
		Q: out std_logic;
		nQ: out std_logic
	);
end bistable;

architecture uninit_bistable of bistable is
	component inv
		port (
			A: in std_logic;
			nA: out std_logic
		);
	end component;

	signal T1: std_logic;
	signal T2: std_logic;
	begin
		U1: inv port map (A => T2, nA => T1);
		U2: inv port map (A => T1, nA => T2);
		nQ <= T1;
		Q <= T2;
	end uninit_bistable;

architecture init_bistable of bistable is
	component inv
		port (
			A: in std_logic;
			nA: out std_logic
		);
	end component;

	signal T1: std_logic;
	signal T2: std_logic := '1';
	begin
		U1: inv port map (A => T2, nA => T1);
		U2: inv port map (A => T1, nA => Q);
		nQ <= T1;
	end init_bistable;
