library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity traffic_light is
	port(
		CLK: in std_logic;
		CWAIT: in std_logic;
		RST: in std_logic;
		START: in std_logic;
		R, Y, G: out std_logic
	); 
end traffic_light;

architecture beh of traffic_light is
	type rom_type is array(0 to 15) of std_logic_vector(6 downto 0);

	constant rom: rom_type := (
		-- next state (current state + 1 if 0000) & lights state
		"0000" & "000",
		"0001" & "000",
		"0000" & "100",
		"0000" & "100",
		"0000" & "100",
		"0000" & "110",
		"0000" & "001",
		"0000" & "001",
		"0000" & "001",
		"0000" & "000",
		"0000" & "001",
		"0000" & "000",
		"0000" & "001",
		"0000" & "000",
		"0010" & "010",
		"1110" & "000"
	);

	signal next_state: std_logic_vector(3 downto 0);	
	
	signal curr_state: std_logic_vector(3 downto 0) := "0001";
	signal curr_command: std_logic_vector(6 downto 0);

	signal lights_state: std_logic_vector(2 downto 0);

	begin
		calc_next_state: process(START, CWAIT, curr_state, next_state, curr_command) begin		
			if (START = '1' and curr_state = "0001") then
				next_state <= "0010";
			elsif (CWAIT = '1' and curr_state = "1110") then
				next_state <= "1111";
			elsif (falling_edge(CWAIT) and (curr_state = "1110" or curr_state = "1111")) then
				next_state <= "1110";
			elsif (curr_command(6 downto 3) = "0000") then
				next_state <= curr_state + "1";
			else
				next_state <= curr_command(6 downto 3);
			end if;
		end process;  

		main: process(RST, CLK, curr_command) begin		
			if RST = '1' then
				curr_state <= "0001";
			elsif rising_edge(CLK) then
				curr_state <= next_state;
			end if;
		end process;		 
		
		lights_state <= curr_command(2 downto 0);
		curr_command <= rom(conv_integer(unsigned(curr_state)));

		R <= lights_state(2);
		Y <= lights_state(1);
		G <= lights_state(0);
	end beh;
