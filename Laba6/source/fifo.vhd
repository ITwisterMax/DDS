library ieee;
use ieee.std_logic_1164.all;

entity fifo is
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
end fifo;

architecture beh of fifo is
	constant max: integer := 2 ** address_size - 1;

	type ram_type is array(0 to max) of std_logic_vector(word_size - 1 downto 0);
	
	signal ram_storage: ram_type;

	signal head: integer := 0;
	signal tail: integer := 0;

	signal IS_FULL: std_logic := '0';
	signal IS_EMPTY: std_logic := '1';
	signal IS_LOOPED: boolean :=  false;

	begin
		update_pointers: process(CLK) begin		
			if rising_edge(CLK) then
				if WE = '1' then
					if (IS_LOOPED = false) or (head /= tail) then
						if (head = max) then
							head <= 0;
							is_looped <= true;
						else
							head <= head + 1;
						end if;
					end if;
				else
					if (IS_LOOPED = true) or (head /= tail) then
						if (tail = max) then
							tail <= 0;
							IS_LOOPED <= false;
						else
							tail <= tail + 1;
						end if;
					end if;
				end if;
			end if;		
		end process;
		
		update_flags: process(head, tail, IS_LOOPED) begin
			if (head = tail) then
				if IS_LOOPED then
					IS_FULL <= '1';
				else
					IS_EMPTY <= '1';
				end if;
			else
				IS_EMPTY <= '0';
				IS_FULL <= '0';
			end if;
		end process;
		
		write_data: process(head) begin
			if WE = '1' then	
				if IS_FULL = '0' then
					ram_storage(head) <= DB;
				end if;
			end if;
		end process;
		
		read_data: process(tail) begin
			if WE = '0' then
				if IS_EMPTY = '0' then
					DB <= ram_storage(tail);
				end if;
			else
				DB <= (others => 'Z');
			end if;
		end process;

		EMPTY <= IS_EMPTY;
		FULL <= IS_FULL;
	end beh;
