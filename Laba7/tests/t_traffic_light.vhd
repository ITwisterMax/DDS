library ieee;
use ieee.std_logic_1164.all;

entity t_traffic_light is
end t_traffic_light;

architecture t_architecture of t_traffic_light is
	component traffic_light
		port(
			CLK: in std_logic;
			CWAIT: in std_logic;
			RST: in std_logic;
			START: in std_logic;
			R: out std_logic;
			Y: out std_logic;
			G: out std_logic
		);
	end component;

	signal CLK: std_logic := '0';
	signal CWAIT: std_logic;
	signal RST: std_logic;
	signal START: std_logic;

	signal R: std_logic;
	signal Y: std_logic;
	signal G: std_logic;

	constant period: time := 2 ps;

	begin
		U1: entity work.traffic_light(beh) port map (
			CLK => CLK,
			CWAIT => CWAIT,
			RST => RST,
			START => START,
			R => R,
			Y => Y,
			G => G
		);
		
		CLK <= not CLK after period / 2;
		
		main: process begin
			START <= '1';
			wait for 16 * period;

			CWAIT <= '1';
			wait for 16 * period;

			CWAIT <= '0';
			wait for 8 * period;

			RST <= '1';
			wait for period;

			RST <= '0';
			wait for 8 * period;
		end process;
	end t_architecture;
