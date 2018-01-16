--
-- interHDL proprietary information
-- Copyright (C) 1990-1998 interHDL inc.
-- All rights reserved.
--
-- ihdlutil package. produced by interVHDL (R)
-- ihdlutil package. Implements utility functions for the VtoVH translator. Use the m4
-- Unix utility to convert from vrlgutils.vhd.template to vrlgutils.vhd or use a text
-- editor to manually do the conversion as shown in the line below.

library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
--USE ieee.std_logic_unsigned.all;


package ihdlutil is
function COND(c: std_logic; l, r: integer) return integer;
function COND(c: std_logic; l, r: std_logic) return std_logic;
function COND(c: std_logic; l, r: std_logic_vector) return std_logic_vector;
function bool2stdlogic(c: boolean) return std_logic;
function bool2integer(c: boolean) return integer;
function bool2stdlogic_vector(c: boolean; l: integer) return std_logic_vector;
function eq2std_logic (l, r: std_logic) return std_logic;
function eq2std_logic (l, r: std_logic_vector) return std_logic;
function eq2std_logic (l, r: integer) return std_logic;
function eq2std_logic (l, r: boolean) return std_logic;
function eq2integer (l, r: std_logic) return integer;
function eq2integer (l, r: std_logic_vector) return integer;
function eq2integer (l, r: integer) return integer;
function eq2integer (l, r: boolean) return integer;
function neq2std_logic (l, r: std_logic) return std_logic;
function neq2std_logic (l, r: std_logic_vector) return std_logic;
function neq2std_logic (l, r: integer) return std_logic;
function neq2std_logic (l, r: boolean) return std_logic;
function neq2integer (l, r: std_logic) return integer;
function neq2integer (l, r: std_logic_vector) return integer;
function neq2integer (l, r: integer) return integer;
function neq2integer (l, r: boolean) return integer;
function OR_REDUCE(v: std_logic_vector) return std_logic;
function OR_REDUCE(v: std_logic) return std_logic;
function NOR_REDUCE(v: std_logic_vector) return std_logic;
function NOR_REDUCE(v: std_logic) return std_logic;
function AND_REDUCE(v: std_logic_vector) return std_logic;
function AND_REDUCE(v: std_logic) return std_logic;
function NAND_REDUCE(v: std_logic_vector) return std_logic;
function NAND_REDUCE(v: std_logic) return std_logic;
function XOR_REDUCE(v: std_logic_vector) return std_logic;
function XOR_REDUCE(v: std_logic) return std_logic;
function XNOR_REDUCE(v: std_logic_vector) return std_logic;
function XNOR_REDUCE(v: std_logic) return std_logic;
function stdlogic_to_int(v:std_logic_vector) return integer;
function shl (v: std_logic_vector; count: integer) return std_logic_vector;
function shr (v: std_logic_vector; count: integer) return std_logic_vector;
function shl (v: std_logic_vector; count: std_logic_vector) return std_logic_vector;
function shr (v: std_logic_vector; count: std_logic_vector) return std_logic_vector;
function shl (v: std_logic_vector; count: std_logic) return std_logic_vector;
function shr (v: std_logic_vector; count: std_logic) return std_logic_vector;
function shl (v: integer; count: integer) return integer;
function shr (v: integer; count: integer) return integer;
function shl (v: std_logic; count: integer) return std_logic;
function shr (v: std_logic; count: integer) return std_logic;
function "=" (l: integer; r: std_logic_vector) return boolean;
function "=" (l: std_logic_vector; r: integer) return boolean;
function "=" (l: integer; r: std_logic) return boolean;
function "=" (l: std_logic; r: integer) return boolean;
function compareX (lft, rgt: integer) return boolean;
function compareZ (lft, rgt: integer) return boolean;
function compareX (lft, rgt: std_logic) return boolean;
function compareZ (lft, rgt: std_logic) return boolean;
function compareX (lft, rgt: std_logic_vector) return boolean;
function compareZ (lft, rgt: std_logic_vector) return boolean;
function "+" (lft: std_ulogic; rgt: std_ulogic) return std_logic_vector;
function "+" (lft: std_ulogic; rgt: std_ulogic) return std_logic;
function "+" (lft: std_logic_vector; rgt: std_logic_vector) return std_logic_vector;
function "-" (lft: std_ulogic; rgt: std_ulogic) return std_logic_vector;
function "-" (lft: std_ulogic; rgt: std_ulogic) return std_logic;
function "-" (lft: std_logic_vector; rgt: std_logic_vector) return std_logic_vector;
function conv_std_logic (lft: integer) return std_logic;
function conv_std_logic (lft: std_logic_vector) return std_logic;
function conv_std_logic_vector (lft: std_logic) return std_logic_vector;
function conv_std_logic_vector (lft: boolean) return std_logic_vector;
function conv_integer (lft: std_logic_vector) return integer;
function mult_concat(i : integer; s: std_logic) return std_logic_vector;
function mult_concat(i : integer; s: std_logic_vector) return std_logic_vector;
end ihdlutil;

