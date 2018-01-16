library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;

entity sdrmc_state is 
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
end entity sdrmc_state;

architecture sdrmc_state_arch of sdrmc_state is

signal state: std_logic_vector(13 downto 1) := "0000000000001";
signal next_state: std_logic_vector(13 downto 1);

constant cd_idle: integer  := 1;
constant cd_prech: integer := 2;
constant cd_load_mr: integer := 3;
constant cd_pre_ar: integer := 4;
constant cd_ar: integer := 5;
constant cd_act: integer := 6;
constant cd_read_w: integer := 7;
constant cd_read_cs: integer := 8;
constant cd_read_c: integer := 9;
constant cd_read: integer := 10;
constant cd_write_w: integer := 11;
constant cd_write_c: integer := 12;
constant cd_write: integer := 13;

signal c_idle: std_logic;
signal c_prech: std_logic;
signal c_load_mr: std_logic;
signal c_pre_ar: std_logic;
signal c_ar: std_logic;
signal c_act: std_logic;
signal c_read_w: std_logic;
signal c_read_cs: std_logic;
signal c_read_c: std_logic;
signal c_read: std_logic;
signal c_write_w: std_logic;
signal c_write_c: std_logic;
signal c_write: std_logic;

signal temp1 : std_logic_vector(3 downto 0);

begin

c_idle <= state(cd_idle);
c_prech <= state(cd_prech);
c_load_mr <= state(cd_load_mr);
c_pre_ar <= state(cd_pre_ar);
c_ar <= state(cd_ar);
c_act <= state(cd_act);
c_read_w <= state(cd_read_w);
c_read_cs <= state(cd_read_cs);
c_read_c <= state(cd_read_c);
c_read <= state(cd_read);
c_write_w <= state(cd_write_w);
c_write_c <= state(cd_write_c);
c_write <= state(cd_write);

pre_sd_ras_p <= not(c_act or c_prech or c_load_mr or c_ar);
pre_sd_cas_p <= not(c_read_cs or c_write_c or c_load_mr or c_ar);
pre_sd_we_p <= not(c_write_c or c_prech or c_load_mr);
pre_clr_ref <= c_pre_ar or c_ar;

pre_sd_doe_n <= not(c_write or c_write_c);
pre_sd_add_mx <= (c_idle or c_act or c_prech or c_load_mr or c_ar or c_pre_ar);
pre_ld_cslt <= not(c_read_cs or c_read_c or c_read);
pre_ld_brst <= not(c_read_c or c_read or c_write or c_write_c);
pre_ld_rcd <= not(c_act or c_read_cs or c_read_w or c_write_c);
pre_sd_doe2_n <= not(c_act or c_write_w);
pre_sd_ready <= c_read;
pre_ad_tri <= not(c_read_c or c_read);
temp1 <= ki_end & Act_st;

process (Clk, Reset, next_state)
begin
  if (Reset = '0') then
    state <= "0000000000001";
  elsif rising_edge(Clk) then
      state <= next_state;
  end if;
end process;

process (ki_end, state, Reset, auto_ref, cslt_end, brst_end, rcd_end, Act_st, temp1, write_st, clr_ref)
begin

  next_state <= "0000000000000";
  case state is 
    when "0000000000001" => case temp1 is
								when "1100" => next_state(cd_act) <= '1';
								when "1111" => next_state(cd_pre_ar) <= '1';
								when "1110" => next_state(cd_prech) <= '1';
								when "1101" => next_state(cd_load_mr) <= '1';
								when "1000" | "1001" | "1010" | "1011" => if ((auto_ref = '1') and (clr_ref = '0')) then
																			next_state(cd_pre_ar) <= '1';
																		else 
																			next_state(cd_idle) <= '1';
																	 end if;
								when others => next_state(cd_idle) <= '1';
							 end case;
    when "0000000000010" => next_state(cd_idle) <= '1';
    when "0000000000100" => next_state(cd_idle) <= '1';
    when "0000000001000" => next_state(cd_ar) <= '1';
    when "0000000010000" => next_state(cd_idle) <= '1';
    when "0000000100000" => if (write_st = '1') then 
								         if (rcd_end = '1') then
									        next_state(cd_write_c) <= '1';
								         else
								   	      next_state(cd_write_w) <= '1';
								         end if;
							          else
								         if (rcd_end = '1') then
									        next_state(cd_read_cs) <= '1';
								         else
									        next_state(cd_read_w) <= '1';
								         end if;
							          end if;
    when "0010000000000" => if (rcd_end = '1') then
												next_state(cd_write_c) <= '1';
											else 
												next_state(cd_write_w) <= '1';
											end if;
    when "0100000000000" => if (brst_end = '1') then
												next_state(cd_idle) <= '1';
								 			else
												next_state(cd_write) <= '1';
											end if;
    when "1000000000000" => if (brst_end = '1') then
								         	next_state(cd_idle) <= '1';
							         	else
								          next_state(cd_write) <= '1';
								       end if;
    when "0000001000000" => if (rcd_end = '1') then
												next_state(cd_read_cs) <= '1';
											else
												next_state(cd_read_w) <= '1';
											end if;
    when "0000010000000" => next_state(cd_read_c) <= '1';
    when "0000100000000" => if (cslt_end = '1') then
												next_state(cd_read) <= '1';
											else
												next_state(cd_read_c) <= '1';
											end if;
    when "0001000000000" => if (brst_end = '1') then
												next_state(cd_idle) <= '1';
											else
												next_state(cd_read) <= '1';
											end if;
	 when others => next_state(cd_idle) <= '1';
  end case;
end process;

end architecture sdrmc_state_arch; 












