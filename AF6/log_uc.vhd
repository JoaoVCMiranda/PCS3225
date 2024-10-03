library IEEE;
use ieee.numeric_bit.all;

entity log_uc is

end log_uc;

architecture arch of log_uc is
	component adder8 is
	port (
		a:         in  bit_vector(7 downto 0);
		b:         in  bit_vector(7 downto 0);
		sum:       out bit_vector(7 downto 0);
		carry_out: out bit
   	);
	end component;
	
begin
	SUM8: adder8 port map(a =>, b=>, sum=>, carry_out=>)
	

end architecture;
