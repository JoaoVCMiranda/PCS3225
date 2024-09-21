library ieee;
entity onescounter is
	-- Não gosto dessa descrição, pois poderíamos economizar nas declarações com
	-- clock,reset,start, done : in bit; 
	port(
		-- UC
		clock : in bit;
		reset : in bit;
		start : in bit;
		done: out bit;
		-- FD
		inport : in bit_vector(14 downto 0);
		outport : out bit_vector(3 downto 0);
	);
end entity;
-- Somador pode ser substituído por registrador deslocador.

Ideias:

A entrada é vetor de 15 bits

Vamos usar um registrador contador de 4 bits para contar quantos 1's estão na entrada
