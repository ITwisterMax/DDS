library ieee;
use ieee.std_logic_1164.all;

entity t_ram is
	generic(
		word_size: integer := 8;
		address_size: integer := 2
	);
end t_ram;

architecture t_architecture of t_ram is
	component ram
		generic(
			word_size: integer := 8;
			address_size: integer := 2
		);

		port(
			CLK: in std_logic;
			WE: in std_logic;
			AB: in std_logic_vector(address_size - 1 downto 0);
			DB: inout std_logic_vector(word_size - 1 downto 0)
		);
	end component;

	signal CLK: std_logic := '0';
	signal WE: std_logic;
	signal AB: std_logic_vector(address_size - 1 downto 0);
	signal DB: std_logic_vector(word_size - 1 downto 0);
	
	constant period: time := 1 ps;
	constant count: integer := 4;

	type words is array(0 to count - 1) of std_logic_vector(word_size - 1 downto 0);
	type addresses is array(0 to count - 1) of std_logic_vector(address_size - 1 downto 0);

	constant test_words: words := (x"FF", x"00", x"01", x"0A");							   
	constant test_addresses: addresses := ("00", "01", "10", "11");
begin
	U1: entity work.ram(beh)
	generic map (
		word_size => word_size,
		address_size => address_size
	)
	port map (
		CLK => CLK,
		WE => WE,
		AB => AB,
		DB => DB
	);
	
	main: process begin
		for i in 0 to count - 1	loop
			AB <= test_addresses(i);
			DB <= test_words(i);
			WE <= '1';
			wait for period * 2;
		end loop;

		WE <= '0';		  
		DB <= (others => 'Z');

		for i in 0 to count - 1	loop
			AB <= test_addresses(i);
			wait for period * 2;
		end loop;
	end process;

	CLK <= not CLK after period;
end t_architecture;