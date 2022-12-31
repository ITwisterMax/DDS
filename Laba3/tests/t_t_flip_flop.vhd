library ieee;
use ieee.std_logic_1164.all;

entity t_t_flip_flop is
end t_t_flip_flop;

architecture t_architecture of t_t_flip_flop is
	component t_flip_flop
		port(
			T: in std_logic;
			CLK: in std_logic;
			CLR: in std_logic;
			Q: out std_logic
		);
	end component;

	signal T: std_logic := '0';
	signal CLK: std_logic := '0';
	signal CLR: std_logic := '1';
	
	signal Q: std_logic;
	
	constant clock: integer := 10;
	constant clock_period: time := clock * 1 ps;
	constant clr_period: time := ((clock * 10) - (clock / 2)) * 1 ps;

	begin
		U1: t_flip_flop port map (
			T => T,			
			Q => Q,
			CLK => CLK,
			CLR => CLR
		);
			
		CLK <= not CLK after clock_period;
		T <= not T after clock_period * 8;
		CLR <= '1' after clr_period when CLR = '0' else '0' after clock_period;
	end t_architecture;
