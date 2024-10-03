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
			R : in bit_vector(7 downto 0 );
			fim : out bit
		);
	end component;
	-- Signals
	signal start 	: in bit;
	signal EX 	: in bit_vector(7 downto 0 ) ;
	signal AR 	: in bit_vector(7 downto 0 ) ;
	signal ender 	: out bit

	
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
		
		run <= 0;
		wait;
	end process;
end beh;

