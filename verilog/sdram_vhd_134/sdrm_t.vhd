library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;
library UNISIM;
--use UNISIM.vcomponents.all;

entity sdrm_t is 
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
end entity sdrm_t;

architecture sdrm_t_arch of sdrm_t is

component sdrmc_state 
port (	pre_sd_doe_n : out std_logic;
	pre_sd_doe2_n, pre_sd_ready, pre_sd_add_mx: out std_logic;
	pre_sd_ras_p: out std_logic;
	pre_sd_we_p: out std_logic; 
	pre_clr_ref: out std_logic;
	pre_sd_cas_p: out std_logic;
	pre_ld_cslt: out std_logic;
	pre_ld_brst: out std_logic;
	pre_ld_rcd: out std_logic;
	pre_ad_tri: out std_logic;
	Reset, Clk, brst_end, cslt_end, rcd_end: in std_logic;
	auto_ref, ki_end, clr_ref: in std_logic;
	Act_st: in std_logic_vector(2 downto 0);
	write_st: in std_logic);
end component;

component rcd_cntr
  port (rcd_end : out std_logic;
  	Reset : in std_logic;
	Clk : in std_logic;
	ld_rcd : in std_logic;
	rcd_max : in unsigned(1 downto 0));
end component;

component brst_cntr
port (	brst_end: out std_logic;
	brst_end_m1: out std_logic;
	Reset: in std_logic;
	Clk: in std_logic;
	ld_brst: in std_logic;
	brst_max: in unsigned(2 downto 0));
end component;

component cslt_cntr
  port (cslt_end : out std_logic;
  	Reset : in std_logic;
	Clk : in std_logic;
	ld_cslt : in std_logic;
	cslt_max : in unsigned(1 downto 0));
end component;

component ref_cntr
port (	auto_ref: out std_logic;
	p_auto_ref: out std_logic;
	Reset: in std_logic;
	Clk: in std_logic;
	clr_ref: in std_logic;
	ref_max: in unsigned(15 downto 0));
end component;

component ki_cntr
  port (ki_end : out std_logic;
  	Reset : in std_logic;
	Clk : in std_logic;
	ld_ki : in std_logic;
	ki_max : in unsigned(3 downto 0));
end component;

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

signal sd_doe_n_temp: std_logic_vector(3 downto 0);
signal clr_ref: std_logic;
signal auto_ref_s: std_logic;
signal pre_locked: std_logic;
signal brst_end_m1: std_logic;
signal brst_end: std_logic;
signal clr_ref_d: std_logic;
signal cslt_end: std_logic;
signal ki_end: std_logic;
signal p_auto_ref: std_logic;
signal sd_add_mx: std_logic;
signal ld_cslt: std_logic;
signal pre_sd_ras_p: std_logic;
signal pre_sd_cas_p: std_logic;
signal pre_sd_we_p: std_logic;
signal pre_sd_doe_n: std_logic;
signal pre_sd_doe2_n: std_logic;
signal pre_sd_add_mx: std_logic;
signal pre_ld_cslt: std_logic;
signal pre_ld_brst: std_logic;
signal pre_ld_rcd: std_logic;
signal pre_clr_ref: std_logic;
signal pre_sd_ready: std_logic;
signal pre_ad_tri: std_logic;
signal ld_rcd: std_logic;
signal ld_brst: std_logic;
signal rcd_end_int: std_logic;
signal Locked_j_int: std_logic;
signal Locked_i_int: std_logic;

signal one : std_logic := '1';
signal zero : std_logic := '0';

begin

sdrm_st : sdrmc_state port map (
	Reset => Locked_i_int, Clk => Clk_i, Act_st => Act_st,
	write_st => write_st, pre_sd_ras_p => pre_sd_ras_p,
	pre_sd_cas_p => pre_sd_cas_p, pre_sd_we_p => pre_sd_we_p, 
	pre_sd_doe_n => pre_sd_doe_n, pre_sd_doe2_n => pre_sd_doe2_n, 
	pre_sd_add_mx => pre_sd_add_mx, cslt_end => cslt_end, 
	pre_ld_cslt => pre_ld_cslt, brst_end => brst_end, 
	pre_ld_brst => pre_ld_brst, rcd_end => rcd_end_int, 
	pre_ld_rcd => pre_ld_rcd, auto_ref => auto_ref_in, 
	pre_clr_ref => pre_clr_ref, clr_ref => clr_ref, 
	ki_end => ki_end, pre_sd_ready => pre_sd_ready, 
	pre_ad_tri => pre_ad_tri); 
  
