library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.utils.all;

entity fsm is
	port (
		CLK, RST, START: in std_logic;
		STOP: out std_logic;

		ROM_RE: out std_logic;
		ROM_ADDR: out std_logic_vector(5 downto 0);
		ROM_OUT: in std_logic_vector(9 downto 0);

		RAM_WE: inout std_logic;
		RAM_ADDR: out std_logic_vector(5 downto 0);
		RAM_DATA: inout data_word;

		ALU_OPERAND: out data_word;
		ALU_OPERATION: out operation_word;
		ALU_EN: out std_logic;
		ALU_RES: in data_word;
		ALU_ZF: in std_logic;
		ALU_SB: in std_logic	
	);						   
end fsm;

architecture beh of fsm is
	type state is (
		IDLE,
		FETCH,
		DECODE,
		READ,
		LOAD,
		STORE,
		ADD,
		SUB,
		INC,
		DEC,
		HALT,
		JNZ,
		JZ,
		JNSB,
		JMP
	);

	signal next_state, curr_state: state;

	signal instruction: std_logic_vector(9 downto 0);
	signal instruction_pointer: address_word;
	signal operation: operation_word;
	signal address: address_word;
	signal data: data_word;
	signal fsr: data_word;

	constant final_address: address_word := "111111";
	constant fsr_address: address_word := "111110";

	begin
		save_state: process(CLK, RST, next_state) begin
			if (RST = '1') then
				curr_state <= IDLE;
			elsif rising_edge(CLK) then
				curr_state <= next_state;
			end if;
		end process;
		
		update_state: process(curr_state, START, operation) begin		
			case curr_state is
				when IDLE =>
					if (START = '1') then
						next_state <= FETCH;
					else
						next_state <= IDLE;
				end if;
				when FETCH => next_state <= DECODE;
				when DECODE =>
					case operation is
						when OP_HALT => next_state <= HALT;
						when OP_STORE => next_state <= STORE;
						when OP_JMP => next_state <= JMP;
						when OP_JZ => next_state <= JZ;
						when OP_JNZ => next_state <= JNZ;
						when OP_JNSB => next_state <= JNSB;
						when others => next_state <= READ;
				end case;
				when READ =>
					case operation is
						when OP_LOAD => next_state <= LOAD;
						when OP_ADD => next_state <= ADD;
						when OP_SUB => next_state <= SUB;
						when OP_INC => next_state <= INC;
						when OP_DEC => next_state <= DEC;
						when others => next_state <= IDLE;
				end case;
				when LOAD | STORE | ADD | SUB | INC | JMP | JZ | JNZ | JNSB => next_state <= FETCH;
				when HALT => next_state <= HALT;
				when others => next_state <= IDLE;
			end case;
		end process;							  
		
		update_stop: process(curr_state) begin
			STOP <= to_std_logic(curr_state = HALT);
		end process;
		
		update_instruction_pointer: process(CLK, RST, curr_state) begin		
			if (RST = '1') then
				instruction_pointer <= (others => '0');
			elsif falling_edge(CLK) then
				if (curr_state = DECODE) then
					instruction_pointer <= instruction_pointer + 1;
				elsif (curr_state = JZ and ALU_ZF = '1') then
					instruction_pointer <= address;
				elsif (curr_state = JNZ and ALU_ZF = '0') then
					instruction_pointer <= address;
				elsif (curr_state = JNSB and ALU_SB = '0') then
					instruction_pointer <= address;
				elsif (curr_state = JMP) then
					instruction_pointer <= address;
				end if;
			end if;
		end process; 

		update_rom_read_enable: process(next_state, curr_state) begin		
			ROM_RE <= to_std_logic(next_state = FETCH or curr_state = FETCH);
		end process;

		read_rom_data: process(RST, curr_state, ROM_OUT) begin
			if (RST = '1') then
				instruction <= (others => '0');
			elsif (curr_state = FETCH) then
				instruction <= ROM_OUT;
			end if;
		end process;
		
		decode_instruction: process(next_state, instruction) begin
			if (next_state = DECODE) then
				operation <= instruction(9 downto 6);
				address <= instruction(5 downto 0);
			end if;
		end process;

		update_ram_write_address: process(address) begin
			if (curr_state /= JMP and curr_state /= JNZ and curr_state /= JZ and curr_state /= JNSB) then
				if (address = final_address) then
					RAM_ADDR <= fsr(5 downto 0);
				elsif (address /= fsr_address) then
					RAM_ADDR <= address;
				end if;
			end if;
		end process;   
		
		update_ram_write_enable: process(curr_state) begin
			if (curr_state = STORE and address /= FSR_ADDRESS) then
				RAM_WE <= '1';
			else
				RAM_WE <= '0';
			end if;
		end process;

		write_to_fsr: process(curr_state) begin
			if (curr_state = STORE and address = FSR_ADDRESS) then
				fsr <= ALU_RES;
			end if;
		end process;

		read_ram_data: process(curr_state) begin		
			if (curr_state = READ) then
				if (address = fsr_address) then
					data <= fsr;
				else
					data <= RAM_DATA;
				end if;
			end if;
		end process;
		
		update_alu_enable: process(curr_state) begin		
			ALU_EN <= to_std_logic(curr_state = ADD or curr_state = SUB or curr_state = INC or curr_state = DEC or curr_state = LOAD);
		end process;

		ROM_ADDR <= instruction_pointer;
		RAM_DATA <= ALU_RES when RAM_WE = '1' else (others => 'Z');
		ALU_OPERAND <= data;
		ALU_OPERATION <= operation;
	end beh;
