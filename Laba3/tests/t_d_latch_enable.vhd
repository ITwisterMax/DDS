library ieee;
use ieee.std_logic_1164.all;

entity t_d_latch_enable is
end t_d_latch_enable;

architecture t_architecture of t_d_latch_enable is
	component d_latch_enable
		port(
			D: in std_logic;
			E: in std_logic;
			Q: out std_logic;
			nQ: out std_logic
		);
	end component;

	signal D: std_logic := '0';
	signal E: std_logic := '0';

	signal Q1: std_logic;
	signal nQ1: std_logic;	 
	
	signal Q2: std_logic;
	signal nQ2: std_logic;
	
	signal Q3: std_logic;
	signal nQ3: std_logic;   

	constant clock_period: time := 10 ps;
	constant enabled: time := 10 ps;
	constant disabled: time := enabled * 4;

	begin
		U1: entity work.d_latch_enable(struct) port map (
				D => D,
				E => E,
				Q => Q1,
				nQ => nQ1
			);	 
			
		U2: entity work.d_latch_enable(beh) port map (
			D => D,
			E => E,
			Q => Q2,
			nQ => nQ2
		);

		U3: entity work.d_latch_enable(param) port map (
			D => D,
			E => E,
			Q => Q3,
			nQ => nQ3
		);

		D <= not D after clock_period;
		E <= '1' after disabled when E = '0' else '0' after enabled;
	end t_architecture;
