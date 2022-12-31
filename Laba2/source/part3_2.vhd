library ieee;
use ieee.std_logic_1164.all;

entity part3_2 is
   port(        					
      X, Y, Z: in std_logic; 
      F: out std_logic
   ); 
end part3_2;

architecture struct of part3_2 is
	component and3
		port(        					
			A, B, C: in std_logic; 
			Q: out std_logic
		);	
	end component;

	component and2
		port(        					
			A, B: in std_logic; 
			Q: out std_logic
		);	
	end component;

	component or3
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

	signal nX, nY, nZ, X_Z, nY_and_Z, nX_and_Y_and_nZ: std_logic;
	begin						  
		U1: inv port map(X, nX);
		U2: inv port map(Y, nY);
		U3: inv port map(Z, nZ);
		U4: and2 port map(X, Z, X_Z);
		U5: and2 port map(nY, Z, nY_and_Z);
		U6: and3 port map(nX, Y, nZ, nX_and_Y_and_nZ);
		U7: or3 port map(X_Z, nY_and_Z, nX_and_Y_and_nZ, F);
	end struct;

architecture beh of part3_2 is
	begin
		F <= (X and Z) or ((not Y) and Z) or ((not X) and Y and (not Z));
	end beh;