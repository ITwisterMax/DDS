library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.utils.all;

entity alu is
	port(
		EN: in std_logic;
		OPERATION: in operation_word;
		OPERAND: in data_word;
		RES: out data_word;
		ZF: out std_logic;
		SB: out std_logic
	);
end alu;

architecture beh of alu is
	signal accumulator: data_word;

	signal add_result: data_word;
	signal sub_result: data_word;

	signal inc_result: data_word;
	signal dec_result: data_word;

	signal zero, sign: std_logic;

	begin	
		add_result <= accumulator + OPERAND;
		sub_result <= accumulator - OPERAND;

		inc_result <= accumulator + "1";
		dec_result <= accumulator - "1";
		
		perform_operation: process(EN, OPERATION, OPERAND, add_result, sub_result, inc_result, dec_result) begin
			if rising_edge(EN) then
				case OPERATION is
					when OP_LOAD => accumulator <= OPERAND;
					when OP_ADD => accumulator <= add_result;
					when OP_SUB => accumulator <= sub_result;
					when OP_INC => accumulator <= inc_result;
					when OP_DEC => accumulator <= dec_result;
					when others => NULL;
				end case;
			end if;
		end process;
		
		set_flags: process(accumulator) begin		
			if accumulator = (accumulator'range => '0') then
				zero <= '1';
			else
				zero <= '0';
			end if;

			sign <= accumulator(7);
		end process;
		
		RES <= accumulator;
		ZF <= zero;
		SB <= sign;
	end beh;
