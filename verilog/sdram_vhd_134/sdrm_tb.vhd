library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use std.textio.all;
library unisim;
use unisim.vcomponents.all;

library micron;
USE micron.ihdlutil.all;
USE micron.vrlgutil.all;
USE std.textio.all;

PACKAGE test_sdrm_PKG IS
COMPONENT test_sdrm
   GENERIC (
      hi_z: INTEGER := 2#0#-- !!! Z in integer constant

   );
END component;
END test_sdrm_PKG;

library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use std.textio.all;
library unisim;
use unisim.vcomponents.all;

library micron;
USE micron.ihdlutil.all;
USE micron.vrlgutil.all;
USE std.textio.all;

--USE work.test_sdrm_PKG.all;
USE micron.mt48lc1m16a1_PKG.all;

ENTITY test_sdrm IS
  GENERIC (
    hi_z: INTEGER := 2#0#-- !!! Z in integer constant
    );
END test_sdrm;

ARCHITECTURE test_sdrm_ARCH OF test_sdrm IS

component sdrm
  port (
    CLK_SDP : out STD_LOGIC; 
    SD_WE : out STD_LOGIC; 
    CLK_FBP : in STD_LOGIC := 'X'; 
    WE_RN : in STD_LOGIC := 'X'; 
    SD_CS1 : out STD_LOGIC; 
    SD_CS2 : out STD_LOGIC; 
    CLKP : in STD_LOGIC := 'X'; 
    SD_BA : out STD_LOGIC; 
    DATA_ADDR_N : in STD_LOGIC := 'X'; 
    SD_RAS : out STD_LOGIC; 
    RESET : in STD_LOGIC := 'X'; 
    SD_CAS : out STD_LOGIC; 
    SD_CKE : out STD_LOGIC; 
    AD : inout STD_LOGIC_VECTOR ( 31 downto 0 ); 
    SD_DQM : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    SD_ADD : out STD_LOGIC_VECTOR ( 10 downto 0 ); 
    SD_DATA : inout STD_LOGIC_VECTOR ( 31 downto 0 ) 
  );
end component;

  SIGNAL s_ad	: std_logic_vector(31 DOWNTO 0) := conv_std_logic_vector(hi_z, 32);
  SIGNAL data_addr_n	: std_logic := '1';
  SIGNAL we_rn	: std_logic := '1';
  SIGNAL clk	: std_logic ;
  SIGNAL s_reset	: std_logic := '1';
  SIGNAL cke	: std_logic;
  SIGNAL cs1	: std_logic;
  SIGNAL cs2	: std_logic;
  SIGNAL dqm	: std_logic_vector(3 DOWNTO 0);
  SIGNAL addr	: std_logic_vector(10 DOWNTO 0);
  SIGNAL AD	: std_logic_vector(31 DOWNTO 0);
  SIGNAL DQ	: std_logic_vector(31 DOWNTO 0);
  SIGNAL Reset	: std_logic;
  SIGNAL clk_con	: std_logic;
  SIGNAL ras_n	: std_logic;
  SIGNAL cas_n	: std_logic;
  SIGNAL we_n	: std_logic;
  SIGNAL ba	: std_logic;
  signal inputs : std_logic_vector(33 DOWNTO 0);


BEGIN

  AD	 <= s_ad;
  Reset	 <= s_reset;

  sdrmc_INST: sdrm
    PORT MAP ( Reset => s_reset, Clkp => clk, data_addr_n => data_addr_n,
		 we_rn => we_rn, AD => AD, Clk_FBp => clk_con, Clk_SDp => clk_con,
		 sd_ras => ras_n, sd_cas => cas_n, sd_we => we_n, sd_data => DQ(31 DOWNTO 0),
		 sd_add => addr, sd_cke => cke, sd_dqm => dqm, sd_cs1 => cs1,
		 sd_cs2 => cs2, sd_ba => ba   );

  sdram0_INST: mt48lc1m16a1
    PORT MAP ( Addr => addr, We_n => we_n, Cas_n => cas_n,
		 Ras_n => ras_n, Clk => clk_con, Cke => cke, Cs_n => cs1,
		 Dqm => dqm(1 DOWNTO 0), Ba => ba, Dq => DQ(15 DOWNTO 0)   );

  sdram1_INST: mt48lc1m16a1
   PORT MAP ( Addr => addr, We_n => we_n, Cas_n => cas_n,
		Ras_n => ras_n, Clk => clk_con, Cke => cke, Cs_n => cs2,
		Dqm => dqm(3 DOWNTO 2), Ba => ba, Dq => DQ(31 DOWNTO 16)   );


  PROCESS
  BEGIN
    WAIT FOR 50 NS;
    s_reset	 <= '0';
    WAIT;
  END PROCESS;


  CLKGEN: PROCESS (clk) 
  BEGIN
	if clk = '0' then
	  clk <= '1' after 8 ns;
	else
	  clk <= '0' after 8 ns;
	end if;
  END PROCESS;

  s_ad <= inputs(31 downto 0);
  we_rn <= inputs(32);
  data_addr_n <= inputs(33);
  

  STIMULUS: PROCESS
  BEGIN
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR ((87 * 8) + 1) * 1 NS;
    inputs <= "0100100000001101000000010000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "1100000111000001001010000001110110";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (5 * 8) * 1 NS;
    inputs <= "0100111000000000000000000000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "1100000000000000000000000000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (15 * 8) * 1 NS;
    inputs <= "0100111000000000000000000000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "1100000000000000000000000000000000";
    WAIT FOR (13 * 8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (7 * 8) * 1 NS;
    inputs <= "0100010000000000001100110000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "1100000000000000000000000000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (3 * 8) * 1 NS;
    inputs <= "0100000000000000000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000001";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000010";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000011";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000100";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000101";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000110";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000000111";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000000001000";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (5 * 8) * 1 NS;
    inputs <= "0100000000011010000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110001";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110010";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110011";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110100";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110101";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110110";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011110111";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000001000011111000";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (30 * 8) * 1 NS;
    inputs <= "0000000000000000000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (20 * 8) * 1 NS;
    inputs <= "0000000000011010000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (13 * 8) * 1 NS;
    inputs <= "0100100000001101000000010000000000";
    WAIT FOR 8 NS;
    inputs <= "1100000111000001001010000000000110";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (7 * 8) * 1 NS;
    inputs <= "0100010000000000001100000000000000";
    WAIT FOR 8 NS;
    inputs <= "1100000000000000000000000000000000";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (20 * 8) * 1 NS;
    inputs <= "0000000000011010000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (20 * 8) * 1 NS;
    inputs <= "0000000000000000000000000000000000";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (8) * 1 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR 8 NS;
    inputs <= "10ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    WAIT FOR (300 * 8) * 1 NS;
    WAIT;   
END PROCESS;

END test_sdrm_ARCH;

CONFIGURATION test_sdrm_CONF OF test_sdrm IS
  for test_sdrm_arch
  end for;  

END test_sdrm_CONF;

