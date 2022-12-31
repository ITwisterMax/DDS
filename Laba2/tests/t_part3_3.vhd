library ieee;
use ieee.std_logic_1164.all;

entity t_part3_3 is
end t_part3_3;

architecture t_architecture of t_part3_3 is
	component part3_3
		port(        					
			G_L, A, B: in std_logic; 
			Y0_L, Y1_L, Y2_L, Y3_L: out std_logic
		);
	end component;

	signal G_L: std_logic := '0';
	signal A: std_logic := '0';
	signal B: std_logic := '0';

	signal Y0_L_1: std_logic;
	signal Y1_L_1: std_logic;
	signal Y2_L_1: std_logic;
	signal Y3_L_1: std_logic;

	signal Y0_L_2: std_logic;
	signal Y1_L_2: std_logic;
	signal Y2_L_2: std_logic;
	signal Y3_L_2: std_logic;

	signal error: std_logic;

	constant clock_period: time := 1 ps;

	begin
		U1: entity work.part3_3(beh) port map (
			G_L => G_L,
			A => A,
			B => B,
			Y0_L => Y0_L_1,
			Y1_L => Y1_L_1,
			Y2_L => Y2_L_1,
			Y3_L => Y3_L_1
		);

		U2: entity work.part3_3(struct) port map (
			G_L => G_L,
			A => A,
			B => B,
			Y0_L => Y0_L_2,
			Y1_L => Y1_L_2,
			Y2_L => Y2_L_2,
			Y3_L => Y3_L_2
		);

		G_L <= not G_L after clock_period;
		A <= not A after clock_period * 2;
		B <= not B after clock_period * 4;

		error <= (Y0_L_1 xor Y0_L_2) or (Y1_L_1 xor Y1_L_2) or (Y2_L_1 xor Y2_L_2) or (Y3_L_1 xor Y3_L_2);
	end t_architecture;