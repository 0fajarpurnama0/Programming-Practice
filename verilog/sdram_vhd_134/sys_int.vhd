library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;
library UNISIM;
--use UNISIM.vcomponents.all;

entity sys_int is
generic (
	ADDR_MSB : integer := 31;
	DATA_MSB : integer := 31;
	CYCLE : integer := 8;
	HALF_CYCLE : integer := 4 );
port (
	Add_reg : out unsigned(ADDR_MSB downto 0);
	sd_data_reg : out std_logic_vector(DATA_MSB downto 0);
	Act_st : out std_logic_vector(2 downto 0);
	write_st : out std_logic;
	rcd_c_max : out unsigned(1 downto 0);
	cas_lat_max : out unsigned(1 downto 0);
	burst_max : out unsigned(2 downto 0);
	ki_max : out unsigned(3 downto 0);
	ref_max : out unsigned(15 downto 0);
	AD_reg : in unsigned(DATA_MSB downto 0);
	Locked : in std_logic;
	Clk_i : in std_logic;
	data_addr_n_i : in std_logic;
	we_rn_i : in std_logic;
	data_addr_n_reg : in std_logic;
	we_rn_reg : in std_logic);
end entity sys_int;

architecture sys_int_arch of sys_int is

component SRL16
 port (
   Q : out std_logic;
   A0 : in std_logic;
   A1 : in std_logic;
   A2 : in std_logic;
   A3 : in std_logic;
   D : in std_logic;
   CLK : in std_logic
 );
end component;

signal cntrl :unsigned(DATA_MSB downto 0);
signal Data_reg : unsigned(DATA_MSB downto 0);
signal ld_cnt_reg : std_logic;
signal sd_data_reg_int : std_logic_vector(DATA_MSB downto 0);
signal Act_st_int : std_logic_vector(2 downto 0);
signal ad_reg_temp : std_logic_vector(1 downto 0);

signal one : std_logic := '1';
signal zero : std_logic := '0';

begin

ad_reg_temp <= AD_reg(29) & AD_reg(28);

process (Clk_i, data_addr_n_reg)
begin
if rising_edge(Clk_i) then
   if (data_addr_n_reg = '0') then
    case AD_reg_temp is --(29 downto 28) is
      when "00" => Act_st_int <= "100";
      when "01" => Act_st_int <= "101";
      when "10" => Act_st_int <= "110";
      when "11" => Act_st_int <= "111";
      when others => Act_st_int <= "000";
    end case;
   else 
     Act_st_int <= "000";
   end if;
end if;
end process;

write_st <= we_rn_i;
cas_lat_max(1 downto 0) <= cntrl(1 downto 0);
rcd_c_max(1 downto 0) <= cntrl(3 downto 2);
burst_max(2 downto 0) <= cntrl(6 downto 4);
ref_max(15 downto 0) <= cntrl(23 downto 8);
ki_max(3 downto 0) <= cntrl(27 downto 24);
sd_data_reg <= sd_data_reg_int;
Act_st <= Act_st_int;

process (Clk_i, Locked, ld_cnt_reg, data_addr_n_reg)
begin
if (Locked = '0') then
  ld_cnt_reg <= '0';
  cntrl <= X"0070320a";
  Add_reg <= X"00000000";
  Data_reg <= X"00000000";
elsif rising_edge(Clk_i) then
  if (ld_cnt_reg = '1') then
    cntrl <= Data_reg;
  end if;
  ld_cnt_reg <= (Act_st_int(2) and Act_st_int(1) and not(Act_st_int(0)) );
  if (data_addr_n_reg = '1') then
    Data_reg <= AD_reg;
  else
    Add_reg <= AD_reg;
  end if;
end if;
end process;

--delay Data_reg  by 4 clock periods
SRL16_0 : SRL16 port map (Q => sd_data_reg_int(0), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(0), CLK => Clk_i);
SRL16_1 : SRL16 port map (Q => sd_data_reg_int(1), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(1), CLK => Clk_i);
SRL16_2 : SRL16 port map (Q => sd_data_reg_int(2), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(2), CLK => Clk_i);
SRL16_3 : SRL16 port map (Q => sd_data_reg_int(3), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(3), CLK => Clk_i);
SRL16_4 : SRL16 port map (Q => sd_data_reg_int(4), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(4), CLK => Clk_i);
SRL16_5 : SRL16 port map (Q => sd_data_reg_int(5), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(5), CLK => Clk_i);
SRL16_6 : SRL16 port map (Q => sd_data_reg_int(6), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(6), CLK => Clk_i);
SRL16_7 : SRL16 port map (Q => sd_data_reg_int(7), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(7), CLK => Clk_i);
SRL16_8 : SRL16 port map (Q => sd_data_reg_int(8), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(8), CLK => Clk_i);
SRL16_9 : SRL16 port map (Q => sd_data_reg_int(9), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(9), CLK => Clk_i);
SRL16_10 : SRL16 port map (Q => sd_data_reg_int(10), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(10), CLK => Clk_i);
SRL16_11 : SRL16 port map (Q => sd_data_reg_int(11), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(11), CLK => Clk_i);
SRL16_12 : SRL16 port map (Q => sd_data_reg_int(12), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(12), CLK => Clk_i);
SRL16_13 : SRL16 port map (Q => sd_data_reg_int(13), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(13), CLK => Clk_i);
SRL16_14 : SRL16 port map (Q => sd_data_reg_int(14), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(14), CLK => Clk_i);
SRL16_15 : SRL16 port map (Q => sd_data_reg_int(15), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(15), CLK => Clk_i);
SRL16_16 : SRL16 port map (Q => sd_data_reg_int(16), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(16), CLK => Clk_i);
SRL16_17 : SRL16 port map (Q => sd_data_reg_int(17), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(17), CLK => Clk_i);
SRL16_18 : SRL16 port map (Q => sd_data_reg_int(18), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(18), CLK => Clk_i);
SRL16_19 : SRL16 port map (Q => sd_data_reg_int(19), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(19), CLK => Clk_i);
SRL16_20 : SRL16 port map (Q => sd_data_reg_int(20), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(20), CLK => Clk_i);
SRL16_21 : SRL16 port map (Q => sd_data_reg_int(21), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(21), CLK => Clk_i);
SRL16_22 : SRL16 port map (Q => sd_data_reg_int(22), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(22), CLK => Clk_i);
SRL16_23 : SRL16 port map (Q => sd_data_reg_int(23), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(23), CLK => Clk_i);
SRL16_24 : SRL16 port map (Q => sd_data_reg_int(24), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(24), CLK => Clk_i);
SRL16_25 : SRL16 port map (Q => sd_data_reg_int(25), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(25), CLK => Clk_i);
SRL16_26 : SRL16 port map (Q => sd_data_reg_int(26), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(26), CLK => Clk_i);
SRL16_27 : SRL16 port map (Q => sd_data_reg_int(27), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(27), CLK => Clk_i);
SRL16_28 : SRL16 port map (Q => sd_data_reg_int(28), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(28), CLK => Clk_i);
SRL16_29 : SRL16 port map (Q => sd_data_reg_int(29), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(29), CLK => Clk_i);
SRL16_30 : SRL16 port map (Q => sd_data_reg_int(30), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(30), CLK => Clk_i);
SRL16_31 : SRL16 port map (Q => sd_data_reg_int(31), A0 => one, A1 => one, A2 => zero, A3 => zero, 
		D => Data_reg(31), CLK => Clk_i);

end architecture sys_int_arch;











