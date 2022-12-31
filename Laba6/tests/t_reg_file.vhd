library ieee;
use ieee.std_logic_1164.all;

entity t_reg_file is
	generic(
		reg_size: integer := 4;
		address_size: integer := 2
	);
end t_reg_file;

architecture t_architecture of t_reg_file is
	component reg_file
		generic(
			reg_size: integer := 4;
			address_size: integer := 2
		);

		port(
			INIT: in std_logic;
			WDP: in std_logic_vector(reg_size - 1 downto 0);
			RDP: out std_logic_vector(reg_size - 1 downto 0);
			WA: in std_logic_vector(address_size - 1 downto 0);
			RA: in std_logic_vector(address_size - 1 downto 0);
			CLK: in std_logic
		);
	end component;

	signal INIT: std_logic;
	signal WDP: std_logic_vector(reg_size - 1 downto 0);
	signal RDP: std_logic_vector(reg_size - 1 downto 0);
	signal WA: std_logic_vector(address_size - 1 downto 0);
	signal RA: std_logic_vector(address_size - 1 downto 0);
	signal CLK: std_logic := '0';

	constant period: time := 1 ps;
	constant count: integer := 4;

	type words is array(0 to count - 1) of std_logic_vector(reg_size - 1 downto 0);
	type addresses is array(0 to count - 1) of std_logic_vector(address_size - 1 downto 0);

	constant test_words: words := ("1111", "0001", "1101", "0100");							   
	constant test_addresses: addresses := ("00", "01", "10", "11");

	begin
		U1: entity work.reg_file(beh)
		generic map (
			reg_size => reg_size,
			address_size => address_size
		)
		port map (
			INIT => INIT,
			WDP => WDP,
			RDP => RDP,
			WA => WA,
			RA => RA,
			CLK => CLK
		);

		main: process begin
			INIT <= '1';
			wait for period;

			INIT <= '0';
			for i in 0 to count - 1	loop
				WA <= test_addresses(i);
				WDP <= test_words(i);
				wait for 2 * period;

				RA <= test_addresses(i);
				wait for 2 * period;
			end loop;
		end process;
		
		CLK <= not CLK after period;
	end t_architecture;