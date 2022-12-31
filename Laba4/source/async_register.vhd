library ieee;
use ieee.std_logic_1164.all;

entity async_register is generic (n: integer := 8);
	port (
		Din : in std_logic_vector(n - 1 downto 0);
		EN: in std_logic;
		Dout: out std_logic_vector(n - 1 downto 0)
		);
end async_register;

architecture struct of async_register is
	component d_latch_enable
		port (
			D, E: in std_logic;
			Q: out std_logic
		);
	end component;

	begin
		U1: for i in n - 1 downto 0 generate
			U2: entity work.d_latch_enable(beh) port map (
				D => Din(i),
				E => EN,
				Q => Dout(i)
			);
		end generate;	
	end struct;

architecture beh of async_register is
	begin
		Dout <= Din when EN = '1';
	end beh;
