library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	port(        					
		A, B, S: in std_logic; 
		Z: out std_logic
	); 
end mux2;

architecture struct of mux2 is
	component inv
		port(
			A: in std_logic;
			nA: out std_logic
		);
	end component;

	component and2
		port(        					
			A, B: in std_logic; 
			Q: out std_logic
		);	
	end component;
	
	component or2
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;
	
	signal nS, BS, AnS: std_logic;
	begin	
		U1: inv port map(S, nS);
		U2: and2 port map(A, nS, AnS);
		U3: and2 port map(B, S, BS);
		U4: or2 port map(AnS, BS, Z);
	end struct;