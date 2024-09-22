library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity onescounter_tb is
-- Entidade vazia tb
end entity;

architecture tb of onescounter_tb is

	-- Device Under Testing
	component onescounter
		port(
		-- UC
		clock : in bit;
		reset : in bit;
		start : in bit;
		done  : out bit;
		-- FD
		inport  : in bit_vector(14 downto 0);
		outport : out bit_vector(3 downto 0)
	);
	end component;

	-- Sinais que entrarão no componente
	signal clk_in	:	bit := '0';
	signal reset_in	:	bit := '0';
	signal start_in	:	bit := '0';
	signal done_out	:	bit := '0';

	signal inp_sig	:	bit_vector(14 downto 0);
	signal out_sig	:	bit_vector(3 downto 0);

	-- Definições de clk
	signal keep_simulating 	: bit	:= '0';
	constant clockPeriod 	: time 	:= 1 ns;
	
	begin
	
	clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;

	-- Conexão de DUT
	dut: onescounter
		port map(
			clock => clk_in,
			reset => reset_in,
			start => start_in,
			done  => done_out,
			
			inport  => inp_sig,
			outport => out_sig
		);
		
	papitations: process is
		-- Leitura
		file tb_file : text open read_mode is "sample.txt";
			variable tb_line	:	line;
			variable space		:	character;
			variable ip		:	bit_vector(14 downto 0);
			variable op		:	bit_vector(3 downto 0);
		begin 
		-- assert false report "Vou passar cerol na mão" severity note;
		
		keep_simulating <= '1';
		
		while not endfile(tb_file) loop
			readline(tb_file, tb_line);
			read(tb_line, ip);
			read(tb_line, space);
			read(tb_line, op);
				
				reset_in <= '1';
				wait until rising_edge(clk_in);
				reset_in <= '0';		

				inp_sig <= ip;
				wait until rising_edge(clk_in);
				start_in <= '1';
				wait until rising_edge(clk_in);
				start_in <= '0';
				wait until done_out='1';

				assert out_sig = op report "Erro na contagem de " & integer'image(to_integer(unsigned(op))) severity error;
			end loop;

		assert false report "Sucesso!" severity note;
		
		keep_simulating <= '0';
		wait;
	end process;
end architecture;
