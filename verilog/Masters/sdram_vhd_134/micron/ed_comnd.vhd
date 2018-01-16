---------------------------------------------------------------------------------
--COMMAND FORMAT                                                               --
--                                                                             --
-- write(column address(integer), bank(bit), first data(integer), dqm(bit), cke(bit));--
-- read(column address(integer), bank(bit), dqm(bit), cke(bit));               --
-- active(row address(integer), bank(bit), data bus (integer), dqm(bit), cke(bit));--
-- precharge(bank(bit), data bus(integer), dqm(bit), cke(bit));                --
-- nop(data bus(integer), dqm(bit), cke(bit), cs(bit));                        --
-- burst_term(data bus(integer), dqm(bit_vector), cke(bit));                   --
-- load_array('1');                                                            --
-- load_mode_reg(register(integer), cke(bit));                                 --
-- next_cycle(clk);  This is used after every command(incl. nop) to clock      --
--                   at the correct clock frequency entered in the clock       --
--                   period constant below                                     --
-- unload_array(row_start(integer), row_end(integer), bank(bit))               --
-- load_mode_reg(op_code(integer))                                             --
--                                                                             --
---------------------------------------------------------------------------------   

LIBRARY work;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE std.textio.all;
USE work.generate_vectors.all;

ENTITY vector_generate IS
END vector_generate;

ARCHITECTURE vector_generate OF vector_generate IS

   SIGNAL stim_done : BOOLEAN := FALSE;
   SIGNAL clk : BIT := '0';
   CONSTANT clk_start     : time := 15 ns;
   CONSTANT clk_period    : time := 10 ns;
   CONSTANT Z : INTEGER := -100;
  
BEGIN

PROCESS

BEGIN

WAIT UNTIL clk = '1' AND clk'EVENT;
   
--------------------ENTER COMMANDS BELOW THIS LINE----------------------------- 
--******************DO NOT USE -100 FOR A DQ VALUE*************************----
--*******************Z WILL PLACE HI-Z ON THE BUS**************************----
--*******USE next_cycle(clk) FOR ADVANCING TO NEXT CLOCK CYCLE*************----

nop(Z, "00", '1', '1');                     -- Always begin with one nop when using Micron's testbench

FOR i IN 1 to 5 LOOP                        -- You will need 100 us for powerup.
    next_cycle(clk);                        -- I used 5 here just for an example.
    nop(Z, "00", '1', '1');
END LOOP;

next_cycle(clk);
precharge('0', 1024, Z, "00", '1');         -- Precharge all banks

FOR i IN 1 to 2 LOOP
    next_cycle(clk);
    nop(Z, "00", '1', '1');
END LOOP;

next_cycle(clk);
auto_refresh;                               -- First auto refresh

FOR i IN 1 TO 8 LOOP
    next_cycle(clk);
    nop(Z, "00", '1', '1');
END LOOP;

next_cycle(clk);
auto_refresh;                               -- Second auto refresh

FOR i IN 1 TO 8 LOOP
    next_cycle(clk);
    nop(Z, "00", '1', '1');
END LOOP;

next_cycle(clk);
load_mode_reg(51, '1');                     -- Load mode register (lat=3, bl=8, mode=seq)

FOR i IN 1 TO 2 LOOP
    next_cycle(clk);
    nop(Z, "00", '1', '1');
END LOOP;

-- Alternate bank write access

next_cycle(clk);
active(0, '0', Z, "00", '1');               -- Activate Bank 0, Row 0

next_cycle(clk);
nop(Z, "00", '1', '1');

next_cycle(clk);
nop(Z, "00", '1', '1');

next_cycle(clk);   
write(1024, '0', 100, "00", '1');           -- Write Bank 0, Col 0, Data 100 (auto precharge)

next_cycle(clk);
nop (101, "00", '1', '1');

next_cycle(clk);
nop (102, "00", '1', '1');

next_cycle(clk);
nop (103, "00", '1', '1');

next_cycle(clk);
nop (104, "00", '1', '1');

next_cycle(clk);
active(0, '1', 105, "00", '1');             -- Activate Bank 1, Row 0

next_cycle(clk);
nop (106, "00", '1', '1');

next_cycle(clk);
nop (107, "00", '1', '1');

next_cycle(clk);   
write(1024, '1', 200, "00", '1');           -- Write Bank 1, Col 0, Data 200 (auto precharge)

next_cycle(clk);
nop (201, "00", '1', '1');

next_cycle(clk);
nop (202, "00", '1', '1');

next_cycle(clk);
nop (203, "00", '1', '1');

next_cycle(clk);
nop (204, "00", '1', '1');

next_cycle(clk);
active(0, '0', 205, "00", '1');             -- Activate Bank 0, Row 0

next_cycle(clk);
nop (206, "00", '1', '1');

next_cycle(clk);
nop (207, "00", '1', '1');

-- Alternate bank read access

next_cycle(clk);   
read(1024, '0', "00", '1');                 -- Read Bank 0, Col 0 (auto precharge)

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
active(0, '1', Z, "00", '1');               -- Activate Bank 1, Row 0

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);   
read(1024, '1', "00", '1');                 -- Read Bank 1, Col 0 (auto precharge)

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop (Z, "00", '1', '1');

next_cycle(clk);
nop(Z, "00", '1', '1'); 

next_cycle(clk);
nop(Z, "00", '1', '1'); 

next_cycle(clk);
nop(Z, "00", '1', '1'); 

next_cycle(clk);
nop(Z, "00", '1', '1'); 

stim_done <= TRUE;  --always include this line at the end of your stimulus   

-------------------------------------------------------------------------------
--*************************************************************************----
END PROCESS;


clock:
  PROCESS
    VARIABLE done_time : time;
    VARIABLE cycle_var : integer := 0;
  BEGIN
    cycle <= 0;
    clk <= '0';
    WAIT for clk_start;
    WHILE not stim_done loop
         clk <= '1';
         cycle <= cycle_var;
      WAIT for clk_period/2;
         cycle_var := cycle_var + 1;
         clk <= '0';
      WAIT for clk_period/2;
    END LOOP;    
    
    ASSERT (FALSE) 
       REPORT "Test Vectors Generated" 
       SEVERITY note;
       
    WAIT;
  END PROCESS;
  

END;
