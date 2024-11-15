library ieee;
use ieee.numeric_bit.rising_edge;

entity reg is
	-- Atenção na hora de instanciar o port map
	-- Será necessário fazer a atribuição do wordSize
	-- Pode ser explicitando o nome da variável ou não
	-- Exemplo: 
	-- reg generic map(wordSize=>8) port map(...);
	-- ou então assim
	-- reg generic map(8) port map(...);
	generic (wordSize: natural :=4);
	port(
		clock 	: in bit;
		reset 	: in bit;
		enable 	: in bit;
		d	: in bit_vector(wordSize-1 downto 0);
		q	: out bit_vector(wordSize-1 downto 0)
	    );
end entity reg;

architecture structural of reg is
	signal interno  : bit_vector(wordSize-1 downto 0);
begin
	q <= interno;
	process(clock, reset)
	begin
		if reset='1' then
			interno <= (others =>'0');
		elsif  enable='1' and rising_edge(clock) then
			interno <= d;
		end if;
	end process;
end architecture structural;
