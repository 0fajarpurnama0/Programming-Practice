library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all;

entity ref_cntr is
port (	auto_ref: out std_logic;
	p_auto_ref: out std_logic;
	Reset: in std_logic;
	Clk: in std_logic;
	clr_ref: in std_logic;
	ref_max: in unsigned(15 downto 0));
end entity ref_cntr;

architecture ref_cntr_arch of ref_cntr is 

signal rcount: unsigned(15 downto 0);
signal count_N: unsigned(15 downto 0);

begin

process (Clk, Reset, ref_max, count_N, rcount, clr_ref)
begin
  if (Reset = '0') then
    rcount <= ref_max;
    auto_ref <= '0';
  elsif rising_edge(Clk) then
    rcount <= count_N;
    if (rcount = X"0000") then
      auto_ref <= '1';
      if (clr_ref = '1') then
        auto_ref <= '1';
        p_auto_ref <= '0';
        if (rcount = X"0003") then
          p_auto_ref <= '1';
        end if;
      end if;
    end if;
  end if;
end process;

process (rcount, ref_max)
begin
  if (rcount = X"0000") then
    count_N <= ref_max;
  else
    count_N <= rcount - 1;
  end if;
end process;

end architecture ref_cntr_arch;
