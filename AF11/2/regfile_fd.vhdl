library ieee;
use ieee.numeric_bit.all;

entity regfile_fd is
	port(
		clock 	: in bit;
		reset 	: in bit;
		enable  : in bit;
		rr1	: in bit_vector(4 downto 0);
		rr2	: in bit_vector(4 downto 0);
		wr 	: in bit_vector(4 downto 0);
		d  	: in bit_vector(63 downto 0);
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
	type vector32 is array (natural range<>) of bit_vector(31 downto 0);
	-- Os sinais internos que irão gerenciar 
	signal D_bank 	: vector64(31 downto 0);
	signal Q_bank	: vector64(31 downto 0);
	signal Qt_bank  : vector32(63 downto 0);
	--------------------------------------------------------------------------
	--- MULTIPLEXADOR ---
	component mux is
		generic(n:natural);
		port(
			sel : in bit_vector(n-1 downto 0);
			input: in bit_vector(2**n-1 downto 0);
			output: out bit
		);
	end component mux;
	--------------------------------------------------------------------------
	--- DECODIFICADOR ---
	component decoder is
		generic(n:natural);
		port(
			input :	in bit_vector(n-1 downto 0);
			output: out bit_vector(2**n-1 downto 0)
		    );
	end component decoder;
	signal decOut : bit_vector(31 downto 0);
	signal regSel : bit_vector(31 downto 0);

	--------------------------------------------------------------------------
	
begin
	-- o trabalho de escolher qual registrador deveria ser usado é do decoder...
	-- Agora com base nesse registrador, a posição do "1" de regSel será o registrador a ser escrito

	-- Sem o decoder seria algo como "D_bank(to_integer(unsigned(wr))) <= d;"
	dec: decoder
	generic map(n=>5)
	port map(input=>wr, output=>decOut);
	-- Fazer a instância de 32 componentes registradores
	gen_32_reg:
	for I in 31 downto 0 generate
		-- Vínculo do decoder no começo
		regSel(I) <= decOut(I) and enable; 
		-- Inversão da matriz de registradores	
		--for J in 63 downto 0 
		--	Qt_bank(J)(I)<= Q_bank(I)(J); 
		--end for;
		regx : reg 
		generic map (wordSize=>64)
		-- Agora sem ponto e virgula
		port map(
			clock=>clock,
			reset=>reset,
			enable=>regSel(I),
			d=>D_bank(I),
			q=>Q_bank(I));
	end generate gen_32_reg;
	-- Transposição de matriz de saida
	mat_transp:
	process 
	begin
		for I in 31 downto 0 loop
			for J in 63 downto 0 loop
				Qt_bank(J)(I) <= Q_bank(I)(J);
			end loop;
		end loop;
		wait;
	end process;
	
	-- o trabalho de atribuir valores as saídas é dos mux
	-- seria o equivalente à
	-- q1 <= Q_bank(to_integer(unsigned(rr1)));
	-- q2 <= Q_bank(to_integer(unsigned(rr2)));
	gen_64_32mux:
	for I in 63 downto 0 generate
		muxXX1 : mux
		generic map(n=>5)
		port map(
			sel=>rr1,
			input=>Qt_bank(I),
			output=>q1(I)
			);
		muxXX2 : mux
		generic map(n=>5)
		port map(
			sel=>rr2,
			input=>Qt_bank(I),
			output=>q2(I)
			);
	end generate gen_64_32mux;

end architecture structural;


























	
	-- será que esse multiplexador está correto?
	-- Fazer a instância de 2 multiplexadores de 64 entradas
	--gen_2_64mux:
	--for i in 63 downto 0 generate
		-- Esse é o trabalho de desfazer a matriz
		-- E refazer de um jeito que o mux possa trabalhar
	--	for j in 31 downto 0
	--		interno(j) <= Q_bank(j)(i);	
	--	end for;

	--	mux1x : mux
	--	generic map(n=>5)
	--	port map(sel=>rr1,input=>interno,output=>q1(i));

	--	mux2x : mux
	--	generic map(n=>5)
	--	port map(sel=>rr2,input=>interno,output=>q2(i));

	--end generate gen_2_64mux;

	--dec: decoder
	--generic map(5)
	--port map(input=>adr, Q_bank(to_integer(unsigned(adr))));
	
	--- Seleção de qual registrador que estou falando


	--process (clock) is
	--- Esse if precisa ser dentro do process de clock pois a escrita é assíncrona
	--begin
	--- Porém essa abordagem é... Programática
           --if enable = '1' then
	   --	D_bank(to_integer(unsigned(wr))) <= d;
           --else
	   --	q <= Q_bank(to_integer(unsigned(adr)));
	   --end if;
	--- Como seria uma versão mais... vhdlística?
    	--end process;

		
--end architecture structural;


