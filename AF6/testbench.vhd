library IEEE;
use ieee.numeric_bit.all;

entity testbench is
	-- Em geral testbench são vazias
end testbench;

-- Completar com os sinais e componentes a serem utilizados
architecture beh of testbench is
	signal clk, run : bit;
	component log is
		port(
			clock,inicio : in bit;
			x : in bit_vector(7 downto 0 );
			R : in bit_vector(7 downto 0 );
			fim : out bit
		);
	end component;
	
begin
	-- Gerar o clock
	clk <= ((not clk) and run) after 10 ns;
	-- Instanciar o DUT
	DUT:

	-- Casos teste
	process
	begin 
		run <= 1;
		
		run <= 0;
		wait;
	end process;
end beh;

