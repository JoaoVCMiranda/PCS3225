library ieee;
use ieee.numeric_bit.all;

entity mux is
	generic(n : natural);
	port(
		sel : in bit_vector(n-1 downto 0);
		input: in bit_vector(2**n-1 downto 0);
		output: out bit
	    );
end entity;

architecture structural of mux is
	signal interno: bit;
begin 
	output <= interno;
	interno <= input(to_integer(unsigned(sel)));
end architecture structural;
