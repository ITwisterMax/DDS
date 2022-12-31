library ieee;
use ieee.std_logic_1164.all;

entity t_rs_flip_flop is
end t_rs_flip_flop;

architecture t_architecture of t_rs_flip_flop is
	component rs_flip_flop
		port(
			R: in std_logic;
			S: in std_logic;
			CLK: in std_logic;
			Q: out std_logic
		);
	end component;
	
	signal R: std_logic := '0';
	signal S: std_logic := '0';
	signal CLK: std_logic := '0';
	
	signal Q: std_logic;	   
	
	constant period: time := 1 ps;

	begin
		U1: rs_flip_flop port map (
			R => R,
			S => S,
			CLK => CLK,
			Q => Q
		);

		CLK <= not CLK after period;
		S <= not S after period * 4;
		R <= not R after period * 8;

	end t_architecture;
