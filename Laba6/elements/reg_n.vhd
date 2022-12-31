library ieee;
use ieee.std_logic_1164.all;

entity reg_n is
	generic (
		n: integer := 4 
	);
	
	port (
		Din: in std_logic_vector(n - 1 downto 0);
		EN: in std_logic;
		INIT: in std_logic;
		CLK: in std_logic;
		OE: in std_logic;
		Dout: out std_logic_vector(n - 1 downto 0)
	);
end reg_n;

architecture beh of reg_n is
	signal reg: std_logic_vector(n - 1 downto 0);
	constant NO_OUTPUT: std_logic_vector(n - 1 downto 0) := (others => 'Z');

	begin
		write_data: process(Din, EN, INIT, CLK, OE) begin
			if INIT = '1' then
				reg <= (others => '0');
			elsif EN = '1' then
				if rising_edge(CLK) then
					reg <= Din;
				end if;
			end if;
		end process;

		read_data: process(Din, EN, INIT, CLK, OE) begin
			if rising_edge(CLK) then
				if OE = '1' then
					Dout <= reg;
				else
					Dout <= NO_OUTPUT;
				end if;
			end if;
		end process;
	end beh;	