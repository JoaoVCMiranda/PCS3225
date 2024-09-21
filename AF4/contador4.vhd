library IEEE;

entity contador4 is
	port (
	    clock : in bit;
	    reset : in bit;
	    en	  : in bit;
	    Q     : out bit_vector(3 downto 0)
	);
end entity contador4;
    
architecture mycontador4 of contador4 is
	    signal internal: bit_vector(3 downto 0) := "0000";
	    process(clock) is
	    begin
		if(clock'event and clock = '1') then
		    if(reset = '1') then 
			internal <= "0000";
		    elsif(en = '1') then
			internal = bit_vector ((unsigned (internal)) + "0001");
		    end if;
		end if;
	    end process;
	    Q <= internal;

 end architecture; 
