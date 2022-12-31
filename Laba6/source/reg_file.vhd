library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_file is
	generic (
		reg_size: integer := 4;
		address_size: integer := 2
	);

	port (
		INIT: in std_logic;
		WDP: in std_logic_vector(reg_size - 1 downto 0);
		RDP: out std_logic_vector(reg_size - 1 downto 0);				   
		WA: in std_logic_vector(address_size - 1 downto 0);
		RA: in std_logic_vector(address_size - 1 downto 0);
		CLK: in std_logic 
	);
end reg_file;

architecture beh of reg_file is
	component reg_n is
		generic (
			n: integer := reg_size
		);

		port (
			Din: in std_logic_vector(reg_size - 1 downto 0);
			EN: in std_logic;
			INIT: in std_logic;
			CLK: in std_logic;
			OE: in std_logic;
			Dout: out std_logic_vector(reg_size - 1 downto 0)
		);
	end component;
	
	function decode (
		address_vector: in std_logic_vector(address_size - 1 downto 0)
	) return std_logic_vector is variable result: std_logic_vector(2 ** address_size - 1 downto 0);
	begin		
		result := (others => '0');
		result(conv_integer(unsigned(address_vector))) := '1';

		return result;
	end function;
	
	signal WE: std_logic_vector(2 ** address_size - 1 downto 0);
	signal RE: std_logic_vector(2 ** address_size - 1 downto 0);
	signal RD: std_logic_vector(reg_size - 1 downto 0);

	begin
		decode_WA: process(WA) begin
			WE <= decode(WA);
		end process;
		
		decode_RA: process(RA) begin
			RE <= decode(RA);
		end process;
		
		U1: for i in 2 ** address_size - 1 downto 0 generate
			U2: reg_n generic map(reg_size) port map(
				Din => WDP,
				EN => WE(i),
				INIT => INIT,
				CLK => CLK,
				OE => RE(i),
				Dout => RD
			);
		end generate;	 

		RDP <= RD;
	end;
