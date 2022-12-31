library ieee;
use ieee.std_logic_1164.all;

entity t_d_flip_flop_ext is
end t_d_flip_flop_ext;

architecture t_architecture of t_d_flip_flop_ext is
	component d_flip_flop_ext
		port(
			CLR: in std_logic;
			PRE: in std_logic;
			D: in std_logic;
			E: in std_logic;
			CLK: in std_logic;
			Q: out std_logic
		);
	end component;
	
	signal CLR: std_logic := '0';
	signal PRE: std_logic := '0';
	signal D: std_logic := '0';
	signal E: std_logic := '0';
	signal CLK: std_logic := '0';
	
	signal Q: std_logic;	

	constant clock: integer := 10;
	constant clock_period: time := clock * 1 ps;
	constant preset_period: time := ((clock * 20) - (clock / 2)) * 1 ps;
	constant clr_period: time := ((clock * 40) - (clock / 2)) * 1 ps;

	begin
		U1: d_flip_flop_ext port map (
			CLR => CLR,
			PRE => PRE,
			D => D,
			E => E,
			CLK => CLK,
			Q => Q
		);
			
		CLK <= not CLK after clock_period;

		D <= not D after clock_period * 4;
		E <= not E after clock_period * 8;

		PRE <= '1' after preset_period when PRE = '0' else '0' after clock_period / 2;
		CLR <= '1' after clr_period when CLR = '0' else '0' after clock_period / 2;

	end t_architecture;
