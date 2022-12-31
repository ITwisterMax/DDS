library ieee;
use ieee.std_logic_1164.all;

entity t_lfsr_in_sum is generic (n: integer := 4);
end t_lfsr_in_sum;

architecture t_architecture of t_lfsr_in_sum is			 
	component lfsr_in_sum generic (N : integer := 4);
		port(
			CLK: in std_logic;
			RST: in std_logic;		
			State: out std_logic_vector(0 to n - 1);
			Qout: out std_logic
		);
	end component;

	signal CLK: std_logic := '0';
	signal RST: std_logic := '0';	
	
	signal State: std_logic_vector(0 to n - 1);
	signal Qout: std_logic;

	constant period: time := 1 ps;

	begin
		U1: lfsr_in_sum port map (
			CLK => CLK,
			RST => RST,		
			Qout => Qout,
			State => State
		);
	
		CLK <= not CLK after period;
	end t_architecture;