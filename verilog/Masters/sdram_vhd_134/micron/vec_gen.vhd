-------------------------------------------------------------------------------
--                                                                           --
-- This is a data generator for the testbench for Micron's Synchronous       --
-- DRAM. This generator reads a text file line-by-line and generates         --
-- a file of test vectors that is then read by the testbench and             --
-- applied to the part.                                                      --
--                                                                           --
-- This VHDL program creates a text file of test vectors that is used by the --
-- test bench. Place your commands in a file (a copy of VEC_GEN.VHD) and run --
-- VEC_GEN.VHD in your VHDL simulator (make sure you have compiled this      --
-- package prior to running the program VEC_GEN.VHD). This will produce the  --
-- vectors that are required to run the included testbench. Change the name  --
-- of the vector file to save your vectors in separate files. The default    --
-- file name for the output vectors generated from this pacakage is          --
-- "test.txt."                                                               --
--                                                                           --
-- Now compile and run the testbench program embedtb.vhd. The testbench uses --                     
-- the default test.txt as input vectors.                                    --
--                                                                           --
--                                                                           --
-- Copyright 1997 Micron Technology, Inc.                                    --
--                                                                           --
-------------------------------------------------------------------------------

LIBRARY work;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE std.textio.all;
USE work.io_utils.all;


PACKAGE generate_vectors IS

    CONSTANT set_up : TIME;
    CONSTANT hold : TIME;
    CONSTANT cycle_start : TIME;   

    SIGNAL cycle : INTEGER := 0;
    SIGNAL sim_time : TIME := 0 ns;
    FILE output_file:TEXT IS OUT "test.txt";   
    PROCEDURE write(col_address : IN INTEGER; bank : IN BIT;
                   first_data : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT);
    PROCEDURE read(col_address : IN INTEGER; bank : IN BIT; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT);
    PROCEDURE active(row_address : IN INTEGER; bank : IN BIT; data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT);
    PROCEDURE precharge(bank : IN BIT; address : IN INTEGER; data_bus: IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT);
    PROCEDURE nop(data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT; cs : IN BIT);                  
    PROCEDURE burst_term(data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT);
    PROCEDURE auto_refresh;
    PROCEDURE next_cycle(SIGNAL clk : IN BIT);
    PROCEDURE load_array(load : IN BIT);
    PROCEDURE load_mode_reg(op_code : IN INTEGER; cke : IN BIT);
    PROCEDURE unload_array(row_start : IN INTEGER; row_end : IN INTEGER; bank : IN BIT); 

END generate_vectors;


PACKAGE BODY generate_vectors IS
   
    CONSTANT set_up : TIME := 3 ns;
    CONSTANT hold : TIME := 1 ns;
    CONSTANT cycle_start : TIME := 0 ns;


PROCEDURE write(col_address : IN INTEGER; bank : IN BIT; first_data : IN INTEGER; 
                 dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT) IS

VARIABLE l : LINE;

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;      

write(l, Cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 0, right, 4); --Cas
write(l, 0, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, col_address, right, 6); --address
write(l, first_data, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE read(col_address : IN INTEGER; bank : IN BIT; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT) IS
 
VARIABLE l : LINE;

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;
   
write(l, Cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 0, right, 4); --Cas
write(l, 1, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, col_address, right, 6); --address
write(l, -100, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE active(row_address : IN INTEGER; bank : IN BIT; data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT) IS

VARIABLE l : LINE;

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;
   
write(l, Cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 0, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 1, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, row_address, right, 6); --address
write(l, data_bus, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE precharge(bank : IN BIT; address : IN INTEGER; data_bus: IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT) IS

VARIABLE l : LINE;

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;
   
write(l, Cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 0, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 0, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, address, right, 6); --address
write(l, data_bus, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE nop(data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT; cs : IN BIT) IS
         

VARIABLE l : LINE;
VARIABLE col_address : INTEGER := 0;
VARIABLE bank : BIT := '0';

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;
   
write(l, cke, right, 4); --Cke
write(l, cs, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 1, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, col_address, right, 6); --address
write(l, data_bus, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;


PROCEDURE burst_term(data_bus : IN INTEGER; dqm : IN BIT_VECTOR(1 DOWNTO 0); cke : IN BIT) IS

VARIABLE l : LINE;
VARIABLE col_address : INTEGER := 0;

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;
   
write(l, cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 0, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, 0, right, 4); --Ba
write(l, col_address, right, 6); --address
write(l, data_bus, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE auto_refresh IS
    VARIABLE l : LINE;
    VARIABLE dqm : BIT_VECTOR(1 DOWNTO 0) := "00";
BEGIN
    IF cycle = 0 THEN   
        write(l, cycle_start, left, 4, ns);
    ELSE
        write(l, now-set_up, left, 4, ns);
    END IF;
    write(l, 1, right, 4); --Cke
    write(l, 0, right, 4); --Cs
    write(l, 0, right, 4); --Ras
    write(l, 0, right, 4); --Cas
    write(l, 1, right, 4); --We
    write(l, dqm, right, 4); --Dqm
    write(l, 0, right, 4); --Ba
    write(l, 0, right, 6); --address
    write(l, -100, right, 6); --first data location
    --write(l, 0, right, 4); --load
    --write(l, 0, right, 4); --unload
    --write(l, 0, right, 6); --row_address_start
    --write(l, 0, right, 6); --row_address_end
    writeline(output_file,l); --write vector to file
END;


PROCEDURE next_cycle(SIGNAL clk : IN BIT) IS

BEGIN

WAIT UNTIL clk = '1';

END;

PROCEDURE load_array(load : IN BIT) IS

VARIABLE l : LINE;
VARIABLE dqm : BIT_VECTOR(1 DOWNTO 0) := "00";

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;

write(l, 1, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 1, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, 0, right, 4); --Ba
write(l, 0, right, 6); --address
write(l, -100, right, 6); --first data location
--write(l, 1, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE unload_array(row_start : IN INTEGER; row_end : IN INTEGER; bank : IN BIT) IS

VARIABLE l : LINE;
VARIABLE dqm : BIT_VECTOR(1 DOWNTO 0) := "00";

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;

write(l, 1, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 1, right, 4); --Ras
write(l, 1, right, 4); --Cas
write(l, 1, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, bank, right, 4); --Ba
write(l, 0, right, 6); --address
write(l, -100, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 1, right, 4); --unload
--write(l, row_start, right, 6); --row_address_start
--write(l, row_end, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

PROCEDURE load_mode_reg(op_code : IN INTEGER; cke : IN BIT) IS

VARIABLE l : LINE;
VARIABLE dqm : BIT_VECTOR(1 DOWNTO 0) := "00";

BEGIN

IF cycle = 0 THEN   
   write(l, cycle_start, left, 4, ns);
ELSE
   write(l, now-set_up, left, 4, ns);
END IF;

write(l, cke, right, 4); --Cke
write(l, 0, right, 4); --Cs
write(l, 0, right, 4); --Ras
write(l, 0, right, 4); --Cas
write(l, 0, right, 4); --We
write(l, dqm, right, 4); --Dqm
write(l, 0, right, 4); --Ba
write(l, op_code, right, 6); --address
write(l, -100, right, 6); --first data location
--write(l, 0, right, 4); --load
--write(l, 0, right, 4); --unload
--write(l, 0, right, 6); --row_address_start
--write(l, 0, right, 6); --row_address_end
writeline(output_file,l); --write vector to file

END;

END generate_vectors;

