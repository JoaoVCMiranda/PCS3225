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
		port(
			regWrite: 	in bit;
			wr	: 	in bit_vector(4 downto 0);
			enable	: 	out bit
		    );	
	end component regfile_uc;
	
	component regfile_fd is
		port(
			clock	:  	in bit;
			reset	:  	in bit;
			enable	:  	in bit;
			rr1	:	in bit_vector(4 downto 0);
			rr2	:	in bit_vector(4 downto 0);
			wr	: 	in bit_vector(4 downto 0);
			d  	: 	in bit_vector(63 downto 0);
			q1 	: 	out bit_vector(63 downto 0);
			q2 	: 	out bit_vector(63 downto 0)
		    );
	end component regfile_fd;
	signal enable : bit;
begin
	RFILE_UC: regfile_uc
	port map (
		regWrite=>regWrite,
		wr=>wr,
		enable=>enable);
	RFILE_FD: regfile_fd
	port map (
		clock=>clock,
		reset=>reset, 
		enable=>enable,
		rr1=>rr1,
		rr2=>rr2,
		wr=>wr,
		d=>d,
		q1=>q1,
		q2=>q2);
	

end architecture;
