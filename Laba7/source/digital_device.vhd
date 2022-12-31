library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity digital_device is
	generic (
		rom_word_size: integer := d_rom_word_size;
		rom_address_size: integer := d_rom_address_size;
		rom_initial_state: rom_type := ((others => (others =>'0')));

		ram_word_size: integer := d_ram_word_size;
		ram_address_size: integer := d_ram_address_size;
		ram_initial_state: ram_type := ((others => (others =>'0')))
	);
	port (
		CLK, RST, START: in std_logic;
		STOP: out std_logic
	);
end digital_device;

architecture beh of digital_device is
	signal rom_read_enable: std_logic;
	signal rom_address: address_word;
	signal rom_out: std_logic_vector(9 downto 0);

	signal ram_write_enable: std_logic;
	signal ram_address: address_word;
	signal ram_data: data_word;

	signal alu_operand: data_word;
	signal alu_operation: operation_word;
	signal alu_enable: std_logic;
	signal alu_result: data_word;
	signal alu_zero_flag: std_logic;
	signal alu_sign_bit: std_logic;

	begin
		URAM: entity work.ram(beh)
			generic map(
				word_size => ram_word_size,
				address_size => ram_address_size,
				initial_state => ram_initial_state
			)
			port map(
				WE => ram_write_enable,
				AB => ram_address,
				DB => ram_data
			);

		UROM: entity work.rom(beh)
			generic map(
				word_size => rom_word_size,
				address_size => rom_address_size,
				initial_state => rom_initial_state	
			)
			port map(
				RE => rom_read_enable,
				ADDR => rom_address,
				ROM_OUT => rom_out
			);
		
		UALU: entity work.alu(beh)
			port map(
				EN => alu_enable,
				OPERATION => alu_operation,
				OPERAND => alu_operand,
				RES => alu_result,
				ZF => alu_zero_flag,
				SB => alu_sign_bit
			);

		UFSM: entity work.fsm(beh)
			port map(
				CLK => CLK,
				RST => RST,
				START => START,
				STOP => STOP,
	
				ROM_RE => rom_read_enable,
				ROM_ADDR => rom_address,
				ROM_OUT => rom_out,
				
				RAM_WE => ram_write_enable, 
				RAM_ADDR => ram_address,
				RAM_DATA => ram_data,
				
				ALU_OPERAND => alu_operand,
				ALU_OPERATION => alu_operation,
				ALU_EN => alu_enable,
				ALU_RES => alu_result,
				ALU_ZF => alu_zero_flag,
				ALU_SB => alu_sign_bit
			);
	end beh;