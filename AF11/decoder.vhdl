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
	process is
	begin
		for i in 0 to n-1 loop
			if (to_integer(unsigned(input)) = i)  then
				output(i) <= '1';
			else 
				output(i) <=  '0';
			end if;		
		end loop;
		wait;
	end process;
end architecture;



