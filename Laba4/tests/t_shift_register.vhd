library ieee;
use ieee.std_logic_1164.all;	

entity t_shift_register is	generic(n: integer := 8);
end t_shift_register;

architecture t_architecture of t_shift_register is	
	component shift_register generic(n: integer := 8);
		port(
			Sin: in std_logic;
			SE: in std_logic;
			CLK: in std_logic;
			RST: in std_logic;
			Dout: out std_logic_vector(0 to n - 1)
		);
	end component;
	
	signal Sin: std_logic := '0';
	signal SE: std_logic := '1';
	signal CLK: std_logic := '0';
	signal RST: std_logic;
	
	signal Dout1: std_logic_vector(0 to n - 1);
	signal Dout2: std_logic_vector(0 to n - 1);
	
	constant period: time := 1 ps;
	begin
		U1: entity work.shift_register(beh) generic map (n => n) port map (
			Sin => Sin,
			SE => SE,
			CLK => CLK,
			RST => RST,
			Dout => Dout1
		);
			
		U2: entity work.shift_register(struct) generic map (n => n) port map (
			Sin => Sin,
			SE => SE,
			CLK => CLK,
			RST => RST,
			Dout => Dout2
		);
		
		change_RST: process begin
			RST <= '1';
			wait for period;

			RST <= '0';
			wait for period * (n + 1) * 2;
		end process;

		CLK <= not CLK after period;
		Sin <= not Sin after period;
		SE <= not SE after period * (n + 1) * 2;	
	end t_architecture;
