library ieee;

entity regfile_uc is
	port(
		regWrite: in bit;
		wr 	: in  bit_vector(4 downto 0);
		enable 	: out bit
	    );
end entity;

architecture structural of regfile_uc is

begin
	--- Logica de funcionamento 
	--  Não fazer escrita no último registrador
	enable <= '0' when wr="11111" else regWrite;

end architecture;
