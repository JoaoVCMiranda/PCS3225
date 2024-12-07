library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity rom_generic is
	generic (
    	address_size   : natural := 5;
        word_size      : natural := 8;
        data_file_name : string  := ".dat"
    );
    port (
    	clk      : in  bit;
        wr       : in  bit;
        address  : in  bit_vector (address_size - 1 downto 0);
        data_in  : in  bit_vector (word_size - 1    downto 0);
        data_out : out bit_vector (word_size - 1    downto 0)
    );
end entity rom_generic;
    
architecture arch_rom of rom_generic is
    
    constant depth : natural := 2 ** address_size;

    type memory_type is array (0 to depth - 1) of bit_vector(word_size - 1 downto 0);
    
    impure function inicializa(nome_do_arquivo : in string) return memory_type is
	  file     arquivo  : text open read_mode is nome_do_arquivo;
	  variable linha    : line;
	  variable temp_bv  : bit_vector(word_size-1 downto 0);
	  variable temp_mem : memory_type;
	  begin
	    for i in mem_t'range loop
	      readline(arquivo, linha);
	      read(linha, temp_bv);
	      temp_mem(i) := temp_bv;
	    end loop;
	    return temp_mem;
    end;
    signal memory : memory_type := inicializa(data_file_name);

begin
	-- ROM ASYNC
    	data_out <= memory(to_integer(unsigned(address)));
end arch_rom;
