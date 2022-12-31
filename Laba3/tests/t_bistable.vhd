library ieee;
use ieee.std_logic_1164.all;

entity t_bistable is
end t_bistable;

architecture t_architecture of t_bistable is
	component bistable
		port(
			Q: out std_logic;
			nQ: out std_logic
		);
	end component;

	signal init_Q: std_logic;
	signal init_nQ: std_logic;

	signal uninit_Q: std_logic;
	signal uninit_nQ: std_logic;

	begin
		U1: entity work.bistable(uninit_bistable) port map (
			Q => uninit_Q,
			nQ => uninit_nQ
		);

		U2: entity work.bistable(init_bistable) port map (
			Q => init_Q,
			nQ => init_nQ
		);

	end t_architecture;
