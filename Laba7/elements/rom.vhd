library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity rom is
	generic (
		word_size: integer := d_rom_word_size;
		address_size: integer := d_rom_address_size;
		initial_state: rom_type := ((others => (others =>'0')))
	);						   
	port (
		RE: in std_logic;
		ADDR: in std_logic_vector(address_size - 1 downto 0);
		ROM_OUT: out std_logic_vector(word_size - 1 downto 0)
	);
end ROM;

architecture beh of rom is
	signal data: std_logic_vector(word_size - 1 downto 0);

	begin
		data <= initial_state(conv_integer(unsigned(ADDR)));

		read_data_from_rom: process(RE, data) begin
			if (RE = '1') then
				ROM_OUT <= data;
			else
				ROM_OUT <= (others => 'Z');
			end if;
		end process;
	end beh;
