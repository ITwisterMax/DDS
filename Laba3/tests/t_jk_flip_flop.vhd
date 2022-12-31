library ieee;
use ieee.std_logic_1164.all;

entity t_jk_flip_flop is
end t_jk_flip_flop;

architecture t_architecture of t_jk_flip_flop is
	component jk_flip_flop
		port(
			J: in std_logic;
			K: in std_logic;
			CLK: in std_logic;
			Q: out std_logic
		);
	end component;

	signal J: std_logic := '0';
	signal K: std_logic := '0';
	signal CLK: std_logic := '0';

	signal Q: std_logic;

	constant period: time := 1 ps;

	begin
		U1: jk_flip_flop port map (
			J => J,
			K => K,
			CLK => CLK,
			Q => Q
		);

		CLK <= not CLK after period;
		J <= not J after period * 8;
		K <= not K after period * 16;
	end t_architecture;
