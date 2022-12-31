LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity sum2 is
	port(
		A, B: in std_logic_vector(1 downto 0);
		S: out std_logic_vector(1 downto 0);
		C: out std_logic
	);
end sum2;

architecture struct of sum2 is
	component sum1
		port(			
			A, B, C1: in std_logic;
			S,
			C: out std_logic
		);
	end component;

	component or2
		port(
			A, B: in std_logic;
			Q: out std_logic
		);
	end component;
	
	signal carry: std_logic;
	begin
		U1: sum1 port map (
			A => A(0),
			B => B(0),
			C1 => '0',
			S => S(0),
			C => carry
		);
		U2: sum1 port map (
			A => A(1),
			B => B(1),
			C1 => carry,
			S => S(1),
			C => C
		);
	end struct;

architecture beh of sum2 is
	signal carry: std_logic;
	begin
		S(0) <= A(0) xor B(0);
		carry <= A(0) and B(0);
		S(1) <= ((A(1) xor B(1)) and not carry) or (not (A(1) or B(1)) and carry) or (A(1) and B(1) and carry);
		C <= (A(1) and B(1) and not carry) or (carry and (A(1) or B(1)));
	end beh;