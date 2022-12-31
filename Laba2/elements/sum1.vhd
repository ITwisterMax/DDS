LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity sum1 is
	port(
		A, B, C1: in std_logic;
		S,
		C: out std_logic
	);
end sum1;

architecture struct of sum1 is
	component half_sum
		port(
			A, B: in std_logic;
			S,
			C: out std_logic
		);
	end component;

	component or2
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;

	signal A_sum_B, A_B_carry, A_B_C1_carry: std_logic;
	begin
		U1: half_sum port map (A=>A, B=>B, S=>A_sum_B, C=>A_B_carry);
		U2: half_sum port map (A=>C1, B=>A_sum_B, S=>S, C=>A_B_C1_carry);
		U3: or2 port map (A=>A_B_C1_carry, B=>A_B_carry, Q=>C);
	end struct;