package body ihdlutil is
function COND(c: std_logic; l, r: integer) return integer is
   variable cc: integer;
begin
  if l = r then cc := l;
  elsif c = '1' then cc := l;
  elsif c = '0' then cc := r;
  else cc := 0;
  end if;
  return cc;
end COND;
function COND(c: std_logic; l, r: std_logic) return std_logic is
   variable cc: std_logic;
begin
  if l = r then cc := l;
  elsif c = '1' then cc := l;
  elsif c = '0' then cc := r;
  else cc := 'X';
  end if;
  return cc;
end COND;
function COND(c: std_logic; l, r: std_logic_vector) return std_logic_vector is
   variable cc: std_logic_vector (l'length-1 downto 0);
begin
  if l = r then cc := l;
  elsif c = '1' then cc := l;
  elsif c = '0' then cc := r;
  else
  for i in l'length-1 downto 0 loop
    cc(i) := 'X';
  end loop;
  end if;
  return cc;
end COND;

function bool2stdlogic(c: boolean) return std_logic is begin
	if c then return '1';
	else return '0';
	end if;
end bool2stdlogic;

function bool2integer(c: boolean) return integer is begin
	if c then return 1;
	else return 0;
	end if;
end bool2integer;

function bool2stdlogic_vector(c: boolean; l: integer) return std_logic_vector is
   variable cc: std_logic_vector (l-1 downto 0);
begin
  for i in l-1 downto 0 loop
    cc(i) := '0';
  end loop;
  if c then
    cc(0) := '1';
  else
    cc(0) := '0';
  end if;
  return cc;
end bool2stdlogic_vector;

function eq2std_logic (l, r: std_logic) return std_logic is
begin
	if (l XOR r) = 'X' then
	  return 'X';
	elsif l = r then return '1';
	else return '0';
	end if;
end eq2std_logic;
function eq2std_logic (l, r: std_logic_vector) return std_logic is
begin
	if XOR_REDUCE(l)='X' OR XOR_REDUCE(r)='X' then
	  return 'X';
	elsif l = r then return '1';
	else return '0';
	end if;
end eq2std_logic;
function eq2std_logic (l, r: integer) return std_logic is
begin
	if l = r then return '1';
	else return '0';
	end if;
end eq2std_logic;
function eq2std_logic (l, r: boolean) return std_logic is
begin
	if l = r then return '1';
	else return '0';
	end if;
end eq2std_logic;
function eq2integer (l, r: std_logic) return integer is
begin
	if (l XOR r) = 'X' then
	  return 0;
	elsif l = r then return 1;
	else return 0;
	end if;
end eq2integer;
function eq2integer (l, r: std_logic_vector) return integer is
begin
	if XOR_REDUCE(l)='X' OR XOR_REDUCE(r)='X' then
	  return 0;
	elsif l = r then return 1;
	else return 0;
	end if;
end eq2integer;
function eq2integer (l, r: integer) return integer is
begin
	if l = r then return 1;
	else return 0;
	end if;
end eq2integer;
function eq2integer (l, r: boolean) return integer is
begin
	if l = r then return 1;
	else return 0;
	end if;
end eq2integer;
function neq2std_logic (l, r: std_logic) return std_logic is
begin
	if (l XOR r) = 'X' then
	  return 'X';
	elsif l /= r then return '1';
	else return '0';
	end if;
end neq2std_logic;
function neq2std_logic (l, r: std_logic_vector) return std_logic is
begin
	if XOR_REDUCE(l)='X' OR XOR_REDUCE(r)='X' then
	  return 'X';
	elsif l /= r then return '1';
	else return '0';
	end if;
end neq2std_logic;
function neq2std_logic (l, r: integer) return std_logic is
begin
	if l /= r then return '1';
	else return '0';
	end if;
end neq2std_logic;
function neq2std_logic (l, r: boolean) return std_logic is
begin
	if l /= r then return '1';
	else return '0';
	end if;
end neq2std_logic;
function neq2integer (l, r: std_logic) return integer is
begin
	if (l XOR r) = 'X' then
	  return 1;
	elsif l /= r then return 1;
	else return 0;
	end if;
end neq2integer;
function neq2integer (l, r: std_logic_vector) return integer is
begin
	if XOR_REDUCE(l)='X' OR XOR_REDUCE(r)='X' then
	  return 1;
	elsif l /= r then return 1;
	else return 0;
	end if;
end neq2integer;
function neq2integer (l, r: integer) return integer is
begin
	if l /= r then return 1;
	else return 0;
	end if;
end neq2integer;
function neq2integer (l, r: boolean) return integer is
begin
	if l /= r then return 1;
	else return 0;
	end if;
end neq2integer;
function OR_REDUCE(v: std_logic_vector) return std_logic is
variable result: std_logic;
begin
  result:='0';
  for i in v'high downto v'low loop
    if v(i)='1' then
      return '1';
    elsif v(i)='Z' or v(i)='X' then
      result:='X';
    end if;
  end loop;
  return result;
end OR_REDUCE;

function OR_REDUCE(v: std_logic) return std_logic is
begin
  return v;
end OR_REDUCE;

function NOR_REDUCE(v: std_logic_vector) return std_logic is
begin
  return NOT OR_REDUCE(v);
end NOR_REDUCE;

function NOR_REDUCE(v: std_logic) return std_logic is
begin
  return NOT OR_REDUCE(v);
end NOR_REDUCE;

function AND_REDUCE(v: std_logic_vector) return std_logic is
variable result: std_logic;
begin
  result:='1';
  for i in v'high downto v'low loop
    if v(i)='0' then
      return '0';
    elsif v(i)='Z' or v(i)='X' then
      result:='X';
    end if;
  end loop;
  return result;
end AND_REDUCE;

function AND_REDUCE(v: std_logic) return std_logic is
begin
  return v;
end AND_REDUCE;

function NAND_REDUCE(v: std_logic_vector) return std_logic is
begin
  return NOT AND_REDUCE(v);
end NAND_REDUCE;

function NAND_REDUCE(v: std_logic) return std_logic is
begin
  return NOT AND_REDUCE(v);
end NAND_REDUCE;

function XOR_REDUCE(v: std_logic_vector) return std_logic is
variable result: std_logic;
begin
  result:='0';
  for i in v'high downto v'low loop
    if v(i)='X' or v(i)='Z' or v(i)='U' then
      return 'X';
    elsif v(i)='1' then
      result:=not result;
    end if;
  end loop;
  return result;
end XOR_REDUCE;

function XOR_REDUCE(v: std_logic) return std_logic is
begin
  return v;
end XOR_REDUCE;

function XNOR_REDUCE(v: std_logic_vector) return std_logic is
begin
  return NOT XOR_REDUCE(v);
end XNOR_REDUCE;

function XNOR_REDUCE(v: std_logic) return std_logic is
begin
  return NOT XOR_REDUCE(v);
end XNOR_REDUCE;

function shl (v: std_logic_vector; count: integer) return std_logic_vector is
	variable shl_reg: std_logic_vector (v'length-1 downto 0);
	variable vv: std_logic_vector (v'length-1 downto 0);
	variable i: integer;
begin
   vv:=v;
   if count>=v'length then
      shl_reg := (others => '0');
      return shl_reg;
   end if;
   shl_reg := v;
   for i in 0 to v'length-1 loop
      if i < count then
         shl_reg(i) := '0';
      else
         shl_reg(i) := vv(i - count);
      end if;
   end loop;
   return (shl_reg);
end shl;

function shr (v: std_logic_vector; count: integer) return std_logic_vector is
	variable shr_reg: std_logic_vector (v'length-1 downto 0);
	variable vv: std_logic_vector (v'length-1 downto 0);
	variable i: integer;
begin
   vv:=v;
   if count>=v'length then
      shr_reg := (others => '0');
      return shr_reg;
   end if;
   shr_reg := v;
   for i in v'length-1 downto 0 loop
      if i < count then
         shr_reg(v'length-i-1) := '0';
      else
         shr_reg(v'length-i-1) := vv(v'length-i-1 + count);
      end if;
   end loop;
   return (shr_reg);
end shr;

function stdlogic_to_int(v:std_logic_vector) return integer is
variable result: integer;
begin
  result:=0;
  for i in v'length-1 downto 0 loop
    result := result*2;
    if v(i) = '1' then
      result := result+1;
    elsif v(i) /= '0' then
      return 0;
    end if;
  end loop;
  return result;
end stdlogic_to_int;

function shl (v: std_logic_vector; count: std_logic_vector) return std_logic_vector is
begin
  return shl(v, stdlogic_to_int(count));
end shl;

function shr (v: std_logic_vector; count: std_logic_vector) return std_logic_vector is
begin
  return shr(v, stdlogic_to_int(count));
end shr;

function shl (v: std_logic_vector; count: std_logic) return std_logic_vector is
begin
  if count='1' then
    return shl(v, 1);
  else
    return v;
  end if;
end shl;

function shr (v: std_logic_vector; count: std_logic) return std_logic_vector is
begin
  if count='1' then
    return shr(v, 1);
  else
    return v;
  end if;
end shr;

function shl (v: std_logic_vector; count: boolean) return std_logic_vector is
begin
  if count then
    return shl(v, 1);
  else
    return v;
  end if;
end shl;

function shr (v: std_logic_vector; count: boolean) return std_logic_vector is
begin
  if count then
    return shr(v, 1);
  else
    return v;
  end if;
end shr;

function shl (v: integer; count: integer) return integer is
begin
  return conv_integer(shl(conv_std_logic_vector(v,32), count));
end shl;

function shr (v: integer; count: integer) return integer is
begin
  return conv_integer(shr(conv_std_logic_vector(v, 32), count));
end shr;

function shl (v: std_logic; count: integer) return std_logic is
begin
  if count=0 then
    return v;
  else
    return '0';
  end if;
end shl;

function shr (v: std_logic; count: integer) return std_logic is
begin
  if count=0 then
    return v;
  else
    return '0';
  end if;
end shr;

function "=" (l: integer; r: std_logic_vector) return boolean is
begin
  return (l = stdlogic_to_int(std_logic_vector (r)));
end "=";

function "=" (l: std_logic_vector; r: integer) return boolean is
begin
  return (stdlogic_to_int(std_logic_vector (l)) = r);
end "=";

function "=" (l: integer; r: std_logic) return boolean is
begin
  return (l = r);
end "=";

function "=" (l: std_logic; r: integer) return boolean is
begin
  return (l = r);
end "=";

function compareX (lft, rgt: integer) return boolean is
begin
   return lft=rgt;
end compareX;

function compareZ (lft, rgt: integer) return boolean is
begin
   return lft=rgt;
end compareZ;

function compareX (lft, rgt: std_logic) return boolean is
begin
   if lft='X' or rgt='X' or lft='Z' or rgt='Z' then
      return TRUE;
   end if;
   return lft=rgt;
end compareX;

function compareZ (lft, rgt: std_logic) return boolean is
begin
   if lft='Z' or rgt='Z' then
      return TRUE;
   end if;
   return lft=rgt;
end compareZ;

function compareX (lft, rgt: std_logic_vector) return boolean is
   variable i: integer;
   variable ll: std_logic_vector (lft'length-1 downto 0);
   variable rr: std_logic_vector (rgt'length-1 downto 0);
begin
   ll:=lft; rr:=rgt;
   for i in 0 to ll'length-1 loop
      if ll(i) /= 'X' and rr(i) /= 'X' and ll(i) /= 'Z' and rr(i) /= 'Z' and ll(i) /= rr(i) then
         return false;
      end if;
   end loop;
   return true;
end compareX;

function compareZ (lft, rgt: std_logic_vector) return boolean is
   variable i: integer;
   variable ll: std_logic_vector (lft'length-1 downto 0);
   variable rr: std_logic_vector (rgt'length-1 downto 0);
begin
   ll:=lft; rr:=rgt;
   for i in 0 to ll'length-1 loop
      if ll(i) /= 'Z' and rr(i) /= 'Z' and ll(i) /= rr(i) then
         return false;
      end if;
   end loop;
   return true;
end compareZ;

function "+" (lft: std_ulogic; rgt: std_ulogic) return std_logic_vector is
begin
  if lft='0' and rgt='0' then
    return "00";
  elsif (lft='0' and rgt='1') or (lft='1' and rgt='0') then
    return "01";
  elsif (lft='1' and rgt='1') then
    return "10";
  else
    return ('X', 'X');
  end if;
end "+";

function "+" (lft: std_ulogic; rgt: std_ulogic) return std_logic is
begin
  return lft xor rgt;
end "+";

function "+" (lft: std_logic_vector; rgt: std_logic_vector) return std_logic_vector is
begin
  return unsigned(lft)+unsigned(rgt);
end "+";

function "-" (lft: std_ulogic; rgt: std_ulogic) return std_logic_vector is
begin
  if (lft='0' and rgt='0') or (lft='1' and rgt='1') then
    return "00";
  elsif (lft='0' and rgt='1') then
    return "11";
  elsif (lft='1' and rgt='0') then
    return "01";
  else
    return ('X', 'X');
  end if;
end "-";

function "-" (lft: std_ulogic; rgt: std_ulogic) return std_logic is
begin
  return lft xor rgt;
end "-";

function "-" (lft: std_logic_vector; rgt: std_logic_vector) return std_logic_vector is
begin
  return unsigned(lft)-unsigned(rgt);
end "-";

function conv_std_logic (lft: integer) return std_logic is
begin
  if lft=0 then
    return '0';
  else
    return '1';
  end if;
end conv_std_logic;

function conv_std_logic (lft: std_logic_vector) return std_logic is
begin
  return lft(lft'right);
end conv_std_logic;

function conv_std_logic_vector (lft: std_logic) return std_logic_vector is
  variable cc: std_logic_vector (0 downto 0);
begin
  cc(0) := lft;
  return cc;
end conv_std_logic_vector;

function conv_std_logic_vector (lft: boolean) return std_logic_vector is
  variable cc: std_logic_vector (0 downto 0);
begin
  if lft then
    cc(0) := '1';
  else
    cc(0) := '0';
  end if;
  return cc;
end conv_std_logic_vector;

function conv_integer (lft: std_logic_vector) return integer is
begin
  return conv_integer(unsigned(lft));
end conv_integer;

function mult_concat(i : integer; s: std_logic) return std_logic_vector is
variable result : std_logic_vector (i-1 downto 0);
variable j : integer;
begin
  if i = 0 then
    result := "X";
  else	
    for j in i-1 downto 0 loop
      result(j) := s;
    end loop;
  end if;
  return result;
end mult_concat;

function mult_concat(i : integer; s: std_logic_vector) return std_logic_vector is
variable result : std_logic_vector ((s'length*(i-1)) downto 0);
variable j, k, l : integer;
begin
  if i = 0 then
    result := "X";
  else
    for j in i-1 downto 0 loop
      l := s'length-1;
      for k in s'range loop
        result(j*(s'length-1)+l) := s(k);
        l := l-1;
      end loop;
    end loop;
  end if;
  return result;
end mult_concat;

end ihdlutil;
