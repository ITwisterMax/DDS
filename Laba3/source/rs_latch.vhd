library ieee;
use ieee.std_logic_1164.all;

entity rs_latch is
	port (
		R, S: in std_logic;
		Q, nQ: out std_logic
	);
end rs_latch;

architecture struct of rs_latch is
	component nor2 is
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	signal T1, T2: std_logic;
	begin
		U2: entity work.nor2(param) port map (A => R, B => t1, Q => T2);
		U1: entity work.nor2(param) port map (A => S, B => t2, Q => T1);

		nQ <= T1;
		Q <= T2;
	end struct;

architecture beh of rs_latch is
	signal T1, T2: std_logic;
	begin
		T2 <= R nor T1;
		T1 <= S nor T2;

		nQ <= T1;
		Q <= T2;
	end beh;

architecture param of rs_latch is
	signal T1, T2: std_logic;
	begin
		T2 <= R nor T1 after 3 ps;
		T1 <= S nor T2 after 3 ps;

		nQ <= transport T1 after 2 ps;
		Q <= transport T2 after 3 ps;
	end param;
