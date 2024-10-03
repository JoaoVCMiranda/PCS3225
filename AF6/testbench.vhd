library IEEE;
use ieee.numeric_bit.all;

entity testbench is
	-- Em geral testbench são vazias
end testbench;

-- Completar com os sinais e componentes a serem utilizados
architecture beh of testbench is
	signal clk : bit := '0'; 
	signal run : bit;
	component log is
		port(
			clock,inicio : in bit;
			x : in bit_vector(7 downto 0 );
			R : out bit_vector(7 downto 0 );
			fim : out bit
		);
	end component;
	-- Signals
	signal start 	: bit;
	signal EX 	: bit_vector(7 downto 0 ) ;
	signal AR 	: bit_vector(7 downto 0 ) ;
	signal ender 	: bit

	
begin
	-- Gerar o clock
	clk <= ((not clk) and run) after 10 ns;
	-- Instanciar o DUT
	DUT: log port map(
			clock 	=> clk;
			inicio 	=> start;
			x 	=> EX;
			R 	=> AR;
			fim 	=> ender
			);

	-- Casos teste
	process
	begin 
		run <= 1;
		start <= '1';
		EX <= "11110000";
		wait until ender = '1';
		assert (AR = "01001010") report "Erro detectado.";
		run <= 0;
		wait;
	end process;
end beh;

