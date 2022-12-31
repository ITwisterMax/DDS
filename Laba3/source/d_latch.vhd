library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
	port (
		D: in std_logic;
		Q: out std_logic;
		nQ: out std_logic
	);
end d_latch;

architecture struct of d_latch is 
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

	signal T1, T2, T3: std_logic;
	begin
		U1: inv port map (A => D, nA => T3);
		U2: entity work.nor2(beh) port map (A => D, B => T2, Q => T1);
		U3: entity work.nor2(beh) port map (A => T3, B => T1, Q => T2);

		Q <= T2;
		nQ <= T1;
	end struct;

architecture beh of d_latch is
	signal T1, T2, inv_signal: std_logic;
	begin					   
		inv_signal <= not D;

		T2 <= D nor T1;
		T1 <= inv_signal nor T2;

		nQ <= T1;
		Q <= T2;
	end beh;	   

architecture param of d_latch is
	signal T1, T2, inv_signal: std_logic;
	begin
		inv_signal <= not D;

		T2 <= D nor T1 after 3 ps;
		T1 <= inv_signal nor T2 after 3 ps;

		Q <= transport T2 after 2 ps;
		nQ <= transport T1 after 3 ps;	
	end param;