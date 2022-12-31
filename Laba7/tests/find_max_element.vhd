library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity find_max_element is
end find_max_element;

architecture beh of find_max_element is
	signal CLK: std_logic := '0';
	signal RST: std_logic;
	signal START: std_logic;
	signal STOP: std_logic;

	constant rom_states: rom_type :=(
		"0000" & "000001", -- 000000 : LOAD 000001
		"0001" & "000110", -- 000001 : STORE 000110
		"0011" & "000010", -- 000010 : SUB 000010
		"1000" & "000110", -- 000011 : JNSB 000110
		"0000" & "000010", -- 000100 : LOAD 000010
		"0001" & "000110", -- 000101 : STORE 000110
		"0000" & "000110", -- 000110 : LOAD 000110
		"0011" & "000011", -- 000111 : SUB 000011
		"1000" & "001011", -- 001000 : JNSB 001011
		"0000" & "000011", -- 001001 : LOAD 000011
		"0001" & "000110", -- 001010 : STORE 000110
		"0000" & "000110", -- 001011 : LOAD 000110
		"0011" & "000100", -- 001100 : SUB 000100
		"1000" & "010000", -- 001101 : JNSB 010000
		"0000" & "000100", -- 001110 : LOAD 000100
		"0001" & "000110", -- 001111 : STORE 000110
		"0000" & "000110", -- 010000 : LOAD 000110
		"0011" & "000101", -- 010001 : SUB 000101
		"1000" & "010101", -- 010010 : JNSB 010101
		"0000" & "000101", -- 010011 : LOAD 000101
		"0001" & "000110", -- 010100 : STORE 000110
		"0000" & "000110", -- 010101 : LOAD 000110
		"1010" & "000000", -- 010110 : HALT
		others => "1010" & "000000"
	);						   

	constant ram_states: ram_type := (
		"00000101",	-- 000000 | 5 | array length
		"00000011", -- 000001 | 3 | a[0]
		"00000001", -- 000010 | 1 | a[1]
		"00000101", -- 000101 | 5 | a[2]
		"00000010", -- 000011 | 2 | a[3]
		"00000100", -- 000100 | 4 | a[4]
		"00000101", -- 000110 | 5 | result	
		others => "00000000"	
	);
	
	constant period: time := 2 ps;

	begin
		U1: entity work.digital_device(beh)
			generic map(
				rom_word_size => d_rom_word_size,
				rom_address_size => d_rom_address_size,
				rom_initial_state => rom_states,
				ram_word_size => d_ram_word_size,
				ram_address_size => d_ram_address_size,
				ram_initial_state => ram_states
			)										  
			port map(
				CLK => CLK,
				RST => RST,
				START => START,
				STOP => STOP
			);
		
		CLK <= not CLK after period / 2;
		
		main: process begin
			RST <= '1';
			wait for period;

			RST <= '0';
			START <= '1';
			wait;
		end process;
	end beh;
