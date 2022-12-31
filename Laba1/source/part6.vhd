----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:23:47 09/27/2022 
-- Design Name: 
-- Module Name:    part6 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2x2 is
    Port ( A : in  STD_LOGIC_VECTOR(1 downto 0);
			  B : in  STD_LOGIC_VECTOR(1 downto 0);
           S : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR(1 downto 0));
end mux2x2;

architecture Behavioral of mux2x2 is

begin
	Q <= A when S='0' else B;
end Behavioral;

