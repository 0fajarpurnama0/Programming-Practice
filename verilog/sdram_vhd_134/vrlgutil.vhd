--
-- interHDL proprietary information
-- Copyright (C) 1990-1998 interHDL inc.
-- All rights reserved.
--
-- ihdlutil package. produced by interVHDL (R)
-- vrlgutil package. Implements the Verilog built-in functions and tasks. Use the m4
-- Unix utility to convert from vrlgutils.vhd.template to vrlgutils.vhd or use a text
-- editor to manually do the conversion as shown in the line below.

library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
--USE ieee.std_logic_unsigned.all;

-- synopsys translate_off
library std;
USE std.textio.all;
-- synopsys translate_on

package vrlgutil is

-- synopsys translate_off

procedure write(l:inout line; v:in std_logic);
procedure write(l:inout line; v:in std_logic_vector);
procedure write(l:inout line; v:in std_logic_vector; c:in character);

procedure display(l:inout line; v:in std_logic);
procedure display(l:inout line; v:in std_logic_vector);
procedure display(l:inout line; v:in std_logic_vector; c:in character);
procedure display(l:inout line; v:in integer);
procedure display(l:inout line; v:in string);
procedure display(l:inout line; v:in time);
procedure newline(l:inout line);
procedure stop;
procedure finish;

-- synopsys translate_on

end vrlgutil;


package body vrlgutil is

-- synopsys translate_off

procedure display(l:inout line; v:in std_logic) is
begin
  write(l, v);
end display;

procedure display(l:inout line; v:in std_logic_vector) is
begin
  write(l, v);
end display;

procedure display(l:inout line; v:in std_logic_vector; c:in character) is
begin
  write(l, v, c);
end display;

procedure display(l:inout line; v:in integer) is
begin
  write(l, v);
end display;

procedure display(l:inout line; v:in string) is
begin
  write(l, v);
end display;

procedure display(l:inout line; v:in time) is
begin
  write(l, v);
end display;

procedure newline (l:inout line) is
begin
  writeline(OUTPUT, l);
end newline;

procedure write(l:inout line; v:in std_logic) is
begin
  if v = '0' then
    write(l, string'("0"));
  elsif v = '1' then
    write(l, string'("1"));
  elsif v = 'X' then
    write(l, string'("X"));
  elsif v = 'Z' then
    write(l, string'("Z"));
  end if;
end write;

procedure write(l:inout line; v:in std_logic_vector) is
begin
  for i in v'range loop
    write(l, v(i));
  end loop;
end write;

procedure write(l:inout line; v:in std_logic_vector; c:in character) is
variable value : integer;
variable unit : integer;
variable nybbles : integer;
variable part : integer;
variable switch : std_logic_vector (3 downto 0);
variable vtemp  : std_logic_vector ( (v'high+( 4 - ((v'high+1) mod 4))  ) downto 0);
begin
  case c is
  when 'd' => -- decimal
    value := 0;
    if v'high < 31 then
      unit := 2 ** (v'high);
    else
      unit := 2 ** 30;
    end if;
    for i in v'range loop
      if i < 31 then
        if v(i) = '1' then
          value := value + unit;
        end if;
        unit := unit / 2;
      end if;
    end loop;
    write(l, value);
  when 'h' =>
    nybbles := (v'high + 1) / 4;
    part    := (v'high + 1) mod 4;
    if part /= 0 then
      nybbles := nybbles + 1;
    end if;
    vtemp := (others => '0');
    vtemp(v'high downto 0) := v;
      for i in nybbles downto 1 loop
      switch := vtemp( ((i * 4) - 1) downto ((i * 4) -4));
      case switch is
        when "0000" => write(l, string'("0"));
        when "0001" => write(l, string'("1"));
        when "0010" => write(l, string'("2"));
        when "0011" => write(l, string'("3"));
        when "0100" => write(l, string'("4"));
        when "0101" => write(l, string'("5"));
        when "0110" => write(l, string'("6"));
        when "0111" => write(l, string'("7"));
        when "1000" => write(l, string'("8"));
        when "1001" => write(l, string'("9"));
        when "1010" => write(l, string'("A"));
        when "1011" => write(l, string'("B"));
        when "1100" => write(l, string'("C"));
        when "1101" => write(l, string'("D"));
        when "1110" => write(l, string'("E"));
        when "1111" => write(l, string'("F"));
        when others => write(l, string'("X"));
      end case;
      end loop;
  when others => -- i.e binary
    for i in v'range loop
      write(l, v(i));
    end loop;
  end case;
end write;

procedure stop is
begin
  assert FALSE report "Simulation stopped" severity failure; -- Simulator dependent
end stop;

procedure finish is
begin
  assert FALSE report "Simulation finished" severity failure ; -- Simulator dependent
end finish;

-- synopsys translate_on

end vrlgutil;

