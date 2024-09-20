library ieee;
entity onescounter is
	-- Não gosto dessa descrição, pois poderíamos economizar nas declarações com
	-- clock,reset,start, done : in bit; 
	port(
		clock : in bit;
		reset : in bit;
		start : in bit;
		inport : in bit_vector(14 downto 0);
		outport : out bit_vector(3 downto 0);
		done: out bit;
	);
end entity;
