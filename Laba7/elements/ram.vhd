library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity ram is
	generic (
		word_size: integer := d_ram_word_size;
		address_size: integer := d_ram_address_size;
		initial_state: ram_type := ((others => (others =>'0')))
	);
	port (
		WE: in std_logic;
		AB: in std_logic_vector(address_size - 1 downto 0);
		DB: inout std_logic_vector(word_size - 1 downto 0)
	);
end ram;

architecture beh of ram is
	signal ram_storage: ram_type := initial_state;
	signal address: integer range 0 to 2 ** address_size - 1;
	signal write_data, read_data: std_logic_vector(word_size - 1 downto 0);

	begin
		address <= conv_integer(unsigned(AB));

		write_data_in_ram: process(DB) begin	
			write_data <= DB;
		end process;
		
		read_data_from_ram: process(DB, address) begin
			read_data <= ram_storage(address);
		end process;

		update_data_in_ram: process(write_data, read_data, WE, address, DB) begin
			if (WE = '1') then
				DB <= (others => 'Z');
				ram_storage(address) <= write_data;
			else
				DB <= read_data;
			end if;		
		end process;
	end beh;
