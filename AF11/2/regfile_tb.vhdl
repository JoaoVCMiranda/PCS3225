library ieee;
use ieee.numeric_bit.all;

entity regfile_tb is
end entity regfile_tb;

architecture arch_reg_tb of regfile_tb is
----------------------------COMPONENTS-------------------------------------
	component regfile is
		port(
		clock: 		in bit;
		reset: 		in bit;
		regWrite: 	in bit;
		rr1: 		in bit_vector(4 downto 0);
		rr2: 		in bit_vector(4 downto 0);
		wr : 		in bit_vector(4 downto 0);
		d  : 		in bit_vector(63 downto 0);
		q1 : 		out bit_vector(63 downto 0);
		q2 : 		out bit_vector(63 downto 0)
	    );
	end component;
---------------------------------------------------------------------------
----------------------------SIGNALS----------------------------------------
	signal 		clk 		: bit  := '0';
	signal 		keepSimulating	: bit  := '1';
	constant 	clockPeriod 	: time := 1 ns;


	signal	reset: 		bit;
	signal	regWrite: 	bit;
	signal	rr1: 		bit_vector(4 downto 0);
	signal	rr2: 		bit_vector(4 downto 0);
	signal	wr : 		bit_vector(4 downto 0);
	signal	d  : 		bit_vector(63 downto 0);
	signal	q1 : 		bit_vector(63 downto 0);
	signal	q2 : 		bit_vector(63 downto 0);

	type endr is array (natural range<>) of bit_vector(4 downto 0);
	constant addresses : endr(0 to 31) :=(
	"00000","00001","00010","00011","00100","00101","00110","00111",
	"01000","01001","01010","01011","01100","01101","01110","01111",
	"10000","10001","10010","10011","10100","10101","10110","10111",
	"11000","11001","11010","11011","11100","11101","11110","11111");
	
	signal assert_q1:	bit_vector(63 downto 0);
	signal assert_q2:	bit_vector(63 downto 0);

---------------------------------------------------------------------------
begin
----------------------------DEFAULTS---------------------------------------
	clk <= not(clk) and keepSimulating after clockPeriod/2;	
---------------------------------------------------------------------------
----------------------------INSTÂNCIA--------------------------------------
	rf : regfile
	port map(
		clock=>clk,
		reset=>reset,
		regWrite=>regWrite,
		rr1=>rr1,
		rr2=>rr2,
		wr =>wr,
		d  =>d,
		q1 =>q1,
		q2 =>q2
	);
---------------------------------------------------------------------------
----------------------------PROCESSO---------------------------------------
	palpitations : process
	begin
    	assert false report "Agora vai pegar" severity note;
----------------------------TESTE DE ESCRITA-------------------------------
	regWrite <= '1';
	wr <= "00001";
	d <= "0100010010010010100101010010010101001010010100010010011100011101";
	wait for clockPeriod;
	regWrite <='0';

---------------------------------------------------------------------------

----------------------------ZERAR O BANCO----------------------------------
	reset<='1';
	wait for clockPeriod;
	reset<='0';
---------------------------------------------------------------------------

----------------------------POPULAÇÃO DO REGFILE---------------------------
	regWrite<='1';
	for i in 0 to 31 loop 
		d <= (others=>'0');
		d(i) <= '1';
		wr <= addresses(i);
		wait for clockPeriod;
	end loop;
	regWrite<='0';
---------------------------------------------------------------------------

----------------------------LEITURAS SIMULTANEAS---------------------------
	for i in 0 to 15 loop
		rr1 <= addresses(2*i);
		rr2 <= addresses(2*i+1);
		

		assert_q1(2*i) <= '1';
		assert_q1 <= (others => '0');

		assert_q2(2*i+1) <= '1';
		assert_q2 <= (others => '0');

		assert q1 = assert_q1 report "Leitura Q1 molhou" severity error;
		assert q2 = assert_q2 report "Leitura Q2 molhou" severity error;
	end loop;
---------------------------------------------------------------------------
	keepSimulating <= '0';
	wait;
	end process palpitations;
	
end architecture arch_reg_tb;
