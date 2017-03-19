library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.DE0nano_PLL;

entity DE0_NANO is
	port
	(
		-- CLOCK 
		CLOCK_50				: in std_logic;
	
		-- LED 
		LED					: out std_logic_vector (7 downto 0);
	
		-- KEY 
		KEY					: in std_logic_vector (1 downto 0);
	
		-- SW 
		SW						: in std_logic_vector (3 downto 0);
	
		-- SDRAM 
		DRAM_ADDR			: out std_logic_vector (12 downto 0);
		DRAM_BA				: out std_logic_vector (1 downto 0);
		DRAM_CAS_N			: out std_logic;
		DRAM_CKE				: out std_logic;
		DRAM_CLK				: out std_logic;
		DRAM_CS_N			: out std_logic;
		DRAM_DQ				: inout std_logic_vector (15 downto 0);
		DRAM_DQM				: out std_logic_vector (1 downto 0);
		DRAM_RAS_N			: out std_logic;
		DRAM_WE_N			: out std_logic;
	
		-- EPCS 
		EPCS_ASDO			: out std_logic;
		EPCS_DATA0			: in std_logic;
		EPCS_DCLK			: out std_logic;
		EPCS_NCSO			: out std_logic;
	
		-- Accelerometer and EEPROM 
		G_SENSOR_CS_N		: out std_logic;
		G_SENSOR_INT		: in std_logic;
		I2C_SCLK				: out std_logic;
		I2C_SDAT				: in std_logic;
	
		-- ADC 
		ADC_CS_N				: out std_logic;
		ADC_SADDR			: out std_logic;
		ADC_SCLK				: out std_logic;
		ADC_SDAT				: in std_logic;
	
		-- 2x13 GPIO Header 
		GPIO_2				: inout std_logic_vector (12 downto 0);
		GPIO_2_IN			: in std_logic_vector (2 downto 0);
	
		-- GPIO_0, GPIO_0 connect to GPIO Default 
		GPIO					: inout std_logic_vector (33 downto 0);
		GPIO_IN 				: in std_logic_vector (1 downto 0)
	);
end DE0_NANO;

architecture DE0_NANO_arch of DE0_NANO is
	signal cnt : integer := 0;
	signal LED_temp : std_logic:= '1';
	signal clk: std_logic := '0';
begin
	prescaler : DE0nano_PLL
		port map(CLOCK_50, clk);
		
	timer : process (clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + 1;
			if cnt = 1000000 then
				cnt <= 0;
				LED_temp <= not LED_temp;
			end if;
		end if;
	end process;
	--LED(0) <= LED_temp;
	 
	LED <= (7 downto 1 => '0') & LED_temp;
	
	DRAM_ADDR <= (others => '0');
	DRAM_BA <= (others => '0');
	DRAM_CAS_N <= '0';
	DRAM_CKE	<= '0';
	DRAM_CLK	<= '0';
	DRAM_CS_N <= '0';
	--DRAM_DQ <= (others => '0');
	DRAM_DQM <= (others => '0');
	DRAM_RAS_N <= '0';
	DRAM_WE_N <= '0';
	
	EPCS_ASDO <= '0';
	--EPCS_DATA0
	EPCS_DCLK <= '0';
	EPCS_NCSO <= '0';
	
	-- Accelerometer and EEPROM 
	G_SENSOR_CS_N <= '0';
	--G_SENSOR_INT
	I2C_SCLK <= '0';
	--I2C_SDAT <= '0';
	
	-- ADC 
	ADC_CS_N	<= '0';
	ADC_SADDR <= '0';
	ADC_SCLK	<= '0';
	--ADC_SDAT
	
	-- 2x13 GPIO Header 
	--GPIO_2 <= (others => '0');
	--GPIO_2_IN
	
	-- GPIO_0, GPIO_0 connect to GPIO Default 
	--GPIO <= (others => '0');
	--GPIO_IN
end DE0_NANO_arch;