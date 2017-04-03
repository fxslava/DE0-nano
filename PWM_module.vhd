library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity PWM_module is
	port (
		clk		:	in		std_logic;
		reset		:	in		std_logic;
		pwm		:	out	std_logic;
		comp		:	in		std_logic_vector(31 downto 0);
		period	:	in		std_logic_vector(31 downto 0)
	);
end PWM_module;

architecture PWM_arch of PWM_module is
	signal cnt	:	std_logic_vector(31 downto 0);
begin
	cnt1 : process(clk, reset)
	begin
		
		if reset = '0' then
			cnt <= (others => '0');
		elsif rising_edge(clk) then
			cnt <= cnt + 1;
			if cnt > comp then
				pwm <= '1';
			else
				pwm <= '0';
			end if;
			
			if cnt = period then
				cnt <= x"00000000";
			end if;
		end if;
		
	end process;
end PWM_arch;