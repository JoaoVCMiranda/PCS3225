library ieee;
use ieee.numeric_bit.all;

entity adder8 is
   port (
      	a:         in  bit_vector(7 downto 0);
	b:         in  bit_vector(7 downto 0);
	sum:       out bit_vector(7 downto 0);
	carry_out: out bit
   );
end adder4bits;

architecture adder8_arch of adder4bits is
   signal sum_c: bit_vector(8 downto 0);  -- sinal interno que captura o carry
begin
   sum_c <= bit_vector(unsigned('0' & a) + unsigned('0' & b));  -- operandos e resultado com 5 bits (1 a mais que as entradas e saída)
   sum   <= sum_c(7 downto 0);      -- associa a saída 'sum' aos 4 bits menos significativos do sinal interno 'sum_c'
   carry_out <= sum_c(8);           -- associa a saída 'carry_out' ao bit mais significativo do sinal interno 'sum_c'
end adder8_arch;
