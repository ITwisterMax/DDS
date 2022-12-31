library ieee;
use ieee.std_logic_1164.all;

entity shift_register is generic (n: integer := 8);
	port(
		Sin: in std_logic;
		SE: in std_logic;
		CLK: in std_logic;
		RST: in std_logic;
		Dout: out std_logic_vector(0 to n - 1)
	);
end shift_register;				  

architecture beh of shift_register is
	signal S: std_logic_vector(0 to n - 1);

	begin
		main: process (CLK, RST, Sin, SE) begin
			if RST = '1' then
				S <= (others => '0');
			elsif rising_edge(CLK) then
				if SE = '1' then
					S <= Sin & S(0 to n - 2);
				end if;
			end if;
		end process;

		Dout <= S; 
	end beh;

architecture struct of shift_register is
	component d_flip_flop_ext is
		port (
			CLK: in std_logic;
			E: in std_logic;
			CLR: in std_logic;
			D: in std_logic;
			Q: out std_logic
		);
	end component;	
	
	signal S: std_logic_vector(0 to n - 1);

	begin			   
		U1: entity work.d_flip_flop_ext port map (
			CLK => CLK, 
			E => SE, 
			CLR => RST, 
			D => Sin,
			Q => S(0)
		);

		U2: for i in 1 to n - 1 generate			
			U3: entity work.d_flip_flop_ext port map (
				CLK => CLK,
				E => SE,
				CLR => RST,
				D => S(i - 1),
				Q => S(i)
			);
		end generate;
		
		Dout <= S;
	end struct;