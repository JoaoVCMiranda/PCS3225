library ieee;
use ieee.numeric_bit.all;

entity mem_tb is
end entity mem_tb;
    
architecture arch_mem_tb of mem_tb is
----------------------------COMPONENTS-------------------------------------
---------------------------------------------------------------------------
    component rom_generic
    generic (
    	address_size   : natural := 5;
        word_size      : natural := 8;
        data_file_name : string  := ".dat"
    );
    port (
    	clk      : in  bit;
        address  : in  bit_vector (address_size - 1 downto 0);
        data_out : out bit_vector (word_size - 1    downto 0)
    );
    end component rom_generic;
---------------------------------------------------------------------------
    component ram_generic
    generic (
    	address_size   : natural := 5;
        word_size      : natural := 8
    );
    port (
    	clk      : in  bit;
        wr       : in  bit;
        address  : in  bit_vector (address_size - 1 downto 0);
        data_in  : in  bit_vector (word_size - 1    downto 0);
        data_out : out bit_vector (word_size - 1    downto 0)
    );
    end component ;
---------------------------------------------------------------------------
----------------------------SIGNALS----------------------------------------
	signal 		clk   		: bit :='0';
	signal 		keepSimulating	: bit := '1';
	constant 	clockPeriod 	: time := 1 ns;
	
	signal 		ram_wr		: bit;
	signal 		ram_adr		: bit_vector(7 downto 0);
	signal 		ram_din		: bit_vector(63 downto 0);
	signal 		ram_dot		: bit_vector(63 downto 0);

	signal 		rom_adr		: bit_vector(7 downto 0);
	signal 		rom_dot		: bit_vector(31 downto 0);
---------------------------------------------------------------------------
begin
----------------------------DEFAULTS---------------------------------------
	clk <= not(clk) and keepSimulating after clockPeriod/2;	
---------------------------------------------------------------------------
-------------------CARREGAMENTO DA MEMÓRIA DE DADOS------------------------
--- Instanciar a RAM
	ram64x8 : ram_generic
	generic map(8;64)
	port map(
		clk=>clk;
		wr=>ram_wr;
		address=>ram_adr;
		data_in=>ram_din;
		data_out=ram_dot
	);
--- Carregar os dados
	file     arquivo  : text open read_mode is "64x8_DADOS.dat";
	variable linha    : line;
	variable temp_bv  : bit_vector(7 downto 0);
	begin
	  for i in 1 to 2**8 loop
	    readline(arquivo, linha);
	    read(linha, ram_din);
	    
	    ram_wr <= '1';
	    wait for clockPeriod;
	    ram_wr <='0';
	end loop;
---------------------------------------------------------------------------
-------------------CARREGAMENTO DA MEMÓRIA DE INSTRUÇÕES-------------------
--- Apenas vincular o arquivo na area generic
	rom32x8 : rom_generic
	generic map(8;32;"32x8_INSTR.dat")
	port map(
		clk=>clk;
		address=>rom_adr;
		data_out=rom_dot
	);
---------------------------------------------------------------------------
-------------------------------ROM-----------------------------------------
--- Testar para ver se está de acordo

assert false report "aroh od uap" severity note;
--- Quais são os casos teste interessantes ?

    casos_teste_interessantes : process is
	  
    type rom_type is record
     	 -- Entradas
	 address: bit_vector(7 downto 0);
	 -- Saídas
	 palavra: bit_vector(31 downto 0);
    end record;
	  
	  type rom_array is array (natural range <>) of rom_type;
	  
	  constant rom_patterns: rom_array :=
		 (("00000000","11111000010000000000001111100001"),
		  ("00000001","11111000010000001000001111100010"),
		  ("00000010","11111000010000010000001111100011"),
		  ("00000011","11001011000000110000000001000100"),
		  ("00000100","10110100000000000000000011100100"),
		  ("00000101","10001010000000010000000010000101"),
		  ("00000110","10110100000000000000000001100101"),
		  ("00000111","11001011000000100000000001100011"),
		  ("00001000","00010111111111111111111111111011"),
		  ("00001001","11001011000000110000000001000010"),
		  ("00001010","00010111111111111111111111111001"),
		  ("00001011","11111000000000001000001111100010"),
		  ("00001100","00010100000000000000000000000000"));
    begin
	-- Para cada padrao de teste no vetor
	for i in rom_patterns'range loop
         	-- Injeta as entradas
         	rom_adr <= rom_patterns(i).address;
         	-- Aguarda que o modulo produza a saida
         	wait for clockPeriod;
         	--  Verifica as saidas
         	assert rom_dot = rom_patterns(i).palavra 
		report "Miou na palavra " & rom_dot & " da linha " & 
		integer'image(1+to_integer(unsigned(rom_patterns(i).address))) 
		severity error;
	end loop;

	-- Informa fim do teste
	assert false report "ROM OK" severity note;	  
   end process;
---------------------------------------------------------------------------
-------------------------------RAM-----------------------------------------
--- Testar para ver se está de acordo

assert false report "aroh od uap 2" severity note;
--- Quais são os casos teste interessantes ?

    casos_teste_interessantes : process is
	  
    type pattern_type is record
     	 -- Entradas
	 address: bit_vector(7 downto 0);
	 -- Saídas
	 palavra: bit_vector(63 downto 0);
    end record;
	  
	  type pattern_array is array (natural range <>) of pattern_type;
	  
	  constant patterns: pattern_array :=
		 (("00000000","1000000000000000000000000000000000000000000000000000000000000000"),
		  ("00000001","0000000000000000000000000000000000000000000000000000000000001001"),
		  ("00000010","0000000000000000000000000000000000000000000000000000000000001111"));
    begin
	-- Para cada padrao de teste no vetor
	for i in patterns'range loop
         	-- Injeta as entradas
         	ram_adr <= patterns(i).address;
         	-- Aguarda que o modulo produza a saida
         	wait for clockPeriod;
         	--  Verifica as saidas
         	assert ram_dot = patterns(i).palavra 
		report "Miou na palavra " & rom_dat & " da linha " & 
		integer'image(1+to_integer(unsigned(patterns(i).address))) 
		severity error;
	end loop;

	-- Informa fim do teste
	assert false report "RAM OK" severity note;	  
   end process;
---------------------------------------------------------------------------
	
end arch_mem_tb;
