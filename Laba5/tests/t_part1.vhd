library ieee;
use ieee.std_logic_1164.all;

entity t_part1 is
end t_part1;

architecture t_architecture of t_part1 is
  component part1 is
		port(
			CLK: in std_logic;
			RST: in std_logic;
			IP: in std_logic_vector (3 downto 0);
			OP: out std_logic_vector (1 downto 0)
		);
	end component;

	signal CLK: std_logic;
	signal RST: std_logic;
	signal IP: std_logic_vector (3 downto 0);
	signal OP: std_logic_vector (1 downto 0);

	type states_type is (
		S0, S1, S2, S3, S4
	);

	signal curr: states_type;

	constant delay: time := 1 ps;

	begin
		U1: part1 port map (
			CLK => CLK,
			RST => RST,
			IP => IP,
			OP => OP
		);

		main: process begin
			CLK <= '0';
			wait for delay;

			RST <= '1';
			IP <= "0000";
			curr <= S0;
			wait for delay;

			CLK <= '1';
			wait for 2 * delay;

			CLK <= '0';
			wait for delay;

			RST <= '0';
			wait for delay;

			curr <= S1;
			CLK <= '1';
			wait for 2 * delay;

			CLK <= '0';
			wait for delay;

			IP <= "1101";
			wait for delay;

			curr <= S2;
			CLK <= '1';
			wait for 2 * delay;

			CLK <= '0';   
			wait for delay;

			IP <= "0001";
			wait for delay;

			curr <= S4;
			CLK <= '1';
			wait for 2 * delay;

			CLK <= '0';   
			wait for delay;

			IP <= "1001";
			wait for delay;

			curr <= S2;
			CLK <= '1';
			wait for 2 * delay;

			CLK <= '0';          
			wait for delay;

			IP <= "1111";
			wait for delay;

			curr <= S3;
			CLK <= '1';
			wait for 2 * delay;
		end process;
	end t_architecture;
