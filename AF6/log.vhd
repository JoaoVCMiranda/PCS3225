library IEEE;
use ieee.numeric_bit.all;

entity log is
	port(
		clock,inicio : in bit;
		x : in bit_vector(7 downto 0 ) ;
		R : in bit_vector(7 downto 0 ) ;
		fim : out bit
	);
end log;

architecture arch of log is
	-- FD
	component log_fd
		-- Copiar da entity no arquivo log_fd
		port();
	end component;	
	-- UC
	component log_uc
		-- Também!
		port();
	end component;
	-- signals que forem precisos
begin 
	LN_FD: log_fd port map( 
				--Estrutura "sinal no fd" => "signal local";
			      );
	LN_UC: log_uc port map(
				--Estrutura "sinal no uc" => "signal local";
			      );
end architecture;
