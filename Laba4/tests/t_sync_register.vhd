library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  

entity t_sync_register is generic (n: integer := 8);
end t_sync_register;

architecture t_architecture of t_sync_register is	
	component sync_register generic (n: integer := 8);
		port(
			Din: in std_logic_vector(n - 1 downto 0);
			EN: in std_logic;
			CLK: in std_logic;
			Dout: out std_logic_vector(n - 1 downto 0) 
		);
	end component;
	
	signal Din: std_logic_vector(n - 1 downto 0) := (others => '0');
	signal EN: std_logic := '1';
	signal CLK: std_logic := '0';
	
	signal Dout1: std_logic_vector(n - 1 downto 0);
	signal Dout2: std_logic_vector(n - 1 downto 0);
	
	constant size: integer := 8;
	constant period: time := 1 ps;

	begin
		U1: entity work.sync_register(beh) generic map (n => size) port map (
			Din => Din,
			EN => EN,	 
			CLK => CLK,
			Dout => Dout1
		);	
		
		U2: entity work.sync_register(struct) generic map (n => size) port map (
			Din => Din,
			EN => EN,		   
			CLK => CLK,
			Dout => Dout2
		);

		CLK <= not CLK after period;	
		Din <= Din + "1" after period * 2;
		
		change_EN: process begin
			EN <= '1';
			wait for period;

			EN <= '0';
			wait for period * 4;
		end process;
	end t_architecture;
