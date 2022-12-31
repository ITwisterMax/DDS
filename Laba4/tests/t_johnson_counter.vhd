library ieee;
use ieee.std_logic_1164.all;

entity t_johnson_counter is
end t_johnson_counter;

architecture t_architecture of t_johnson_counter is
	component johnson_counter
		port (
			CLK: in std_logic;
			RST: in std_logic;			
			Qout: out std_logic_vector(0 to 7)
		);
	end component;

	signal CLK: std_logic := '0';
	signal RST: std_logic := '1';
	
	signal Qout: std_logic_vector(0 to 7);
	constant period: time := 1 ps;

	begin
		U1: johnson_counter port map (
			CLK => CLK,
			RST => RST,		
			Qout => Qout
		);
		
		CLK <= not CLK after period;
		
		change_RST: process begin
			RST <= '1';
			wait for period;

			RST <= '0';
			wait for period * 20;
		end process;
	end t_architecture;