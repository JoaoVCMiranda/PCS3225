library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--fluxo de dados
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
    
    signal internal: bit_vector(14 downto 0) := dados;
    signal ocount: bit_vector(3 downto 0) := (others=>'0');
    signal fimcont: bit := 0;

begin
    LSB <= internal(0);
    NUL <= '1' when (internal = (others=>'0') or fimcont = '1') else '0';
    outport <= ocount when NUL = '1' else "0000";

    XDesclocador: deslocador15 port map (clock, resetRG, load, shift, '0', dados, internal); 
    xContador: contador4 port map (clock, zera, conta, ocount, fimcont);
end architecture; 

--fim do fluxo de dados

--unidade de controle
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
--CHECAR LOGICA DE TRANSICAO DE ESTADO COM O NUL
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

    process (current_state) is
    begin 
        case current_state is
             when A =>
                 done <= '0';
                 load <= '0';
                 shift <= '0';
                 conta <= '0';
                 zera <= '0';
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
    end process;
end architecture;

--uart
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

end onescounter;
architecture strutcture of onescounter is 
        --sinais internos de controle
        signal NUL, EC, ED, Shift : bit;
    
        begin 
            fd: entity work.fd port map();

            uc: entity work.uc port map();
end architecture;
