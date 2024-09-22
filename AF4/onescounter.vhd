library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fd is
    port(
        inport : in bit_vector(14 downto 0);
        outport : out bit_vector(3 downto 0);
        clock : in bit;
        shift, load, resetRG, zera, conta : in bit;
        NUL, LSB : out bit
    );
end fd;

architecture arch of fd is 

    component deslocador15 is
    port (
        clock   : in bit;
        limpa   : in bit;
        carrega : in bit;
        desloca : in bit;
        entrada : in bit;
        dados   : in bit_vector (14 downto 0);
        saida   : out bit_vector (14 downto 0)
    );    
    end component;

    component contador4 is
        port (
            clock : in bit;
            zera  : in bit;
            conta : in bit;
            Q     : out bit_vector(3 downto 0);
            fim   : out bit
        );
    end component;
    
    signal internal: bit_vector(14 downto 0) := inport;
    signal ocount: bit_vector(3 downto 0) := (others=>'0');
    signal nully : bit := '0';
    signal fimcont: bit := '0';

begin
    LSB <= internal(0);
    NUL <= '1' when (internal = "000000000000000" or fimcont = '1') else '0';
    nully <= '1' when (internal = "000000000000000" or fimcont = '1') else '0';
    outport <= ocount when nully = '1' else "0000";

    XDesclocador: deslocador15 port map (clock, resetRG, load, shift, '0', inport, internal); 
    xContador: contador4 port map (clock, zera, conta, ocount, fimcont);
end architecture; 

entity uc is
    port(
        start : in bit;
        load, shift, conta : out bit;
        NUL, LSB : in bit;
        clock, reset : in bit;
        done, zera, resetRG : out bit
    );
end uc;

architecture arch of uc is

    type state_type is (A, B, C, D, E, F);
    signal present_state, next_state : state_type;

begin
    
    process (reset, clock) is
        begin
            if(reset = '1') then
                present_state <= A;
            elsif(clock'event and clock = '1') then
                present_state <= next_state;
            end if;        
    end process;
    
    next_state <=
                A when (present_state = A) and (start = '0') else
                B when (present_state = A) and (start = '1') else
                C when (present_state = B) else
                D when (present_state = C) and (LSB = '1') else
                E when (present_state = C) and (LSB = '0') else
                E when (present_state = D) else
                C when (present_state = E) and (NUL = '0') else
                F when (present_state = E) and (NUL = '1') else
                A when (present_state = F);

    process (present_state) is
    begin 
        case present_state is
             when A =>
                 done <= '0';
                 load <= '0';
                 shift <= '0';
                 conta <= '0';
                 zera <= '1';
                 resetRG <= '1';
             when B =>
                 resetRG <= '0';
                 load <= '1';
                 zera <= '1';
             when C =>
                 load <= '0';
                 zera <= '0';
                 shift <= '0';
                 conta <= '0';
             when D =>
                 conta <= '1';
             when E =>
                 conta <= '0';
                 shift <= '1';
             when F =>
                 done <= '1';
    end case;
    end process;
end architecture;


          
entity onescounter is
port (
    clock    : in bit;
    reset    : in bit;
    start    : in bit;
    inport   : in bit_vector(14 downto 0);
    outport  : out bit_vector(3 downto 0);
    done     : out bit
    );
end entity;

architecture strutcture of onescounter is 
    
    component uc is
    port(
        start : in bit;
        load, shift, conta : out bit;
        NUL, LSB : in bit;
        clock, reset : in bit;
        done, zera, resetRG : out bit
    );
    end component;

    component fd is
    port(
        inport : in bit_vector(14 downto 0);
        outport : out bit_vector(3 downto 0);
        clock : in bit;
        shift, load, resetRG, zera, conta : in bit;
        NUL, LSB : out bit
    );
    end component;

    signal shift, load, resetRG, zera, conta, NUL, LSB : bit;

    begin 
        Xfd: fd port map (inport, outport, clock, shift, load, resetRG, zera, conta, NUL, LSB);
        Xuc: uc port map (start, load, shift, conta, NUL, LSB, clock, reset, done, zera, resetRG);
end architecture;
      
      
library IEEE;
use ieee.numeric_bit.rising_edge;
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
    
    signal internal: bit_vector(14 downto 0) := (others => '0');
    
    begin
        saida <= internal;
        process(clock)
        begin
            
        if (rising_edge(clock)) then
            if (limpa = '1') then internal <= (others => '0');
            elsif (carrega = '1') then internal <= dados;
            elsif (desloca = '1') then 
                internal(13 downto 0) <= internal(14 downto 1);
                internal(14) <= entrada;
            end if;
        end if;
      
        end process;
    end architecture;

library IEEE;
use ieee.numeric_bit.rising_edge;
use ieee.numeric_bit.all;

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

    signal internal: bit_vector(3 downto 0) := "0000";

    begin 
    Q <= internal;
    process(clock)
    begin

        if (rising_edge(clock)) then
            if (zera = '1') then internal <= "0000";
                elsif (conta = '1') then internal <= bit_vector(unsigned(internal) + 1);
            end if;
            if (internal = "1111") then fim <= '1';
                else fim <= '0';
             end if;
        end if;

     end process;
end architecture;  
