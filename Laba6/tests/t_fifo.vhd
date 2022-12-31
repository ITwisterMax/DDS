library ieee;
use ieee.std_logic_1164.all;

entity t_fifo is
	generic(
		word_size: integer := 8;
		address_size: integer := 2
	);
end t_fifo;

architecture t_architecture of t_fifo is
	component fifo
		generic(
			word_size: integer := 8;
			address_size: integer := 2
		);
		port(
			CLK: in std_logic;
			WE: in std_logic;
			DB: inout std_logic_vector(word_size - 1 downto 0);
			EMPTY: out std_logic;
			FULL: out std_logic
		);
	end component;

	signal CLK: std_logic := '0';
	signal WE: std_logic;
	signal DB: std_logic_vector(word_size - 1 downto 0);

	signal IS_EMPTY: std_logic;
	signal IS_FULL: std_logic;
	
	constant period: time := 1 ps;
	constant count: integer := 4;

	type words is array(0 to count - 1) of std_logic_vector(word_size - 1 downto 0);

	constant test_words: words := (x"FF", x"00", x"01", x"0A");

	begin
		U1: entity work.fifo(beh)
			generic map (
				word_size => word_size,
				address_size => address_size
			)
			port map (
				CLK => CLK,
				WE => WE,
				DB => DB,
				EMPTY => IS_EMPTY,
				FULL => IS_FULL
			);

		stimulate: process begin							  
			WE <= '1';
			for i in 0 to count - 1	loop
				DB <= test_words(i);
				wait for period * 2;
			end loop;		
			
			DB <= (others => 'Z');
			WE <= '0';
			wait for period * count * 2;
		end process;
	
		CLK <= not CLK after period;
	end t_architecture;

