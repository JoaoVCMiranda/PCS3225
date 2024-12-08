-------------------------------------------------------
--! @file ffdr.vhdl
--! @brief flip flop D assyncronous reset, incomplete atribution
--! @author João (joaovictorcmiranda@usp.br)
--! @date 2024-11-15
-------------------------------------------------------
library ieee;

-- fazer entidade
entity ffdr
	-- port map da entidade
	port( 
		reset, en, clock : in bit;
			q , q_n 	 : out bit
	    );
end entity;

-- Wrap this process with an architecture
architecture estrutura of ffdr is
	-- define the component 
	-- deve ser exatamente igual à entidade inicial
	component ffdr
	
	-- Ideia de processo para o flip-flop
	-- Atribuição incompleta 
	ffdr: process(clock, reset)
	begin
		if reset='1' then
			q <= '0';
			q_n <= '1';
		elsif clock='1' and clock'event then
			if en='1' then
				q<=d;
				q_n<=not d;
			end if;
		end if;
	-- Se colocassemos um else aqui
		-- Então teríamos a atribuição completa
		-- Mas nesse caso a incompleta basta pois
		-- o sintetizador irá justamente criar
		-- um flipflop internamente para guardar
		-- o sinal por um ciclo do process.
	-- Pois englobaria todos os casos de atribuição
	
	end process;
end architecture;
