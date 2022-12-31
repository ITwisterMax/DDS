library ieee;
use ieee.std_logic_1164.all;

entity d_latch_enable is
	port (
		D, E: in std_logic;
		Q: out std_logic;
		nQ: out std_logic
	);
end d_latch_enable;

architecture struct of d_latch_enable is 
	component nor2 
		port (
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	component inv
		port (
			A: in std_logic;
			nA: out std_logic
		);
	end component;

	component and2 
		port (
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	signal T1, T2, E_and_D, E_and_nD, nD: std_logic;
	begin
		U1: and2 port map (A => E, B => D, Q => E_and_D);
		U2: inv port map (A => D, nA => nD);
		U3: and2 port map (A => nD, B => E, Q => E_and_nD);
		U4: entity work.nor2(beh) port map (A => E_and_D, B => T2, Q => T1);
		U5: entity work.nor2(beh) port map (A => E_and_nD, B => T1, Q => T2);

		Q <= T2;
		nQ <= T1;
	end struct;

architecture beh of d_latch_enable is
	signal T: std_logic;
	begin	
		T <= D when E = '1';

		Q <= T;
		nQ <= not T;
	end beh;

architecture param of d_latch_enable is
	signal T: std_logic;
	begin
		T <= D when E = '1';

		Q <= T after 2 ps;
		nQ <= not T after 3 ps;
	end param;