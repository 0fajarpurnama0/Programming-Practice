library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;

-- synopsys translate_off
library UNISIM;
use UNISIM.vcomponents.all;
-- synopsys translate_on

entity sdrm is
--generic (DATA_MSB : integer := 31;
--	 ADDR_MSB : integer := 31);
port (	sd_data : inout std_logic_vector(31 downto 0);
	AD : inout std_logic_vector(31 downto 0);
	sd_add : out std_logic_vector(10 downto 0);
	sd_ras : out std_logic;
	sd_cas : out std_logic;
	sd_we : out std_logic;
	sd_ba : out std_logic;
	Clk_SDp : out std_logic;
	sd_cke : out std_logic;
	sd_cs1 : out std_logic;
	sd_cs2 : out std_logic;
	sd_dqm : out std_logic_vector(3 downto 0);
	Reset : in std_logic;
	Clkp : in std_logic;
	Clk_FBp : in std_logic;
	we_rn : in std_logic;
	data_addr_n : in std_logic);
end entity sdrm;

architecture sdrm_arch of sdrm is 
constant DATA_MSB : integer := 31;
constant ADDR_MSB : integer := 31;

signal logic1 : std_logic := '1';
signal logic0 : std_logic := '0';
signal sd_add_op : unsigned(10 downto 0);
signal sd_data_i : std_logic_vector(DATA_MSB downto 0);
signal AD_i : unsigned(DATA_MSB downto 0);
signal sd_data_reg : std_logic_vector(DATA_MSB downto 0);
signal sd_cke_o : std_logic := '1';
signal sd_cs1_o : std_logic := '0';
signal sd_cs2_o : std_logic := '0';
signal sd_ba_op : std_logic;
signal ready_o : std_logic;
signal sd_dqm_o : std_logic_vector(3 downto 0) := "0000";
signal Reset_i : std_logic;
signal sd_data_o : std_logic_vector(31 downto 0);
signal sd_data_t : std_logic_vector(DATA_MSB downto 0);
signal sd_data_R : std_logic_vector(DATA_MSB downto 0);
signal AD_o : std_logic_vector(DATA_MSB downto 0);
signal sd_add_o : unsigned(10 downto 0);
signal sd_ba_o : std_logic;
signal sd_cas_o : std_logic;
signal sd_ras_o : std_logic;
signal sd_we_o : std_logic;
signal sd_doe_n : std_logic_vector(3 downto 0);
signal sd_doe_np : std_logic_vector(3 downto 0);
signal Clk_i : std_logic;
signal Clk_j : std_logic;
signal Clk0A : std_logic;
signal Clk0B : std_logic;
signal Clk0C : std_logic;
signal Locked2 : std_logic;
signal Locked1 : std_logic;
signal Locked_i : std_logic;
signal Locked_j : std_logic;
signal Clk_FB : std_logic;
signal Clk : std_logic;
signal sd_ras_op : std_logic;
signal sd_cas_op : std_logic;
signal sd_we_op : std_logic;
signal write_st : std_logic;
signal AD_tri : std_logic;
signal Add_reg : unsigned(ADDR_MSB downto 0);
signal AD_reg : unsigned(ADDR_MSB downto 0);
signal rcd_c_max : unsigned(1 downto 0);
signal cas_lat_max : unsigned(1 downto 0);
signal burst_max : unsigned(2 downto 0);
signal Act_st : std_logic_vector(2 downto 0);
signal ki_max : unsigned(3 downto 0);
signal ref_max : unsigned(15 downto 0);
signal data_addr_n_reg : std_logic;
signal we_rn_reg : std_logic;
signal data_addr_n_i : std_logic;
signal we_rn_i : std_logic;
signal kid : std_logic;
signal auto_ref_out : std_logic;
signal auto_ref_in : std_logic; -- := auto_ref_out;
signal unused1, unused2, unused3 : std_logic;
signal rcd_end : std_logic;
signal Clk_SDp_int : std_logic;

component sys_int 
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
end component;

