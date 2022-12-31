library ieee;
use ieee.std_logic_1164.all;

entity t_part3_2 is
end t_part3_2;

architecture t_architecture of t_part3_2 is
	component part3_2
		port(
			X, Y, Z: in std_logic;
			F: out std_logic
		);
	end component;

	signal X: std_logic := '0';
	signal Y: std_logic := '0';
	signal Z: std_logic := '0';

	signal F_1: std_logic;
	signal F_2: std_logic;

	signal error: std_logic;

	constant clock_period: time := 1 ps;

	begin
		U1: entity work.part3_2(beh) port map (
			X => X,
			Y => Y,
			Z => Z,
			F => F_1
		);

		U2: entity work.part3_2(struct) port map (
			X => X,
			Y => Y,
			Z => Z,
			F => F_2
		);

		X <= not X after clock_period;
		Y <= not Y after clock_period * 2;
		Z <= not Z after clock_period * 4;

		error <= F_1 xor F_2;
	end t_architecture;