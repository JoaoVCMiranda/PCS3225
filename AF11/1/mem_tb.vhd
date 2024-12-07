
library ieee;
use ieee.numeric_bit.all;

entity rom_generic is
end entity rom_generic;
    
architecture arch_rom of rom_generic is
---------------------------------------------------------------------------
    component rom_generic
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
    end component rom_generic;
---------------------------------------------------------------------------
    component ram_generic
    generic (
    	address_size   : natural := 5;
        word_size      : natural := 8;
    );
    port (
    	clk      : in  bit;
        wr       : in  bit;
        address  : in  bit_vector (address_size - 1 downto 0);
        data_in  : in  bit_vector (word_size - 1    downto 0);
        data_out : out bit_vector (word_size - 1    downto 0)
    );
    end component ram;
---------------------------------------------------------------------------
begin
-------------------CARREGAMENTO DA MEMÓRIA DE DADOS------------------------
--- Instanciar a RAM
--- Carregar os dados
---------------------------------------------------------------------------
-------------------CARREGAMENTO DA MEMÓRIA DE INSTRUÇÕES-------------------
--- Apenas vincular o arquivo na area generic
---------------------------------------------------------------------------

-------------------------------ROM-----------------------------------------
--- Testar para ver se está de acordo
---------------------------------------------------------------------------

-------------------------------RAM-----------------------------------------
--- Testar para ver se está de acordo
---------------------------------------------------------------------------
	
end arch_rom;
