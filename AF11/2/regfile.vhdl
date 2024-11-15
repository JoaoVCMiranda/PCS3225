library ieee;
use ieee.numeric_bit.rising_edge;

entity regfile is
	port(
		clock: in bit;
		reset: in bit;
		regWrite: in bit;
		rr1: in bit_vector(4 downto 0);
		rr2: in bit_vector(4 downto 0);
		wr : in bit_vector(4 downto 0);
		d  : in bit_vector(63 downto 0);
		q1 : out bit_vector(63 downto 0);
		q2 : out bit_vector(63 downto 0)
	    );
end entity;

architecture structural of regfile is
	component regfile_uc is
	
	end component regfile_uc;
	
	component regfile_fd is

	end component regfile_fd;
begin
	

end architecture;
