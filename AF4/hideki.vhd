library IEEE;
use ieee.numeric_bit.rising_edge;
use ieee.numeric_bit.all;

--deslocador15bits
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
    
    signal internal: bit_vector(14 downto 0) := (others => '0');
    
    begin
        saida <= internal;
        process(clock)
        begin
            
        if (rising_edge(clock)) then
            if (limpa = '1') then internal <= (others => '0');
            elsif (carrega ='1') then internal <= dados;
            elsif (desloca = '1') then 
                internal(13 downto 0) <= internal(14 downto 1);
                internal(14) <= entrada;
            end if;
        end if;
        
        end process;
    end architecture;




        
    --contador4bits
    entity contador4 is
        port (
            clock : in bit;
            zera  : in bit;
            conta : in bit;
            Q     : out bit_vector(3 downto 0);
            fim   : out bit
        );
    end entity contador4;
    

    architecture myContador4 of contador4 is
        
        signal internal : bit_vector(3 downto 0) := "0000";
        
        begin 
        Q <= internal;
        process(clock)
        begin
            
            if(rising_edge(clock)) then
                if (zera = '1') then internal <= "0000";
                elsif (conta = '1') then internal <= bit_vector(unsigned(internal) + 1);
                end if;
                if (internal = "1111") then fim <= '1';
                end if;
            end if;
            
         end process;
         end architecture; 
