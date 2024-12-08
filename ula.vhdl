library ieee;
use ieee.numeric_std.all;

entity ula is
    port (
        A  : in bit_vector(63 downto 0);  -- entrada A
        B  : in bit_vector(63 downto 0);  -- entrada B
        S  : in bit_vector(3 downto 0);   -- seleciona operacao
        F  : out bit_vector(63 downto 0); -- saida
        Z  : out bit;                     -- flag zero
        Ov : out bit;                     -- flag overflow
        Co : out bit                      -- flag carry-out
    );
end entity;

architecture ula_arch of ula is

    component ula1bit
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
    end component;

    signal ainvert, binvert : bit;
    signal operation : bit_vector(1 downto 0);
    signal overflow, y : bit_vector(63 downto 0);
    signal carry : bit_vector(64 downto 0);
    constant zero_vector : bit_vector(63 downto 0) := (others => '0');

    begin

        with S select
            operation <= "00" when "0000",  -- AND
                         "01" when "0001",  -- OR
                         "10" when "0010",  -- ADD
                         "10" when "0110",  -- SUB
                         "00" when "1100",  -- NOR
                         "11" when others;  -- PASS B

        carry(0) <= '1' when S = "0110" else '0'; -- +1 if SUB

        ainvert <= '1' when (S = "1100") else '0'; -- NOR
        binvert <= '1' when ((S = "1100") or (S = "0110")) else '0'; -- NOR or SUB
        
        gen: for i in 0 to 63 generate
            X: ula1bit port map (
                a => A(i), 
                b => B(i), 
                cin => carry(i),
                ainvert => ainvert,
                binvert => binvert,
                operation => operation,
                result => y(i),
                cout => carry(i+1),
                overflow => overflow(i)
            );
        end generate;

        Z <= '1' when (y = zero_vector) else '0';
        Ov <= overflow(63);
        Co <= carry(64);

        F <= y;

    end architecture;