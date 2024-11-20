library ieee;
use ieee.numeric_bit.all;

entity regfile_fd is
	port(
		clock 	: in bit;
		reset 	: in bit;
		adr	: in bit_vector(4 downto 0);
		enable  : in bit;

		d  	: in bit_vector(64 downto 0);
		q 	: out bit_vector(64 downto 0);

		rr1	: in bit_vector(4 downto 0);
		rr2	: in bit_vector(4 downto 0);
		q1	: out bit_vector(63 downto 0);
		q2	: out bit_vector(63 downto 0)
	    );
end entity;

architecture structural of regfile_fd is
	--- REGISTRADOR ----
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
	--------------------------------------------------------------------------

	-- gerar um tipo de signal que é uma array de bit_vectors de tamanho 64
	type vector64 is array (natural range<>) of bit_vector(63 downto 0);
	-- Os sinais internos que irão gerenciar 
	signal D_bank 	: vector64(31 downto 0);
	signal Q_bank	: vector64(31 downto 0);
	signal interno 	: bit_vector(31 downto 0);
	--------------------------------------------------------------------------
	component mux is
		generic(n:natural);
		port(
			sel : in bit_vector(n-1 downto 0);
			input: in bit_vector(2**n-1 downto 0);
			output: out bit
		);
	end component mux;

	component decoder is
		generic(n:natural);
		port(
			input :	in bit_vector(n-1 downto 0);
			output: out bit_vector(2**n-1 downto 0)
		    );
	end component decoder;
	
begin
	process (clock) is
    	begin
           if enable = '1' then
		D_bank(to_integer(unsigned(adr))) <= d;
           else
		q <= Q_bank(to_integer(unsigned(adr)));
	   end if;
    	end process;

	-- Fazer a instância de 32 componentes registradores
	gen_32_reg:
	for i in 31 downto 0 generate
		regx : reg 
		generic map (wordSize=>64)
		-- Agora sem ponto e virgula
		port map(clock, reset, enable, D_bank(I), Q_bank(I));
	
	end generate gen_32_reg;
	
	-- será que esse multiplexador está correto?
	-- Fazer a instância de 2 multiplexadores de 64 entradas
	gen_2_64mux:
	for i in 63 downto 0 generate
		-- Esse é o trabalho de desfazer a matriz
		-- E refazer de um jeito que o mux possa trabalhar
		for j in 31 downto 0
			interno(j) <= Q_bank(j)(i);	
		end for;

		mux1x : mux
		generic map(n=>5)
		port map(sel=>rr1,input=>interno,output=>q1(i));

		mux2x : mux
		generic map(n=>5)
		port map(sel=>rr2,input=>interno,output=>q2(i));

	end generate gen_2_64mux;

	dec: decoder
	generic map(5)
	port map(input=>adr, Q_bank(to_integer(unsigned(adr))));
	


end architecture structural;
