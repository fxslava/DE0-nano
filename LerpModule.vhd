library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Lerp is
	port (
		clk		:	in		std_logic;
		X1			:	in		std_logic_vector(31 downto 0);
		X2			:	in		std_logic_vector(31 downto 0);
		t1			:	in		std_logic_vector(31 downto 0);
		t2			:	in		std_logic_vector(31 downto 0);
		P			:	in		std_logic_vector(31 downto 0);
		t			:	in		std_logic_vector(31 downto 0);
		Y			:	out	std_logic_vector(31 downto 0)
	);
end Lerp;

architecture Lerp_arch of Lerp is
	signal sX1 : std_logic_vector(31 downto 0);
	signal sX2 : std_logic_vector(31 downto 0);
	signal st1 : std_logic_vector(31 downto 0);
	signal st2 : std_logic_vector(31 downto 0);
	signal sP  : std_logic_vector(31 downto 0);
	signal temp: std_logic_vector(95 downto 0);
	
begin
	cnt1 : process(clk)
	begin
			
		if rising_edge(clk) then
			
			temp <= (t - st1) * sP * (sX2 - sX1);
			Y <= temp(95 downto 64) + sX1; -- divide by 2^64
			if t2 = t then
				sX1 <= X1;
				sX2 <= X2;
				st1 <= t1;
				st2 <= t2;
				sP  <= P;
			end if;
		end if;
		
	end process;
end Lerp_arch;