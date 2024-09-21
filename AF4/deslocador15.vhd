library IEEE;
use ieee.numeric_bit.all;

entity deslocador15 is
    port (
        clock   : in bit;
        limpa   : in bit;
        carrega : in bit;
        desloca : in bit;
        entrada : in bit;
        dados   : in bit_vector (14 downto 0);
        saida   : out bit_vector (14 downto 0)
    );    
end entity deslocador15;

architecture mydeslocador15 of deslocador15 is
    process(clock) is
    begin
        if(clock'event and clock = '1') then
            if(ED = '1') then
                internal <= (inport);
            elsif(Shift = '1') then
                internal <= ('0' & internal(14 downto 1));
            end if;
        end if;
    end process;

end architecture;
