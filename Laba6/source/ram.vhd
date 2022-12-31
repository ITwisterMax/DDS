library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
	generic (
		word_size: integer := 8;
		address_size: integer := 2
	);

	port (
		CLK: in std_logic;
		WE: in std_logic;
		AB: in std_logic_vector(address_size - 1 downto 0);
		DB: inout std_logic_vector(word_size - 1 downto 0)
	);
end ram;

architecture beh of ram is	 
	type ram_type is array(0 to 2 ** address_size - 1) of std_logic_vector(word_size - 1 downto 0);
	
	signal ram_storage: ram_type;
	signal address_value: integer range 0 to 2 ** address_size - 1;

	begin
		address_value <= conv_integer(unsigned(AB));

		write_data: process(CLK, DB, ram_storage, address_value, WE) begin	
			if WE = '1' then	
				if rising_edge(CLK) then
					ram_storage(address_value) <= DB;
				end if;
			end if;
		end process;

		read_data: process(CLK, DB, ram_storage, address_value, WE) begin
			if WE = '0' then
				if rising_edge(CLK) then
					DB <= ram_storage(address_value);
				end if;
			else
				DB <= (others => 'Z');
			end if;
		end process;
	end beh;