component sdrm_t 
port (	sd_add_o: out unsigned(10 downto 0);
	sd_ras_o: out std_logic;
	sd_cas_o: out std_logic;
	sd_we_o: out std_logic;
	sd_ba_o: out std_logic;
	ready_o: out std_logic;
	Locked_j: out std_logic;
	Locked_i: out std_logic;
	kid: out std_logic;
	auto_ref_out: out std_logic;
	rcd_end: out std_logic;
	sd_doe_n: out std_logic_vector(3 downto 0);
	AD_tri: out std_logic;
	write_st: in std_logic;
	auto_ref_in: in std_logic;
	Locked1: in std_logic;
	Locked2: in std_logic;
	Clk_i: in std_logic;
	Clk_j: in std_logic;
	Act_st: in std_logic_vector(2 downto 0);
	rcd_c_max: in unsigned(1 downto 0);
	cas_lat_max: in unsigned(1 downto 0);
	burst_max: in unsigned(2 downto 0);
	ki_max: in unsigned(3 downto 0);
	ref_max: in unsigned(15 downto 0);
	Add_reg: in unsigned(21 downto 2));
end component;

component IBUFG
 port (
   O : out std_logic;
   I : in std_logic
 );
end component;

component DCM_BASE
 port (
   CLK0 : out std_logic;
   CLK90 : out std_logic;
   CLK180 : out std_logic;
   CLK270 : out std_logic;
   CLK2X : out std_logic;
   CLK2X180 : out std_logic;
   CLKDV : out std_logic;
   CLKFX : out std_logic;
   CLKFX180 : out std_logic;
   LOCKED : out std_logic;
   CLKIN : in std_logic;
   CLKFB : in std_logic;
   RST : in std_logic
 );
end component;

component IBUF
 port (
   O : out std_logic;
   I : in std_logic
 );
end component;

component BUFG
 port (
   O : out std_logic;
   I : in std_logic
 );
end component;

component OBUF_F_16
 port (
   O : out std_logic;
   I : in std_logic
 );
end component;

component IOBUF_F_12
 port (
   O : out std_logic;
   IO : inout std_logic;
   I : in std_logic;
   T : in std_logic
 );
end component;

component OBUF_F_12
 port (
   O : out std_logic;
   I : in std_logic
 );
end component;


begin
--Instantiation of sub-level modules
sdrm_t_int : sdrm_t port map (	Locked1 => Locked1, Locked2 => Locked2, 
				Clk_i => Clk_i, sd_ras_o => sd_ras_op, 
				sd_cas_o => sd_cas_op, sd_we_o => sd_we_op,
				sd_add_o => sd_add_op, sd_ba_o => sd_ba_op, 
				sd_doe_n => sd_doe_np, ready_o => ready_o, 
				Locked_i => Locked_i, Locked_j => Locked_j, 
				Add_reg => Add_reg(21 downto 2), 
				rcd_c_max => rcd_c_max, kid => kid,
				auto_ref_in => auto_ref_in, 
				auto_ref_out => auto_ref_out,
				cas_lat_max => cas_lat_max, burst_max => burst_max,
				Act_st => Act_st, Clk_j => Clk_j, write_st => write_st,
				ki_max => ki_max, ref_max => ref_max, 
				rcd_end => rcd_end, AD_tri => AD_tri);
   
sys_int_int : sys_int port map (Locked => Locked_i, Clk_i => Clk_i, 
				data_addr_n_reg => data_addr_n_reg,
				data_addr_n_i => data_addr_n_i, we_rn_i => we_rn_i,
				we_rn_reg => we_rn_reg, AD_reg => AD_reg,
				Act_st => Act_st, write_st => write_st,
				Add_reg => Add_reg, sd_data_reg => sd_data_reg, 
				rcd_c_max => rcd_c_max, cas_lat_max => cas_lat_max, 
				burst_max => burst_max, ki_max => ki_max, 
				ref_max => ref_max);

--clock input to FPGA (Clkp), must go through IBUFG before entering DLL
ibufg0 : IBUFG port map (I => Clkp, O => Clk);
   
