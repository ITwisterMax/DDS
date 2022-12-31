library ieee;
use ieee.std_logic_1164.all;

entity t_d_latch is
end t_d_latch;

architecture t_architecture of t_d_latch is
	component d_latch
		port(
			D: in std_logic;
			Q: out std_logic;
			nQ: out std_logic
		);
	end component;

	signal D: std_logic := '0';
	
	signal Q1: std_logic;
	signal nQ1: std_logic;
	
	signal Q2: std_logic;
	signal nQ2: std_logic;	
	
	signal Q3: std_logic;
	signal nQ3: std_logic;

	begin
		U1: entity work.d_latch(struct) port map (
			D => D,
			Q => Q1,
			nQ => nQ1
		); 
		
		U2: entity work.d_latch(beh) port map (
			D => D,
			Q => Q2,
			nQ => nQ2
		);

		U3: entity work.d_latch(param) port map (
			D => D,
			Q => Q3,
			nQ => nQ3
		);

		D <= not D after 10 ps;	

	end t_architecture;


