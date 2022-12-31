library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use work.utils.all;

entity find_count_of_zero_elements is
end find_count_of_zero_elements;

architecture beh of find_count_of_zero_elements is
	signal CLK: std_logic := '0';
	signal RST: std_logic;
	signal START: std_logic;
	signal STOP: std_logic;
	
	constant rom_states: rom_type :=(
		"0000" & "000001", -- 000000 : LOAD 000001
		"0110" & "000101", -- 000001 : JNZ 000101
		"0000" & "000110", -- 000010 : LOAD 000110
		"0100" & "111111", -- 000011 : INC
		"0001" & "000110", -- 000100 : STORE 000110
		"0000" & "000010", -- 000101 : LOAD 000010
		"0110" & "001010", -- 000110 : JNZ 001010
		"0000" & "000110", -- 000111 : LOAD 000110
		"0100" & "111111", -- 001000 : INC
		"0001" & "000110", -- 001001 : STORE 000110
		"0000" & "000011", -- 001010 : LOAD 000011
		"0110" & "001111", -- 001011 : JNZ 001111
		"0000" & "000110", -- 001100 : LOAD 000110
		"0100" & "111111", -- 001101 : INC
		"0001" & "000110", -- 001110 : STORE 000110
		"0000" & "000100", -- 001111 : LOAD 000100
		"0110" & "010100", -- 010000 : JNZ 010100
		"0000" & "000110", -- 010001 : LOAD 000110
		"0100" & "111111", -- 010010 : INC
		"0001" & "000110", -- 010011 : STORE 000110
		"0000" & "000101", -- 010100 : LOAD 000101
		"0110" & "011001", -- 010101 : JNZ 011001
		"0000" & "000110", -- 010110 : LOAD 000110
		"0100" & "111111", -- 010111 : INC
		"0001" & "000110", -- 011000 : STORE 000110
		"1010" & "111111", -- 011001 : HALT
		others => "1010" & "000000"
	);						   
	
	constant ram_states: ram_type := (
		"00000101",	-- 000000 | 5 | array length
		"00000000", -- 000001 | 0 | a[0]
		"00000001", -- 000010 | 1 | a[1]
		"00000000", -- 000011 | 0 | a[2]
		"00000100", -- 000100 | 4 | a[3]
		"00000000", -- 000101 | 5 | a[4]
		"00000011", -- 000110 | 3 | result
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