cslt_cntr_inst : cslt_cntr port map (
	Reset => Locked_i_int, Clk => Clk_i, 
	cslt_max => cas_lat_max,
	cslt_end => cslt_end, ld_cslt => ld_cslt);

brst_cntr_inst : brst_cntr port map (
	Reset => Locked_i_int, Clk => Clk_i, brst_max => burst_max,
	brst_end => brst_end, brst_end_m1 => brst_end_m1, 
	ld_brst => ld_brst);
   
rcd_cntr_inst : rcd_cntr port map (
	Reset => Locked_i_int, Clk => Clk_i, rcd_max => rcd_c_max,
	rcd_end => rcd_end_int, ld_rcd => ld_rcd);
   
ref_cntr_inst : ref_cntr port map ( 
	Reset => Locked_j_int, Clk => Clk_j, ref_max => ref_max,
	auto_ref => auto_ref_s, p_auto_ref => p_auto_ref,
	clr_ref => clr_ref);
   
ki_cntr_inst : ki_cntr port map ( 
	Reset => Locked_i_int, Clk => Clk_i, ki_max => ki_max,
	ki_end => ki_end, ld_ki => clr_ref);
   
--delay pre_locked signal by 5 clock periods
SRL16_inst : SRL16 port map (
	Q => Locked_j_int, A0 => zero, A1 => zero, A2 => one, A3 => zero, 
	D => pre_locked, CLK => Clk_j);

--delay pre_ad_tri by 5 clk periods
I_AD_tri : SRL16 port map (
	Q => AD_tri, A0 => zero, A1 => zero, A2 => one, A3 => zero, 
	D => pre_ad_tri, CLK => Clk_i);

clr_ref <= clr_ref_d;
kid <= (p_auto_ref or auto_ref_s or (not(ki_end)) );
auto_ref_out <= auto_ref_s;
pre_locked <= (Locked1 and Locked2);
sd_doe_n_temp <=  ( not((not(pre_sd_doe_n) and not(brst_end_m1) and not(brst_end)) or (not(pre_sd_doe2_n) and rcd_end_int))
        & not((not(pre_sd_doe_n) and not(brst_end_m1) and not(brst_end)) or (not(pre_sd_doe2_n) and rcd_end_int))
        & not((not(pre_sd_doe_n) and not(brst_end_m1) and not(brst_end)) or (not(pre_sd_doe2_n) and rcd_end_int))
        & not((not(pre_sd_doe_n) and not(brst_end_m1) and not(brst_end)) or (not(pre_sd_doe2_n) and rcd_end_int)) );
rcd_end <= rcd_end_int;
Locked_j <= Locked_j_int;
Locked_i <= Locked_i_int;

process (Clk_i)
begin
if rising_edge(Clk_i) then
  Locked_i_int <= Locked_j_int;
end if;
end process;

process (Clk_i, Locked_i_int)
begin
if rising_edge(Clk_i) then
  if (Locked_i_int = '0') then
    sd_ras_o <= '1';
    sd_cas_o <= '1';
    sd_we_o <= '1';
    sd_doe_n <= "1111";
    clr_ref_d <= '0';
    sd_add_mx <= '0';
    ld_cslt <= '1';
    ready_o <= '0';
    ld_rcd <= '1';
    sd_add_o <= "00000000000";
    sd_ba_o <= '0';
  else
    ld_cslt <=  pre_ld_cslt;
    ld_brst <=  pre_ld_brst;
    ld_rcd  <=  pre_ld_rcd;
    clr_ref_d <= pre_clr_ref;	
    sd_add_mx <=  pre_sd_add_mx;
    sd_doe_n  <= sd_doe_n_temp;  
    ready_o  <= transport pre_sd_ready after 3 ns;
    sd_ras_o <= transport pre_sd_ras_p after 3 ns;
    sd_cas_o <= transport pre_sd_cas_p after 3 ns;
    sd_we_o  <= transport pre_sd_we_p after 3 ns;
    if (sd_add_mx = '1') then 
      sd_add_o(10 downto 0) <= transport Add_reg(20 downto 10) after 3 ns;
    else
     sd_add_o(10 downto 0) <= transport ("101" & Add_reg(9 downto 2)) after 3 ns;
    end if;
    sd_ba_o <= transport Add_reg(21) after 3 ns;
  end if;
end if;
end process;

end architecture sdrm_t_arch;
  




