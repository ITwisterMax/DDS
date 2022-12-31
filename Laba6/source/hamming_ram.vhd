library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity hamming_ram is
	generic (
		word_size: integer := 4;
		address_size: integer := 2
	);
	port (
		CLK: in std_logic;
		WE: in std_logic;
		AB: in std_logic_vector(address_size - 1 downto 0);
		DB: inout std_logic_vector(word_size - 1 downto 0);
		ERR: out std_logic
	);
end hamming_ram;

architecture beh of hamming_ram is	 
	type ram_type is array(0 to 2 ** address_size - 1) of std_logic_vector(word_size + 2 downto 0);

	signal ram_storage: ram_type;
	signal address_value: integer range 0 to 2 ** address_size - 1;

	begin
		address_value <= conv_integer(unsigned(AB));
		
		write_data: process(CLK, DB, ram_storage, address_value, WE)
			variable r1, r2, r3: std_logic;
		begin	
			if WE = '1' then	
				if rising_edge(CLK) then   
					r1 := DB(0) xor DB(1) xor DB(2);
					r2 := DB(1) xor DB(2) xor DB(3);
					r3 := DB(0) xor DB(1) xor DB(3);
					ram_storage(address_value) <= r3 & r2 & r1 & DB;
				end if;
			end if;
		end process;
		
		read_data: process(CLK, DB, ram_storage, address_value, WE)
			variable S1, S2, S3: std_logic;
			variable temp: std_logic_vector(word_size + 2 downto 0);
		begin
			if WE = '0' then
				if rising_edge(CLK) then   
					temp := ram_storage(address_value);
					s1 := temp(0) xor temp(1) xor temp(2) xor temp(word_size);
					s2 := temp(1) xor temp(2) xor temp(3) xor temp(word_size + 1);
					s3 := temp(0) xor temp(1) xor temp(3) xor temp(word_size + 2);

					ERR <= s1 or s2 or s3;
					DB <= temp(word_size - 1 downto 0);
				end if;
			else
				DB <= (others => 'Z');
			end if;
		end process;
	end beh;
