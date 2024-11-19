library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity ram_generic is
	generic (
    	address_size   : natural := 5;
        word_size      : natural := 8;
        data_file_name : string  := "ram32x8.dat"
    );
    port (
    	clk      : in  bit;
        wr       : in  bit;
        address  : in  bit_vector (address_size - 1 downto 0);
        data_in  : in  bit_vector (word_size - 1    downto 0);
        data_out : out bit_vector (word_size - 1    downto 0)
    );
end entity ram_generic;
    
architecture arch_ram of ram_generic is
  	constant depth : natural := 2 ** address_size;

    type memory_type is array (0 to depth - 1) of bit_vector(word_size - 1 downto 0);
    signal memory : memory_type;

begin
    process (clk)
    begin
		if (clk = '1' and clk'event) then
    		if (wr = '1') then
        		memory(to_integer(unsigned(address))) <= data_in;
       		end if;
 		end if;
    end process;
    
    	data_out <= memory(to_integer(unsigned(address)));
end arch_ram;