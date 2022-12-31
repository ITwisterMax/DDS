library ieee;
use ieee.std_logic_1164.all;

entity t_signature_analizator is generic (n: integer := 4);
end t_signature_analizator;

architecture t_architecture of t_signature_analizator is			 
	component signature_analizator generic (n: integer := 4);
		port(
			CLK: in std_logic;
			RST: in std_logic;
			Pin: in std_logic;
			State: out std_logic_vector(0 to n - 1);
			Qout: out std_logic
		);
	end component;

	signal CLK: std_logic := '0';
	signal RST: std_logic := '0';		 
	signal Pin: std_logic := '0';
	
	signal State: std_logic_vector(0 to n - 1);
	signal Qout: std_logic;
	
	constant period: time := 1 ps;

	constant test: std_logic_vector := "11000011";

	begin
		U1: signature_analizator port map (
			CLK => CLK,
			RST => RST,		
			State => State,
			Pin => Pin,
			Qout => Qout
		);

		main: process begin	
			wait for period;

			for i in test'length - 1 downto 0 loop
				Pin <= test(i);					
				wait for period * 2;
			end loop;	
		end process;

		CLK <= not CLK after period;
	end t_architecture;