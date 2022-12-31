library ieee;
use ieee.std_logic_1164.all;

entity part3_1 is
   port(        					
      X, Y, Z: in std_logic; 
      F: out std_logic
   ); 
end part3_1;

architecture struct of part3_1 is
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

	component or2
		port(        					
			A, B: in std_logic; 
			Q: out std_logic
		);	
	end component;

	component inv
		port(
			A: in std_logic;
			nA: out std_logic
		);
	end component;

	signal nX, nY, nZ, X_or_nY, X_or_nY_and_Z, nX_and_Y_and_nZ: std_logic;
	begin						  
		U1: inv port map(X, nX);
		U2: inv port map(Y, nY);
		U3: inv port map(Z, nZ);
		U4: or2 port map(X, nY, X_or_nY);
		U5: and2 port map(X_or_nY, Z, X_or_nY_and_Z);
		U6: and3 port map(nX, Y, nZ, nX_and_Y_and_nZ);
		U7: or2 port map(X_or_nY_and_Z, nX_and_Y_and_nZ, F);
	end struct;

architecture beh of part3_1 is
	begin
		F <= ((X or not Y) and Z) or (not X and Y and not Z);
	end beh;