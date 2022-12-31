library ieee;
use ieee.std_logic_1164.all;

entity part3_3 is
	port(        					
		G_L, A, B: in std_logic; 
		Y0_L, Y1_L, Y2_L, Y3_L: out std_logic
	); 
end part3_3;

architecture struct of part3_3 is
	component nand3
		port(        					
			A, B, C: in std_logic; 
			Q: out std_logic
		);
	end component;
	
	component inv
		port(
			A: in std_logic;
			nA: out std_logic
		);
	end component;
	
	signal nG_L, nA, nB: std_logic;
	begin						  
		U1: inv port map(G_L, nG_L);
		U2: inv port map(A, nA);
		U3: inv port map(B, nB);
		U4: nand3 port map(nA, nB, nG_L, Y0_L);
		U5: nand3 port map(A, nB, nG_L, Y1_L);
		U6: nand3 port map(nA, B, nG_L, Y2_L);
		U7: nand3 port map(A, B, nG_L, Y3_L);
	end struct;

architecture beh of part3_3 is
	begin
		Y0_L <= not ((not A) and (not B) and (not G_L));
		Y1_L <= not (A and (not B) and (not G_L));
		Y2_L <= not ((not A) and B and (not G_L));
		Y3_L <= not (A and B and (not G_L));
	end beh;