--clock feedback from SDRAM for clock mirror (Clk_FBp), 
--must go through IBUFG 
ibufg1 : IBUFG port map (I => Clk_FBp, O => Clk_FB);

--dll0 is clock mirror, provide SDRAM clock(Clk_SDp)
dll0 : DCM_BASE port map (CLKIN => Clk, CLKFB => Clk_FB, RST => Reset_i, CLK0 => Clk0A,
	       		CLK90 => OPEN, CLK180 => OPEN, CLK270 => OPEN, CLK2X => unused1, CLK2X180 => OPEN,
			CLKDV => unused2, CLKFX => OPEN, CLKFX180 => OPEN, LOCKED => Locked1);
		
--Clk_SDp is routed directly from dll0 to output buffer
obuf0 : OBUF_F_16 port map (I => Clk0A, O => Clk_SDp_int);
Clk_SDp <= Clk_SDp_int;	
--ddl1 provides internal clock to FPGA
--these clocks drive global clock buffer (BUFG) to get minimum skew
dll1 : DCM_BASE port map (CLKIN => Clk, CLKFB => Clk_j, RST => Reset_i, CLK0 => Clk0C,
	       		CLK90 => OPEN, CLK180 => OPEN, CLK270 => OPEN, CLK2X => Clk0B, CLK2X180 => OPEN,
			CLKDV => unused3, CLKFX => OPEN, CLKFX180 => OPEN, LOCKED => Locked2);
   
--Clk_j is the same as input clock (Clk_SDp)
--Clk_i is is multiplied by 2x
bufg0 : BUFG port map (O => Clk_i, I => Clk0B);
bufg1 : BUFG port map (O => Clk_j, I => Clk0C);

process (Clk_i, Locked_i) 
begin
if (Locked_i = '0') then
  sd_data_o <= X"ffffffff";
  sd_data_t(31 downto 0) <= X"ffffffff";
  sd_data_R <= X"00000000";
  AD_o <= X"00000000";
  AD_reg <= X"00000000";
  data_addr_n_reg <= '1';
  we_rn_reg <= '0';
elsif rising_edge(Clk_i) then
  sd_data_o <= transport sd_data_reg after 3 ns;
  sd_data_t(31 downto 24) <= transport (sd_doe_n(3) & sd_doe_n(3) & sd_doe_n(3) & 
  				sd_doe_n(3) & sd_doe_n(3) & sd_doe_n(3) & 
				sd_doe_n(3) & sd_doe_n(3) ) after 3 ns;
  sd_data_t(23 downto 16) <= transport (sd_doe_n(2) & sd_doe_n(2) & sd_doe_n(2) & 
  				sd_doe_n(2) & sd_doe_n(2) & sd_doe_n(2) & 
				sd_doe_n(2) & sd_doe_n(2) ) after 3 ns;
  sd_data_t(15 downto 8) <= transport (sd_doe_n(1) & sd_doe_n(1) & sd_doe_n(1) & 
  				sd_doe_n(1) & sd_doe_n(1) & sd_doe_n(1) & 
				sd_doe_n(1) & sd_doe_n(1) ) after 3 ns;
  sd_data_t(7 downto 0) <= transport (sd_doe_n(0) & sd_doe_n(0) & sd_doe_n(0) & 
  				sd_doe_n(0) & sd_doe_n(0) & sd_doe_n(0) & 
				sd_doe_n(0) & sd_doe_n(0) ) after 3 ns;
  sd_data_R <= sd_data_i;
  AD_o <= sd_data_R;
  AD_reg <= AD_i;
  data_addr_n_reg <= data_addr_n_i;
  we_rn_reg <= we_rn_i;
end if;
end process;

auto_ref_in <= auto_ref_out;

process (Clk_i, Locked_i)
begin
if (Locked_i = '0') then
  sd_add_o(10 downto 0) <= "00000000000";
  sd_ba_o <= '0';
  sd_ras_o <= '1';
  sd_cas_o <= '1';
  sd_we_o <= '1';
  sd_doe_n <= X"f";
