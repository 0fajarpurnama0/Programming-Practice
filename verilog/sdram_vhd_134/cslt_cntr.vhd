library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;
use IEEE.std_logic_unsigned.all;

entity rcd_cntr is
  port (rcd_end : out std_logic;
  	Reset : in std_logic;
	Clk : in std_logic;
	ld_rcd : in std_logic;
	rcd_max : in unsigned(1 downto 0));
end entity rcd_cntr;

architecture rcd_cntr_arch of rcd_cntr is

signal count_N_sig : unsigned(1 downto 0);
signal count_sig : unsigned(1 downto 0);

begin

process (Clk, Reset)
variable count : unsigned(1 downto 0);
begin
  if (Reset = '0') then
    count := (others => '0');
  elsif rising_edge(Clk) then 
    if (ld_rcd = '1') then
      count := rcd_max;
    else
      count := count_N_sig;
    end if;
	 count_sig <= count;
  end if;
end process;

process (count_sig)
variable rcd_end_int : std_logic;
variable count_N : unsigned(1 downto 0);
begin
  if (count_sig = "00") then
    count_N := "00";
    rcd_end_int := '1';
  else
    count_N := count_sig - 1 ;
    rcd_end_int := '0';
  end if;
count_N_sig <= count_N;
rcd_end <= rcd_end_int;
end process;

end architecture rcd_cntr_arch;



