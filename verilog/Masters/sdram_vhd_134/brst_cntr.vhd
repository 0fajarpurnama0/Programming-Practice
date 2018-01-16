library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;

entity brst_cntr is
port (	brst_end: out std_logic;
	brst_end_m1: out std_logic;
	Reset: in std_logic;
	Clk: in std_logic;
	ld_brst: in std_logic;
	brst_max: in unsigned(2 downto 0));
end entity brst_cntr;

architecture brst_cntr_arch of brst_cntr is

signal count: unsigned(2 downto 0);
signal count_N: unsigned(2 downto 0);

begin

process (Clk, Reset, ld_brst, count_N)
begin
if (Reset = '0') then
  count <= "000";
elsif rising_edge(Clk) then 
  if (ld_brst = '1') then
    count <= brst_max;
  else
    count <= count_N;
  end if;
end if;
end process;

process (count)
begin
if (count = "000") then
  count_N <= "000";
  brst_end <= '1';
  brst_end_m1 <= '0';
elsif (count = "001") then
  count_N <= count - 1;
  brst_end <= '0';
  brst_end_m1 <= '1';
else
  count_N <= count - 1;
  brst_end <= '0';
  brst_end_m1 <= '0';
end if;
end process;

end architecture brst_cntr_arch;
