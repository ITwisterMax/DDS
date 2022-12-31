library ieee;
use ieee.std_logic_1164.all;

entity t_rs_latch is
end t_rs_latch;

architecture t_architecture of t_rs_latch is
	component rs_latch
		port(
			R: in std_logic;
			S: in std_logic;
			Q: out std_logic;
			nQ: out std_logic 
		);
	end component;

	signal R: std_logic;
	signal S: std_logic;

	signal Q1: std_logic;
	signal nQ1: std_logic;	 

	signal Q2: std_logic;
	signal nQ2: std_logic;

	signal Q3: std_logic;
	signal nQ3: std_logic;	
	
	begin
		U1: entity work.rs_latch(struct) port map (
			R => R,
			S => S,
			Q => Q1,
			nQ => nQ1
		);
		
		U2: entity work.rs_latch(beh) port map (
			R => R,
			S => S,
			Q => Q2,
			nQ => nQ2
		);
		
		U3: entity work.rs_latch(param) port map (
			R => R,
			S => S,
			Q => Q3,
			nQ => nQ3
		);

		simulate: process begin
			R <= '0';
			S <= '0';
			wait for 10 ps;	 
			
			R <= '1';
			S <= '0';
			wait for 10 ps;	
			
			R <= '0';
			S <= '0';
			wait for 10 ps;	 
			
			R <= '0';
			S <= '1';
			wait for 10 ps;	  
			
			R <= '0';
			S <= '0';
			wait for 10 ps;		
			
			R <= '1';
			S <= '1';
			wait for 10 ps;	
			
			R <= '0';
			S <= '0';
			wait for 10 ps;
		end process;
	end t_architecture;