elsif rising_edge(Clk_i) then
  sd_add_o(10 downto 0) <= transport sd_add_op(10 downto 0) after 3 ns;
  sd_ba_o <= transport sd_ba_op after 3 ns;
  sd_ras_o <= transport sd_ras_op after 3 ns;
  sd_cas_o <= transport sd_cas_op after 3 ns;
  sd_we_o <= transport sd_we_op after 3 ns;
  sd_doe_n <= transport sd_doe_np after 3 ns;
end if;
end process;

--IO PADs instantiation

iod0 : IOBUF_F_12 port map (I => sd_data_o(0), IO => sd_data(0), O => sd_data_i(0), T => sd_data_t(0));
iod1 : IOBUF_F_12 port map (I => sd_data_o(1), IO => sd_data(1), O => sd_data_i(1), T => sd_data_t(1));
iod2 : IOBUF_F_12 port map (I => sd_data_o(2), IO => sd_data(2), O => sd_data_i(2), T => sd_data_t(2));
iod3 : IOBUF_F_12 port map (I => sd_data_o(3), IO => sd_data(3), O => sd_data_i(3), T => sd_data_t(3));
iod4 : IOBUF_F_12 port map (I => sd_data_o(4), IO => sd_data(4), O => sd_data_i(4), T => sd_data_t(4));
iod5 : IOBUF_F_12 port map (I => sd_data_o(5), IO => sd_data(5), O => sd_data_i(5), T => sd_data_t(5));
iod6 : IOBUF_F_12 port map (I => sd_data_o(6), IO => sd_data(6), O => sd_data_i(6), T => sd_data_t(6));
iod7 : IOBUF_F_12 port map (I => sd_data_o(7), IO => sd_data(7), O => sd_data_i(7), T => sd_data_t(7));
iod8 : IOBUF_F_12 port map (I => sd_data_o(8), IO => sd_data(8), O => sd_data_i(8), T => sd_data_t(8));
iod9 : IOBUF_F_12 port map (I => sd_data_o(9), IO => sd_data(9), O => sd_data_i(9), T => sd_data_t(9));
iod10 : IOBUF_F_12 port map (I => sd_data_o(10), IO => sd_data(10), O => sd_data_i(10), T => sd_data_t(10));
iod11 : IOBUF_F_12 port map (I => sd_data_o(11), IO => sd_data(11), O => sd_data_i(11), T => sd_data_t(11));
iod12 : IOBUF_F_12 port map (I => sd_data_o(12), IO => sd_data(12), O => sd_data_i(12), T => sd_data_t(12));
iod13 : IOBUF_F_12 port map (I => sd_data_o(13), IO => sd_data(13), O => sd_data_i(13), T => sd_data_t(13));
iod14 : IOBUF_F_12 port map (I => sd_data_o(14), IO => sd_data(14), O => sd_data_i(14), T => sd_data_t(14));
iod15 : IOBUF_F_12 port map (I => sd_data_o(15), IO => sd_data(15), O => sd_data_i(15), T => sd_data_t(15));
iod16 : IOBUF_F_12 port map (I => sd_data_o(16), IO => sd_data(16), O => sd_data_i(16), T => sd_data_t(16));
iod17 : IOBUF_F_12 port map (I => sd_data_o(17), IO => sd_data(17), O => sd_data_i(17), T => sd_data_t(17));
iod18 : IOBUF_F_12 port map (I => sd_data_o(18), IO => sd_data(18), O => sd_data_i(18), T => sd_data_t(18));
iod19 : IOBUF_F_12 port map (I => sd_data_o(19), IO => sd_data(19), O => sd_data_i(19), T => sd_data_t(19));
iod20 : IOBUF_F_12 port map (I => sd_data_o(20), IO => sd_data(20), O => sd_data_i(20), T => sd_data_t(20));
iod21 : IOBUF_F_12 port map (I => sd_data_o(21), IO => sd_data(21), O => sd_data_i(21), T => sd_data_t(21));
iod22 : IOBUF_F_12 port map (I => sd_data_o(22), IO => sd_data(22), O => sd_data_i(22), T => sd_data_t(22));
iod23 : IOBUF_F_12 port map (I => sd_data_o(23), IO => sd_data(23), O => sd_data_i(23), T => sd_data_t(23));
iod24 : IOBUF_F_12 port map (I => sd_data_o(24), IO => sd_data(24), O => sd_data_i(24), T => sd_data_t(24));
iod25 : IOBUF_F_12 port map (I => sd_data_o(25), IO => sd_data(25), O => sd_data_i(25), T => sd_data_t(25));
iod26 : IOBUF_F_12 port map (I => sd_data_o(26), IO => sd_data(26), O => sd_data_i(26), T => sd_data_t(26));
iod27 : IOBUF_F_12 port map (I => sd_data_o(27), IO => sd_data(27), O => sd_data_i(27), T => sd_data_t(27));
iod28 : IOBUF_F_12 port map (I => sd_data_o(28), IO => sd_data(28), O => sd_data_i(28), T => sd_data_t(28));
iod29 : IOBUF_F_12 port map (I => sd_data_o(29), IO => sd_data(29), O => sd_data_i(29), T => sd_data_t(29));
iod30 : IOBUF_F_12 port map (I => sd_data_o(30), IO => sd_data(30), O => sd_data_i(30), T => sd_data_t(30));
iod31 : IOBUF_F_12 port map (I => sd_data_o(31), IO => sd_data(31), O => sd_data_i(31), T => sd_data_t(31));
  

