library ieee;
use ieee.numeric_std.all;

entity ula1bit is
    port (
        a         : in bit;
        b         : in bit;
        cin       : in bit;
        ainvert   : in bit;
        binvert   : in bit;
        operation : in bit_vector(1 downto 0);
        result    : out bit;
        cout      : out bit;
        overflow  : out bit
    );
end entity;

architecture ula1bit_arch of ula1bit is

    component fulladder
        port (
            a    : in bit;
            b    : in bit;
            cin  : in bit;
            s    : out bit;
            cout : out bit
        );
    end component;

    signal x, y, sum, co : bit;

    begin

        x <= a when (ainvert = '0') else (not a);
        y <= b when (binvert = '0') else (not b);

        FULL: fulladder port map (x, y, cin, sum, co);

        cout <= co;

        with operation select
            result <= x and y  when "00",
                      x or y   when "01",
                      sum      when "10",
                      b        when others;

        overflow <= ((x and y) and (not sum)) or (((not x) and (not y)) and sum);

end architecture;