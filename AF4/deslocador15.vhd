library IEEE;
use ieee.numeric_bit.all;

entity deslocador15 is
    port (
        clock   : in bit;
    	en	: in bit;
        entrada : in bit;
        saida   : out bit_vector (14 downto 0)
    );    
end entity deslocador15;

architecture mydeslocador15 of deslocador15 is
	signal internal : bit_vector(14 downto 0);
	process(clock) is
		begin
		if(clock'event and clock = '1') then
			if(en = '1') then
				internal <= '0' & entrada(14 downto 1);
			else then
				internal <= entrada;
		    	end if;
		end if;
		saida <= internal;
	end process;

end architecture;
