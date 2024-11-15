library ieee;
use ieee.numeric_bit.all;

entity regfile_fd is
	port(
		clock 	: in bit;
		reset 	: in bit;
		adr	: in bit_vector(4 downto 0);
		enable  : in bit;
		d  	: in bit_vector(63 downto 0);
		q 	: out bit_vector(63 downto 0)
	    );
end entity;

architecture structural of regfile_fd is
	component reg is
		-- ponto e virgula no final e se tivessem outros parâmetro também
		generic (wordSize: natural := 4);
		-- manter a parametrização
		port(
			clock 	: in bit;
			reset 	: in bit;
			enable 	: in bit;
			d	: in bit_vector(wordSize-1 downto 0);
			q	: out bit_vector(wordSize-1 downto 0)
		);
	end component reg;

	-- gerar um tipo de signal que é uma array de bit_vectors de tamanho 64
	type vector64 is array (natural range<>) of bit_vector(63 downto 0);
	-- Os sinais internos que irão gerenciar 
	signal D_bank 	: vector64(31 downto 0);
	signal Q_bank	: vector64(31 downto 0);

begin
	-- Fazer a instância de 32 componentes registradores
	gen_32_reg:
	for i in 31 downto 0 generate
		regx : reg 
		generic map (wordSize=>64)
		-- Agora sem ponto e virgula
		port map(clock, reset, enable, D_bank(I), Q_bank(I));
	
	end generate gen_32_reg;

	process (clock, reset) is
    	begin
           if enable = '1' then
		D_bank(to_integer(unsigned(adr))) <= d;
           else
		q <= Q_bank(to_integer(unsigned(adr)));
	   end if;
    	end process;
end architecture structural;
