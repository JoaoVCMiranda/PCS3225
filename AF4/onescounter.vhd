library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--fluxo de dados
entity fd is
    port(
        inport: in bit_vector(14 downto 0);
        outport : out bit_vector(3 downto 0);
        clock : in bit;
        Shift, EC, ED : in bit;
        NUL : out bit;
        LSB : out bit;
    );
end fd;

architecture arch of fd is 
    signal internal: bit_vector(14 downto 0);
    signal ocount: bit_vector(3 downto 0);
begin

    LSB <= internal(0);

    outport <= ocount when NUL = '1' else "0000";
    
    --registrador Deslocador
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

    --registrador Contador
    process(clock) is
    begin
        if(clock'event and clock = '1') then
            if(EC = '1')
                ocount = bit_vector ((unsigned (ocount)) + "0001");
            end if;
        end if;
    end process;

    --comparador que gera NUL
    NUL <= '1' when internal <= "000000000000000" else '0';
end architecture;

--fim do fluxo de dados

--unidade de controle
entity uc is
    port(
        start : in bit;
        ED, EC, Shift : out bit;
        NUL, LSB : in bit;
        clock, reset : in bit;
        done : out bit;
    );
end uc;

architecture arch of uc is

    type state_type is (A, B, C, D, E, F);
    signal present_state, next_state : state_type;

begin
    
    EC <= LSB;
    
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
                C when (present_state = D) and () else
                F when (present_state = E) and () else
                A when (present_state = F);
end architecture;

--uart

entity onescounter is
    port(
        inport : in bit_vector(14 downto 0);
        done : out bit;
        outport : out bit;
        start, reset, clock : in bit;
    );

end onescounter;
architecture strutcture of onescounter is 
        --sinais internos de controle
        signal NUL, EC, ED, Shift : bit;
        begin 
            fd: entity work.fd port map();

            uc: entity work.uc port map();
end architecture;
