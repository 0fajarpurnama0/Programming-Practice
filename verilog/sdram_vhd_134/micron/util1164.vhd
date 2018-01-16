LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE STD.textio.ALL;

PACKAGE util_1164 IS
  PROCEDURE read(l: INOUT line; value: OUT std_logic);
  PROCEDURE read(l: INOUT line; value: OUT std_logic_vector);
  PROCEDURE write(l: INOUT line; value: IN std_logic_vector;
                  JUSTIFIED: IN SIDE := right;
	          FIELD: IN WIDTH := 0);
  PROCEDURE Grow_line(L : inout LINE; incr : in integer);
END util_1164;



PACKAGE BODY util_1164 IS

  FUNCTION white_space(value:character) RETURN boolean IS
    VARIABLE result:boolean;
  BEGIN
    IF (value = ' ') OR (value = HT) THEN
      RETURN true;
    ELSE
      RETURN false;
    END IF;
  END white_space;

  PROCEDURE read(l: INOUT line; value: OUT std_logic) IS
    VARIABLE char_var: character:= ' ';
  BEGIN
    WHILE l'LENGTH > 0 LOOP
      read(l,char_var);
      IF NOT white_space(char_var) THEN
        EXIT;
      END IF;
    END LOOP;
    IF white_space(char_var) THEN
      ASSERT false REPORT "No std_logic value found in file"
          SEVERITY error;
      value := 'X';
      RETURN;
    END IF;

    CASE char_var IS
      WHEN 'U'|'u' => value := 'U';
      WHEN '0'     => value := '0';
      WHEN '1'     => value := '1';
      WHEN 'X'|'x' => value := 'X';
      WHEN 'L'|'l' => value := 'L';
      WHEN 'H'|'h' => value := 'H';
      WHEN 'W'|'w' => value := 'W';
      WHEN 'Z'|'z' => value := 'Z';
      WHEN '-'     => value := '-';
      WHEN OTHERS  =>
          ASSERT false REPORT "Unrecognized value read for std_logic"
                 SEVERITY error;
          value := 'X';
    END CASE;
  END read;

  PROCEDURE read(l: INOUT line; value: OUT std_logic_vector) IS
  BEGIN
    FOR i IN value'HIGH DOWNTO value'LOW LOOP
      IF l'LENGTH > 0 THEN
        read(l,value(i));
      ELSE
        ASSERT false REPORT "Not enough values for std_logic_vector in file"
            SEVERITY error;
        RETURN;
      END IF;
    END LOOP;
  END read;

  procedure Grow_line(L : inout LINE; incr : in integer)
    is 
	variable old_L : LINE := L;
	variable bfp: integer;	-- Blank fill pointer.
    begin
	assert incr > 0
	    report "Textio: Grow_line called with zero increment."
	    severity error;

	if L = null then
	    bfp := 0;
	    L := new string(1 to incr);
	else
	    bfp := old_L'high;
	    L := new string(old_L'low to old_L'high + incr);
	    L(old_L'low to old_L'high) := old_L.all;
	    Deallocate(old_L);
	end if;
	for i in 1 to incr loop
	    L(bfp + i) := ' ';
	end loop;
    end;


   PROCEDURE write(l: INOUT line; value: IN std_logic_vector; 
                  JUSTIFIED: IN SIDE := right;
	          FIELD: IN WIDTH := 0) IS
  	variable fw: integer := VALUE'length;
	variable bp: integer;
	variable offset: integer := 0;
	alias normal : std_logic_vector(0 to value'length - 1) is value;
    begin
	if L /= null then
	    bp := L'high + 1;
	else bp := 1;
	end if;
	if FIELD > VALUE'length then
	    fw := FIELD;
	    if JUSTIFIED = right then
		offset := fw - VALUE'length;
	    end if;
	end if;
	Grow_line(L, fw);
	for i in normal'range loop
	    L(bp + i + offset) := character'val(
		    std_logic'pos(normal(i)) + character'pos('0'));
	end loop;
    end;
    

END util_1164;
