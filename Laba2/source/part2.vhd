library ieee;
use ieee.std_logic_1164.all;
 
entity mux2x2 is
   port(        					
      A, B, A1, B1, S: in std_logic; 
      Z, Z1: out std_logic
   );
end mux2x2;

architecture struct of mux2x2 is
	component mux2 is
		port(
			A, B, S: in std_logic;
			Z: out std_logic
		);
	end component;
	begin	
		MUX0: mux2 port map(A, B, S, Z);
		MUX1: mux2 port map(A1, B1, S, Z1);
	end struct;