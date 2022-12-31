library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity t_part4 is
end t_part4;

architecture t_architecture of t_part4 is
	component sum2
		port(
			A, B: in std_logic_vector(1 downto 0);
			S: out std_logic_vector(1 downto 0);
			C: out std_logic
		);
	end component;

	signal A: std_logic_vector(1 downto 0) := "00";
	signal B: std_logic_vector(1 downto 0) := "00";

	signal S_1: std_logic_vector(1 downto 0);
	signal C_1: std_logic;

	signal S_2: std_logic_vector(1 downto 0);
	signal C_2: std_logic;

	signal error: std_logic;

	begin
		U1: entity work.sum2(beh) port map (
			A => A,
			B => B,
			S => S_1,
			C => C_1
		);

		U2: entity work.sum2(struct) port map (
			A => A,
			B => B,
			S => S_2,
			C => C_2
		);

		error <= '0' when S_1 = S_2 and C_1 = C_2 else '1';							 

		A <= A + "1" after 1 ps;
		B <= B + "1" after 4 ps;

	end t_architecture;