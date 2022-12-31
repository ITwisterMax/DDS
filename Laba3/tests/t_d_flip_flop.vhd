library ieee;
use ieee.std_logic_1164.all;

entity t_d_flip_flop is
end t_d_flip_flop;

architecture t_architecture of t_d_flip_flop is
	component d_flip_flop
		port(
			D: in std_logic;
			CLK: in std_logic;
			Q: out std_logic
		);
	end component;

	signal D: std_logic := '0';
	signal CLK: std_logic := '0';

	signal Q: std_logic;

	constant clock: time := 1 ps;
	constant period: time := clock * 4;

	begin
		U1: d_flip_flop port map (
			D => D,
			CLK => CLK,
			Q => Q
		);

		D <= not D after period;
		CLK <= not CLK after clock;

	end t_architecture;
