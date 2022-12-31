library ieee;
use ieee.std_logic_1164.all;

entity sync_register is generic (n: integer := 8);
	port (
		Din : in std_logic_vector(n - 1 downto 0);
		EN: in std_logic;						   
		CLK : in std_logic;
		Dout: out std_logic_vector(n - 1 downto 0)
	);
end sync_register;

architecture struct of sync_register is
	component d_flip_flop_enable
		port (
			D, E, CLK: in std_logic;
			Q: out std_logic
		);
	end component;

	begin
		U1: for i in n - 1 downto 0 generate
			U2: entity work.d_flip_flop_enable(beh) port map (
				D => Din(i),
				E => EN,
				CLK => CLK,
				Q => Dout(i)
			);
		end generate;	
	end struct;

architecture beh of sync_register is
	signal result: std_logic_vector(n - 1 downto 0);

	begin
		main: process(Din, EN, CLK) begin
			if EN = '1' then
				if rising_edge(CLK) then
					result <= Din;
				end if;
			end if;
		end process;

		Dout <= result;
	end beh;