sda0 : OBUF_F_12 port map (sd_add(0), sd_add_o(0));
sda1 : OBUF_F_12 port map (sd_add(1), sd_add_o(1));
sda2 : OBUF_F_12 port map (sd_add(2), sd_add_o(2));
sda3 : OBUF_F_12 port map (sd_add(3), sd_add_o(3));
sda4 : OBUF_F_12 port map (sd_add(4), sd_add_o(4));
sda5 : OBUF_F_12 port map (sd_add(5), sd_add_o(5));
sda6 : OBUF_F_12 port map (sd_add(6), sd_add_o(6));
sda7 : OBUF_F_12 port map (sd_add(7), sd_add_o(7));
sda8 : OBUF_F_12 port map (sd_add(8), sd_add_o(8));
sda9 : OBUF_F_12 port map (sd_add(9), sd_add_o(9));
sda10 : OBUF_F_12 port map (sd_add(10), sd_add_o(10));
sdb : OBUF_F_12 port map (sd_ba, sd_ba_o);
sdr : OBUF_F_12 port map (sd_ras, sd_ras_o);
sdc : OBUF_F_12 port map (sd_cas, sd_cas_o);
sdw : OBUF_F_12 port map (sd_we, sd_we_o);
sdcke : OBUF_F_12 port map (sd_cke, sd_cke_o);
sdcs1 : OBUF_F_12 port map (sd_cs1, sd_cs1_o);
sdcs2 : OBUF_F_12 port map (sd_cs2, sd_cs2_o);
dqm0 : OBUF_F_12 port map (sd_dqm(0), sd_dqm_o(0));
dqm1 : OBUF_F_12 port map (sd_dqm(1), sd_dqm_o(1));
dqm2 : OBUF_F_12 port map (sd_dqm(2), sd_dqm_o(2));
dqm3 : OBUF_F_12 port map (sd_dqm(3), sd_dqm_o(3));
 
-- Processor interface IO PADS
rst_b : IBUF port map (O => Reset_i, I => Reset);
ads_b : IBUF port map (O => data_addr_n_i, I => data_addr_n);
wern_b : IBUF port map (O => we_rn_i, I => we_rn);

