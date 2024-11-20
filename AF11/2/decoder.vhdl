library ieee;
use ieee.numeric_bit.all;

entity decoder is
	generic(n : natural);
	port(
		input :	in bit_vector(n-1 downto 0);
		output: out bit_vector(2**n-1 downto 0)
	    );
end entity decoder;

architecture structural of decoder is
begin 
	process(input)
	begin
		output <= (others => '0');
		output(to_integer(unsigned(input))) <= '1';
	end process;
end architecture;



