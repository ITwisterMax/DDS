library ieee;
use ieee.std_logic_1164.all;

entity half_sum is
	port(
		A, B: in std_logic;
		S: out std_logic;
		C: out std_logic
	);
end half_sum;

architecture struct of half_sum is	
	component xor2	  
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	component and2	  
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	begin
		U1: xor2 port map (A=>A, B=>B, Q=>S);
		U2: and2 port map (A=>A, B=>B, Q=>C);
	end struct;													 								