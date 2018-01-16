library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;
use IEEE.std_logic_unsigned.all;

entity ki_cntr is
  port (ki_end : out std_logic;
  	Reset : in std_logic;
	Clk : in std_logic;
	ld_ki : in std_logic;
	ki_max : in unsigned(3 downto 0));
end entity ki_cntr;

architecture ki_cntr_arch of ki_cntr is

signal count_N_sig : unsigned(3 downto 0);
signal count_sig : unsigned(3 downto 0);

begin

process (Clk, Reset)
variable count : unsigned(3 downto 0);
begin
  if (Reset = '0') then
    count := (others => '0');
  elsif rising_edge(Clk) then 
    if (ld_ki = '1') then
      count := ki_max;
    else
      count := count_N_sig;
	 end if;
	 count_sig <= count;
end if;
end process;

process (count_sig)
variable ki_end_int : std_logic;
variable count_N : unsigned(3 downto 0);
--variable one : std_logic := '1';
begin
  if (count_sig = "0000") then
    count_N := "0000";
    ki_end_int := '1';
  else
    count_N := count_sig - 1 ;
    ki_end_int := '0';
  end if;
count_N_sig <= count_N;
ki_end <= ki_end_int;
end process;


end architecture ki_cntr_arch;



