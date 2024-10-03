-- Completar com código do port do tb
entity testbench is

end testbench;
--hellooo
-- Completar com os sinais e componentes a serem utilizados
architecture beh of testbench is
	signal clk, run : bit;
	
begin
	-- Gerar o clock
	clk <= ((not clk) and run) after 10 ns;
	-- Instanciar o DUT
	DUT:

	-- Caso teste
	process
	begin 
		run <= 1;
		
		run <= 0;
		wait;
	end process;
end beh;