ad0  : IOBUF_F_12 port map (I => AD_o(0),  O => AD_i(0), IO => AD(0),  T => AD_tri);
ad1  : IOBUF_F_12 port map (I => AD_o(1),  O => AD_i(1), IO => AD(1),  T => AD_tri);
ad2  : IOBUF_F_12 port map (I => AD_o(2),  O => AD_i(2), IO => AD(2),  T => AD_tri);
ad3  : IOBUF_F_12 port map (I => AD_o(3),  O => AD_i(3), IO => AD(3),  T => AD_tri);
ad4  : IOBUF_F_12 port map (I => AD_o(4),  O => AD_i(4), IO => AD(4),  T => AD_tri);
ad5  : IOBUF_F_12 port map (I => AD_o(5),  O => AD_i(5), IO => AD(5),  T => AD_tri);
ad6  : IOBUF_F_12 port map (I => AD_o(6),  O => AD_i(6), IO => AD(6),  T => AD_tri);
ad7  : IOBUF_F_12 port map (I => AD_o(7),  O => AD_i(7), IO => AD(7),  T => AD_tri);
ad8  : IOBUF_F_12 port map (I => AD_o(8),  O => AD_i(8), IO => AD(8),  T => AD_tri);
ad9  : IOBUF_F_12 port map (I => AD_o(9),  O => AD_i(9), IO => AD(9),  T => AD_tri);
ad10 : IOBUF_F_12 port map (I => AD_o(10), O => AD_i(10), IO => AD(10), T => AD_tri);
ad11 : IOBUF_F_12 port map (I => AD_o(11), O => AD_i(11), IO => AD(11), T => AD_tri);
ad12 : IOBUF_F_12 port map (I => AD_o(12), O => AD_i(12), IO => AD(12), T => AD_tri);
ad13 : IOBUF_F_12 port map (I => AD_o(13), O => AD_i(13), IO => AD(13), T => AD_tri);
ad14 : IOBUF_F_12 port map (I => AD_o(14), O => AD_i(14), IO => AD(14), T => AD_tri);
ad15 : IOBUF_F_12 port map (I => AD_o(15), O => AD_i(15), IO => AD(15), T => AD_tri);
ad16 : IOBUF_F_12 port map (I => AD_o(16), O => AD_i(16), IO => AD(16), T => AD_tri);
ad17 : IOBUF_F_12 port map (I => AD_o(17), O => AD_i(17), IO => AD(17), T => AD_tri);
ad18 : IOBUF_F_12 port map (I => AD_o(18), O => AD_i(18), IO => AD(18), T => AD_tri);
ad19 : IOBUF_F_12 port map (I => AD_o(19), O => AD_i(19), IO => AD(19), T => AD_tri);
ad20 : IOBUF_F_12 port map (I => AD_o(20), O => AD_i(20), IO => AD(20), T => AD_tri);
ad21 : IOBUF_F_12 port map (I => AD_o(21), O => AD_i(21), IO => AD(21), T => AD_tri);
ad22 : IOBUF_F_12 port map (I => AD_o(22), O => AD_i(22), IO => AD(22), T => AD_tri);
ad23 : IOBUF_F_12 port map (I => AD_o(23), O => AD_i(23), IO => AD(23), T => AD_tri);
ad24 : IOBUF_F_12 port map (I => AD_o(24), O => AD_i(24), IO => AD(24), T => AD_tri);
ad25 : IOBUF_F_12 port map (I => AD_o(25), O => AD_i(25), IO => AD(25), T => AD_tri);
ad26 : IOBUF_F_12 port map (I => AD_o(26), O => AD_i(26), IO => AD(26), T => AD_tri);
ad27 : IOBUF_F_12 port map (I => AD_o(27), O => AD_i(27), IO => AD(27), T => AD_tri);
ad28 : IOBUF_F_12 port map (I => AD_o(28), O => AD_i(28), IO => AD(28), T => AD_tri);
ad29 : IOBUF_F_12 port map (I => AD_o(29), O => AD_i(29), IO => AD(29), T => AD_tri);
ad30 : IOBUF_F_12 port map (I => AD_o(30), O => AD_i(30), IO => AD(30), T => AD_tri);
ad31 : IOBUF_F_12 port map (I => AD_o(31), O => AD_i(31), IO => AD(31), T => AD_tri);
 
end architecture sdrm_arch;



