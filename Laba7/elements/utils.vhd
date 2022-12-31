library ieee;
use ieee.std_logic_1164.all;

package utils is
	subtype data_word is std_logic_vector(7 downto 0);
	subtype operation_word is std_logic_vector(3 downto 0);
	subtype address_word is std_logic_vector(5 downto 0);

	constant d_rom_address_size: integer := 6;
	constant d_rom_word_size: integer := 10;
	constant d_ram_word_size: integer := 8;
	constant d_ram_address_size: integer := 6;

	type rom_type is array (0 to 2 ** d_rom_address_size - 1) of std_logic_vector(d_rom_word_size - 1 downto 0);
	type ram_type is array (0 to 2 ** d_ram_address_size - 1) of std_logic_vector(d_ram_word_size - 1 downto 0);

	constant OP_LOAD: operation_word := "0000";
	constant OP_STORE: operation_word := "0001";
	constant OP_ADD: operation_word := "0010";
	constant OP_SUB: operation_word := "0011";
	constant OP_INC: operation_word := "0100";
	constant OP_DEC: operation_word := "0101";
	constant OP_JNZ: operation_word := "0110";
	constant OP_JZ: operation_word := "0111";
	constant OP_JNSB: operation_word := "1000";
	constant OP_JMP: operation_word := "1001";
	constant OP_HALT: operation_word := "1010";

	function to_std_logic(b: boolean) return std_logic;
end package;

package body utils is
	function to_std_logic(b: boolean) return std_logic is 
	begin 
		if b then 
			return '1'; 
		else 
			return '0'; 
		end if; 
	end function to_std_logic;
end package body;