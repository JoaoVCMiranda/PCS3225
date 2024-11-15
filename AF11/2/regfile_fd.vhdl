library ieee;

entity regfile_fd is
	port(
		adr	: in bit_vector(4 downto 0);
		enable  : in bit;
		d  	: in bit_vector(63 downto 0);
		q 	: out bit_vector(63 downto 0)
	    );
end entity;

architecture structural of regfile_fd is
	component reg is
		-- ponto e virgula
		generic (wordSize=>64);
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
	type vector64 is array (natural range<>) of bit_vector(64);
	-- Os sinais internos que irão gerenciar 
	signal D 	: vector64(31 downto 0);
	signal Q 	: vector64(31 downto 0);
	-- Esse sinal é mesmo necessário?
	signal interno	: bit_vector(64);

begin
	-- Fazer a instância de 32 componentes registradores
	gen_32_reg:
	for i in 0 to 31 generate
		regx : reg port	map(clock, reset, w, D(i), Q(i));
	end generate;
	
	if w='1' then
		D(integer(unsigned(adr))) <= d;
	else then
		q <= Q(integer(unsigned(adr)));
	end if;
	

end architecture;
