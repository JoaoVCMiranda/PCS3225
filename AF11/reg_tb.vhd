library ieee;
use ieee.numeric_bit.all;


entity tb is
end entity tb;

architecture arch of tb is
    
 
    component reg is
        port(
		clock 	: in bit;
		reset 	: in bit;
		enable 	: in bit;
		d	: in bit_vector(wordSize-1 downto 0);
		q	: out bit_vector(wordSize-1 downto 0)
	    );
    end component;

    signal clock    : bit  := '0';
    signal reset    : bit  := '0';
    signal enable   : bit  := '0';
    signal d    : word := (others => '0');
    signal q   : word;

    begin
         -- clock generate
    clock <= (not clock) and keep_simulating after clock_period / 2;

    stimulus : process
    begin
        report "simulation start" severity note;
        keep_simulating <= '1';
        -- Reset do registrador
        reset <= '1';
        wait for clock_period;
        reset <= '0';

        input <= "0000100110100100001110000111110010100110001100001000000100000011";
        enable <= '1';
        wait until clock'event and clock = '1';
        enable <= '0';
        wait until clock'event and clock = '1';

        assert output = "0000100110100100001110000111110010100110001100001000000100000011" report "Erro no teste." severity error;

        -- Finalizando a simulação
        wait for clock_period;
        keep_simulating <= '0';
         
        assert false report "simulation end" severity note;
        wait; -- fim da simulação: aguarda indefinidamente
    end process;

    
end architecture arch;
