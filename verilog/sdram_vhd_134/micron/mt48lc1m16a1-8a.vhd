-----------------------------------------------------------------------------------------
--
--     File Name: MT48LC1M18A1.VHD
--       Version: 0.0c
--          Date: April 20th, 1999
--         Model: Behavioral
--     Simulator: Model Technology VLOG (PC version 5.2e PE)
--
--  Dependencies: None
--
--        Author: Son P. Huynh
--         Email: sphuynh@micron.com
--         Phone: (208) 368-3825
--       Company: Micron Technology, Inc.
--   Part Number: MT48LC1M16A1 (512k  x 16 x 2 Banks)
--
--   Description: Micron 16Mb SDRAM
--
--    Limitation: - Doesn't check for 4096-cycle refresh
--
--          Note: - Set simulator resolution to "ps" accuracy
--
--    Disclaimer: THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
--                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
--                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
--                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
--
--                Copyright (c) 1998 Micron Semiconductor Products, Inc.
--                All rights researved
--
--  Rev   Author          Phone         Date        Changes
--  ----  ----------------------------  ----------  -------------------------------------
--  0.0c  Son P. Huynh    208-368-3825  04/20/1999  Fix precharge to different bank
--        Micron Technology Inc.                      terminate current bank
--
--  0.0b  Son P. Huynh    208-368-3825  12/09/1998  Fix some timing check problem
--        Micron Technology Inc.                    - Improve model functionality
--
--  0.0a  Son P. Huynh    208-368-3825  08/10/1998  First Release
--        Micron Technology Inc.                    - Simple testbench included
-----------------------------------------------------------------------------------------

-- Change Timing parameters for 8a parts

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.mti_pkg.ALL;
PACKAGE mt48lc1m16a1_PKG IS
COMPONENT mt48lc1m16a1
      GENERIC (
        tAC       : TIME    :=  6.0 ns;     -- Timing parameter for -8 device
        tAH       : TIME    :=  1.0 ns;
        --tAS       : TIME    :=  3.0 ns;
        tAS       : TIME    :=  2.0 ns;         
        --tCH       : TIME    :=  3.5 ns;
        tCH       : TIME    :=  3.0 ns;
        --tCL       : TIME    :=  3.5 ns;
        tCL       : TIME    :=  3.0 ns;
        --tCK       : TIME    := 10.0 ns;
        tCK       : TIME    :=  8.0 ns;
        tDH       : TIME    :=  1.0 ns;
        --tDS       : TIME    :=  3.0 ns;
        tDS       : TIME    :=  2.0 ns;
        tCKH      : TIME    :=  1.0 ns;
        tCKS      : TIME    :=  3.0 ns;
        tCMH      : TIME    :=  1.0 ns;
        --tCMS      : TIME    :=  3.0 ns;
        tCMS      : TIME    :=  2.0 ns;
        tOH       : TIME    :=  2.5 ns;
        tHZ       : TIME    :=  6.0 ns;
        tMRD      : INTEGER :=  2;
        --tRAS      : TIME    := 60.0 ns;
        tRAS      : TIME    := 48.0 ns; 
        --tRC       : TIME    := 90.0 ns;
        tRC       : TIME    := 80.0 ns;
        --tRCD      : TIME    := 30.0 ns;
        tRCD      : TIME    := 24.0 ns;
        --tRP       : TIME    := 30.0 ns;
        tRP       : TIME    := 24.0 ns;
        --tRRD      : TIME    := 20.0 ns;
        tRRD      : TIME    := 16.0 ns;
        tWR       : INTEGER :=  1;
        addr_bits : INTEGER := 11;
        data_bits : INTEGER := 16;
        col_bits  : INTEGER :=  8
        );
    PORT (
        Dq    : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0) := (OTHERS => 'Z');
        Addr  : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
        Ba    : IN    STD_LOGIC := '0';
        Clk   : IN    STD_LOGIC := '0';
        Cke   : IN    STD_LOGIC := '0';
        Cs_n  : IN    STD_LOGIC := '1';
        Ras_n : IN    STD_LOGIC := '0';
        Cas_n : IN    STD_LOGIC := '0';
        We_n  : IN    STD_LOGIC := '0';
        Dqm   : IN    STD_LOGIC_VECTOR (1 DOWNTO 0) := "00"
    );
END component;
END mt48lc1m16a1_PKG;
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.mti_pkg.ALL;
ENTITY mt48lc1m16a1 IS
    GENERIC (
        tAC       : TIME    :=  6.0 ns;     -- Timing parameter for -8 device
        tAH       : TIME    :=  1.0 ns;
        --tAS       : TIME    :=  3.0 ns;
        tAS       : TIME    :=  2.0 ns;         
        --tCH       : TIME    :=  3.5 ns;
        tCH       : TIME    :=  3.0 ns;
        --tCL       : TIME    :=  3.5 ns;
        tCL       : TIME    :=  3.0 ns;
        --tCK       : TIME    := 10.0 ns;
        tCK       : TIME    :=  8.0 ns;
        tDH       : TIME    :=  1.0 ns;
        --tDS       : TIME    :=  3.0 ns;
        tDS       : TIME    :=  2.0 ns;
        tCKH      : TIME    :=  1.0 ns;
        tCKS      : TIME    :=  3.0 ns;
        tCMH      : TIME    :=  1.0 ns;
        --tCMS      : TIME    :=  3.0 ns;
        tCMS      : TIME    :=  2.0 ns;
        tOH       : TIME    :=  2.5 ns;
        tHZ       : TIME    :=  6.0 ns;
        tMRD      : INTEGER :=  2;
        --tRAS      : TIME    := 60.0 ns;
        tRAS      : TIME    := 48.0 ns; 
        --tRC       : TIME    := 90.0 ns;
        tRC       : TIME    := 80.0 ns;
        --tRCD      : TIME    := 30.0 ns;
        tRCD      : TIME    := 24.0 ns;
        --tRP       : TIME    := 30.0 ns;
        tRP       : TIME    := 24.0 ns;
        --tRRD      : TIME    := 20.0 ns;
        tRRD      : TIME    := 16.0 ns;
        tWR       : INTEGER :=  1;
        addr_bits : INTEGER := 11;
        data_bits : INTEGER := 16;
        col_bits  : INTEGER :=  8
    );
    PORT (
        Dq    : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0) := (OTHERS => 'Z');
        Addr  : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
        Ba    : IN    STD_LOGIC := '0';
        Clk   : IN    STD_LOGIC := '0';
        Cke   : IN    STD_LOGIC := '0';
        Cs_n  : IN    STD_LOGIC := '1';
        Ras_n : IN    STD_LOGIC := '0';
        Cas_n : IN    STD_LOGIC := '0';
        We_n  : IN    STD_LOGIC := '0';
        Dqm   : IN    STD_LOGIC_VECTOR (1 DOWNTO 0) := "00"
    );
END mt48lc1m16a1;

ARCHITECTURE behave OF mt48lc1m16a1 IS
    TYPE   State       IS (ACT, A_REF, BST, LMR, NOP, PRECH, READ, READ_A, WRITE, WRITE_A);
    TYPE   Array2xI    IS ARRAY (1 DOWNTO 0) OF INTEGER;
    TYPE   Array2xB    IS ARRAY (1 DOWNTO 0) OF BIT;
    TYPE   Array4xB    IS ARRAY (3 DOWNTO 0) OF BIT;
    TYPE   Array2x2BV  IS ARRAY (1 DOWNTO 0) OF BIT_VECTOR (1 DOWNTO 0);
    TYPE   Array4xCBV  IS ARRAY (3 DOWNTO 0) OF BIT_VECTOR (Col_bits - 1 DOWNTO 0);
    TYPE   Array_state IS ARRAY (3 DOWNTO 0) OF State;
    SIGNAL Operation : State := NOP;
    SIGNAL Mode_reg : BIT_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Active_enable, Aref_enable, Burst_term : BIT := '0';
    SIGNAL Mode_reg_enable, Prech_enable, Read_enable, Write_enable : BIT := '0';
    SIGNAL Burst_length_1, Burst_length_2, Burst_length_4, Burst_length_8 : BIT := '0';
    SIGNAL Cas_latency_1, Cas_latency_2, Cas_latency_3 : BIT := '0';
    SIGNAL Ras_in, Cas_in, We_in : BIT := '0';
    SIGNAL Write_burst_mode : BIT := '0';
    SIGNAL Sys_clk, CkeZ : BIT := '0';

    -- Checking internal wires
    SIGNAL Pre_chk : BIT_VECTOR (1 DOWNTO 0) := "00";
    SIGNAL Act_chk : BIT_VECTOR (1 DOWNTO 0) := "00";
    SIGNAL Dq_in_chk, Dq_out_chk : BIT := '0';
    SIGNAL Bank_chk : BIT := '0';
    SIGNAL Row_chk : BIT_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Col_chk : BIT_VECTOR (col_bits - 1 DOWNTO 0) := (OTHERS => '0');

    BEGIN
        -- CS# Decode
        WITH Cs_n SELECT
            Cas_in <= TO_BIT (Cas_n, '1') WHEN '0',
                      '1' WHEN '1',
                      '1' WHEN OTHERS;
        WITH Cs_n SELECT
            Ras_in <= TO_BIT (Ras_n, '1') WHEN '0',
                      '1' WHEN '1',
                      '1' WHEN OTHERS;
        WITH Cs_n SELECT
            We_in  <= TO_BIT (We_n,  '1') WHEN '0',
                      '1' WHEN '1',
                      '1' WHEN OTHERS;
        
        -- Commands Decode
        Active_enable   <= NOT(Ras_in) AND     Cas_in  AND     We_in;
        Aref_enable     <= NOT(Ras_in) AND NOT(Cas_in) AND     We_in;
        Burst_term      <=     Ras_in  AND     Cas_in  AND NOT(We_in);
        Mode_reg_enable <= NOT(Ras_in) AND NOT(Cas_in) AND NOT(We_in);
        Prech_enable    <= NOT(Ras_in) AND     Cas_in  AND NOT(We_in);
        Read_enable     <=     Ras_in  AND NOT(Cas_in) AND     We_in;
        Write_enable    <=     Ras_in  AND NOT(Cas_in) AND NOT(We_in);

        -- Burst Length Decode
        Burst_length_1  <= NOT(Mode_reg(2)) AND NOT(Mode_reg(1)) AND NOT(Mode_reg(0));
        Burst_length_2  <= NOT(Mode_reg(2)) AND NOT(Mode_reg(1)) AND     Mode_reg(0);
        Burst_length_4  <= NOT(Mode_reg(2)) AND     Mode_reg(1)  AND NOT(Mode_reg(0));
        Burst_length_8  <= NOT(Mode_reg(2)) AND     Mode_reg(1)  AND     Mode_reg(0);

        -- CAS Latency Decode
        Cas_latency_1   <= NOT(Mode_reg(6)) AND NOT(Mode_reg(5)) AND     Mode_reg(4);
        Cas_latency_2   <= NOT(Mode_reg(6)) AND     Mode_reg(5)  AND NOT(Mode_reg(4));
        Cas_latency_3   <= NOT(Mode_reg(6)) AND     Mode_reg(5)  AND     Mode_reg(4);

        -- Write Burst Mode
        Write_burst_mode <= Mode_reg(9);

        -- System Clock
        int_clk : PROCESS (Clk)
            begin
                IF Clk'LAST_VALUE = '0' AND Clk = '1' THEN
                    CkeZ <= TO_BIT(Cke, '1');
                END IF;
                Sys_clk <= CkeZ AND TO_BIT(Clk, '0');
        END PROCESS;

        state_register : PROCESS
            TYPE ram_type IS ARRAY (2**col_bits - 1 DOWNTO 0) OF BIT_VECTOR (data_bits - 1 DOWNTO 0);
            TYPE ram_pntr IS ACCESS ram_type;
            TYPE ram_stor IS ARRAY (2**addr_bits - 1 DOWNTO 0) OF ram_pntr;
            VARIABLE Bank0 : ram_stor;
            VARIABLE Bank1 : ram_stor;
            VARIABLE Row_index, Col_index : INTEGER := 0;
            VARIABLE Dq_temp : BIT_VECTOR (data_bits - 1 DOWNTO 0) := (OTHERS => '0');

            VARIABLE Col_addr : Array4xCBV;
            VARIABLE Bank_addr : Array4xB;
            VARIABLE Dqm_reg : Array2x2BV;

            VARIABLE Bank, Previous_bank : BIT := '0';
            VARIABLE B0_row_addr, B1_row_addr : BIT_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
            VARIABLE Col_brst : BIT_VECTOR (col_bits - 1 DOWNTO 0) := (OTHERS => '0');
            VARIABLE Row : BIT_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
            VARIABLE Col : BIT_VECTOR (col_bits - 1 DOWNTO 0) := (OTHERS => '0');
            VARIABLE Burst_counter : INTEGER := 0;

            VARIABLE Command : Array_state;
            VARIABLE A10_precharge, Bank_precharge : Array4xB;
            VARIABLE Auto_precharge, Read_precharge, Write_precharge : Array2xB;
            VARIABLE Count_precharge : Array2xI;
            VARIABLE RW_interrupt_write : BIT := '0';

            VARIABLE Data_in_enable, Data_out_enable : BIT := '0';
            VARIABLE Pc_b0, Pc_b1 : BIT := '0';
            VARIABLE Act_b0, Act_b1 : BIT := '0';

            -- Timing Check
            VARIABLE MRD_chk : INTEGER := 0;
            VARIABLE RC_chk, RRD_chk  : TIME    := 0 ns;
            VARIABLE RAS_chk0, RAS_chk1 : TIME := 0 ns;
            VARIABLE RCD_chk0, RCD_chk1 : TIME := 0 ns;
            VARIABLE RP_chk, RP_chk0, RP_chk1 : TIME := 0 ns;
            VARIABLE WR_chk : Array2xI := (0 & 0);

            -- Initialize empty rows
            PROCEDURE Init_mem (Bank : BIT; Row_index : INTEGER) IS
                VARIABLE i, j : INTEGER := 0;
                BEGIN
                    IF Bank = '0' THEN
                        IF Bank0 (Row_index) = NULL THEN                        -- Check to see if row empty
                            Bank0 (Row_index) := NEW ram_type;                  -- Open new row for access
                            FOR i IN (2**col_bits - 1) DOWNTO 0 LOOP            -- Filled row with zeros
                                FOR j IN (data_bits - 1) DOWNTO 0 LOOP
                                    Bank0 (Row_index) (i) (j) := '0';
                                END LOOP;
                            END LOOP;
                        END IF;
                    ELSIF Bank = '1' THEN
                        IF Bank1 (Row_index) = NULL THEN
                            Bank1 (Row_index) := NEW ram_type;
                            FOR i IN (2**col_bits - 1) DOWNTO 0 LOOP
                                FOR j IN (data_bits - 1) DOWNTO 0 LOOP
                                    Bank1 (Row_index) (i) (j) := '0';
                                END LOOP;
                            END LOOP;
                        END IF;
                    END IF;
                END;
                
            -- Burst Counter
            PROCEDURE Burst_decode IS
                VARIABLE Col_int : INTEGER := 0;
                VARIABLE Col_vec, Col_temp : BIT_VECTOR (col_bits - 1 DOWNTO 0) := (OTHERS => '0');
                BEGIN
                    -- Advance Burst Counter
                    Burst_counter := Burst_counter + 1;

                    -- Burst Type
                    IF Mode_reg (3) = '0' THEN
                        Col_int := TO_INTEGER(Col);
                        Col_int := Col_int + 1;
                        TO_BITVECTOR (Col_int, Col_temp);
                    ELSIF Mode_reg (3) = '1' THEN
                        TO_BITVECTOR (Burst_counter, Col_vec);
                        Col_temp (2) := Col_vec (2) XOR Col_brst (2);
                        Col_temp (1) := Col_vec (1) XOR Col_brst (1);
                        Col_temp (0) := Col_vec (0) XOR Col_brst (0);
                    END IF;

                    -- Burst Length
                    IF Burst_length_2 = '1' THEN
                        Col (0) := Col_temp (0);
                    ELSIF Burst_length_4 = '1' THEN
                        Col (1 DOWNTO 0) := Col_temp (1 DOWNTO 0);
                    ELSIF Burst_length_8 = '1' THEN
                        Col (2 DOWNTO 0) := Col_temp (2 DOWNTO 0);
                    ELSE
                        Col := Col_temp;
                    END IF;

                    -- Burst Read Single Write
                    IF Write_burst_mode = '1' AND Data_in_enable = '1' THEN
                        Data_in_enable := '0';
                    END IF;

                    -- Data counter
                    IF Burst_length_1 = '1' THEN
                        IF Burst_counter >= 1 THEN
                            IF Data_in_enable = '1' THEN
                                Data_in_enable := '0';
                            ELSIF Data_out_enable = '1' THEN
                                Data_out_enable := '0';
                            END IF;
                        END IF;
                    ELSIF Burst_length_2 = '1' THEN
                        IF Burst_counter >= 2 THEN
                            IF Data_in_enable = '1' THEN
                                Data_in_enable := '0';
                            ELSIF Data_out_enable = '1' THEN
                                Data_out_enable := '0';
                            END IF;
                        END IF;
                    ELSIF Burst_length_4 = '1' THEN
                        IF Burst_counter >= 4 THEN
                            IF Data_in_enable = '1' THEN
                                Data_in_enable := '0';
                            ELSIF Data_out_enable = '1' THEN
                                Data_out_enable := '0';
                            END IF;
                        END IF;
                    ELSIF Burst_length_8 = '1' THEN
                        IF Burst_counter >= 8 THEN
                            IF Data_in_enable = '1' THEN
                                Data_in_enable := '0';
                            ELSIF Data_out_enable = '1' THEN
                                Data_out_enable := '0';
                            END IF;
                        END IF;
                    END IF;
                END;

            BEGIN
                WAIT ON Sys_clk;
                    IF Sys_clk = '1' THEN
                        -- Internal Command Pipeline
                        Command(0) := Command(1);
                        Command(1) := Command(2);
                        Command(2) := Command(3);
                        Command(3) := NOP;

                        Col_addr(0) := Col_addr(1);
                        Col_addr(1) := Col_addr(2);
                        Col_addr(2) := Col_addr(3);
                        Col_addr(3) := (OTHERS => '0');

                        Bank_addr(0) := Bank_addr(1);
                        Bank_addr(1) := Bank_addr(2);
                        Bank_addr(2) := Bank_addr(3);
                        Bank_addr(3) := '0';

                        Bank_precharge(0) := Bank_precharge(1);
                        Bank_precharge(1) := Bank_precharge(2);
                        Bank_precharge(2) := Bank_precharge(3);
                        Bank_precharge(3) := '0';

                        A10_precharge(0) := A10_precharge(1);
                        A10_precharge(1) := A10_precharge(2);
                        A10_precharge(2) := A10_precharge(3);
                        A10_precharge(3) := '0';

                        -- Operation Decode
                        IF Active_enable = '1' THEN
                            Operation <= ACT;
                        ELSIF Aref_enable = '1' THEN
                            Operation <= A_REF;
                        ELSIF Burst_term = '1' THEN
                            Operation <= BST;
                        ELSIF Mode_reg_enable = '1' THEN
                            Operation <= LMR;
                        ELSIF Prech_enable = '1' THEN
                            Operation <= PRECH;
                        ELSIF Read_enable = '1' THEN
                            IF Addr(10) = '0' THEN
                                Operation <= READ;
                            ELSE
                                Operation <= READ_A;
                            END IF;
                        ELSIF Write_enable = '1' THEN
                            IF Addr(10) = '0' THEN
                                Operation <= WRITE;
                            ELSE
                                Operation <= WRITE_A;
                            END IF;
                        ELSE
                            Operation <= NOP;
                        END IF;

                        -- Dqm pipeline for Read
                        Dqm_reg(0) := Dqm_reg(1);
                        Dqm_reg(1) := TO_BITVECTOR(Dqm);

                        -- Read or Write with Auto Precharge Counter
                        IF Auto_precharge (0) = '1' THEN
                            Count_precharge (0) := Count_precharge (0) + 1;
                        END IF;
                        IF Auto_precharge (1) = '1' THEN
                            Count_precharge (1) := Count_precharge (1) + 1;
                        END IF;

                        -- tMRD Counter
                        MRD_chk := MRD_chk + 1;

                        -- tWR Counter
                        WR_chk(0) := WR_chk(0) + 1;
                        WR_chk(1) := WR_chk(1) + 1;

                        -- Auto Refresh
                        IF Aref_enable = '1' THEN
                            -- Auto Refresh to Auto Refresh
                            ASSERT (NOW - RC_chk >= tRC)
                                REPORT "tRC violation during Auto Refresh"
                                SEVERITY WARNING;
                            -- Precharge to Auto Refresh
                            ASSERT (NOW - RP_chk >= tRP)
                                REPORT "tRP violation during Auto Refresh"
                                SEVERITY WARNING;
                            -- Banks must be idle before Refresh
                            IF Pc_b1 = '0' OR Pc_b0 = '0' THEN
                                ASSERT (FALSE)
                                    REPORT "All banks must be Precharge before Auto Refresh"
                                    SEVERITY WARNING;
                            END IF;
                            -- Record current tRC time
                            RC_chk := NOW;
                        END IF;

                        -- Load Mode Register
                        IF Mode_reg_enable = '1' THEN
                            Mode_reg <= TO_BITVECTOR (Addr);
                            IF (Pc_b0 /= '1' OR Pc_b1 /= '1') THEN
                                ASSERT (FALSE)
                                    REPORT "All bank must be Precharge before Load Mode Register"
                                    SEVERITY WARNING;
                            END IF;
                            -- REF to LMR
                            ASSERT (RC_chk >= tRC)
                                REPORT "tRC violation during Load Mode Register"
                                SEVERITY WARNING;
                            -- LMR to LMR
                            ASSERT (MRD_chk >= tMRD)
                                REPORT "tMRD violation during Load Mode Register"
                                SEVERITY WARNING;
                            -- Record current tMRD time
                            MRD_chk := 0;
                        END IF;

                        -- Active Block (latch Bank and Row Address)
                        IF Active_enable = '1' THEN
                            IF Ba = '0' AND Pc_b0 = '1' THEN
                                Act_b0 := '1';
                                Pc_b0 := '0';
                                B0_row_addr := TO_BITVECTOR (Addr);
                                RCD_chk0 := NOW;
                                RAS_chk0 := NOW;
                                -- Precharge to Active Bank 0
                                ASSERT (NOW - RP_chk0 >= tRP)
                                    REPORT "tRP violation during Activate Bank 0"
                                    SEVERITY WARNING;
                            ELSIF Ba = '1' AND Pc_b1 = '1' THEN
                                Act_b1 := '1';
                                Pc_b1 := '0';
                                B1_row_addr := TO_BITVECTOR (Addr);
                                RCD_chk1 := NOW;
                                RAS_chk1 := NOW;
                                -- Precharge to Active Bank 1
                                ASSERT (NOW - RP_chk1 >= tRP)
                                    REPORT "tRP violation during Activate Bank 1"
                                    SEVERITY WARNING;
                            ELSIF Ba = '0' AND Pc_b0 = '0' THEN
                                ASSERT (FALSE)
                                    REPORT "Bank 0 is not Precharged"
                                    SEVERITY WARNING;
                            ELSIF Ba = '1' AND Pc_b1 = '0' THEN
                                ASSERT (FALSE)
                                    REPORT "Bank 1 is not Precharged"
                                    SEVERITY WARNING;
                            END IF;
                            -- Active Bank A to Active Bank B
                            IF (Previous_bank /= TO_BIT(Ba)) AND (NOW - RRD_chk < tRRD) THEN
                                ASSERT (FALSE)
                                    REPORT "tRRD violation during activate"
                                    SEVERITY WARNING;
                            END IF;
                            -- LMR to ACT
                            ASSERT (MRD_chk >= tMRD)
                                REPORT "tMRD violation during Activate"
                                SEVERITY WARNING;
                            -- AutoRefresh to Activate
                            ASSERT (NOW - RC_chk >= tRC)
                                REPORT "tRC violation during Activate"
                                SEVERITY WARNING;
                            -- Record current Bank and RRD_chk
                            Previous_bank := TO_BIT(Ba);
                            RRD_chk := NOW;
                        END IF;
                        
                        -- Precharge Block
                        IF Prech_enable = '1' THEN
                            IF Addr(10) = '1' THEN
                                Pc_b0 := '1';
                                Pc_b1 := '1';
                                Act_b0 := '0';
                                Act_b1 := '0';
                                RP_chk0 := NOW;
                                RP_chk1 := NOW;
                                -- Activate to Precharge all banks
                                ASSERT ((NOW - RAS_chk0 >= tRAS) OR (NOW - RAS_chk1 >= tRAS))
                                    REPORT "tRAS violation during Precharge all banks"
                                    SEVERITY WARNING;
                                -- tWR violation check for Write
                                IF ((WR_chk(0) < tWR) AND (WR_chk(1) < tWR)) THEN
                                    ASSERT (FALSE)
                                        REPORT "tWR violation during Precharge all banks"
                                        SEVERITY WARNING;
                                END IF;
                            ELSIF Addr(10) = '0' THEN
                                IF Ba = '0' THEN
                                    Pc_b0 := '1';
                                    Act_b0 := '0';
                                    RP_chk0 := NOW;
                                    -- Activate to Precharge bank 0
                                    ASSERT (NOW - RAS_chk0 >= tRAS)
                                        REPORT "tRAS violation during Precharge bank 0"
                                        SEVERITY WARNING;
                                ELSIF Ba = '1' THEN
                                    Pc_b1 := '1';
                                    Act_b1 := '0';
                                    RP_chk1 := NOW;
                                    -- Activate to Precharge bank 1
                                    ASSERT (NOW - RAS_chk1 >= tRAS)
                                        REPORT "tRAS violation during Precharge bank 1"
                                        SEVERITY WARNING;
                                END IF;
                                -- tWR violation check for Write
                                IF (WR_chk(TO_INTEGER(Ba)) < tWR) THEN
                                    ASSERT (FALSE)
                                        REPORT "tWR violation during Precharge"
                                        SEVERITY WARNING;
                                END IF;
                            END IF;

                            -- Terminate a Write Immediately (if same bank or all banks)
                            IF (Data_in_enable = '1' AND (Bank = TO_BIT(Ba) OR Addr(10) = '1')) THEN
                                Data_in_enable := '0';
                            END IF;

                            -- Precharge Command Pipeline for READ
                            IF CAS_latency_3 = '1' THEN
                                Command(2) := PRECH;
                                Bank_precharge(2) := TO_BIT (Ba);
                                A10_precharge(2) := TO_BIT (Addr(10));
                            ELSIF CAS_latency_2 = '1' THEN
                                Command(1) := PRECH;
                                Bank_precharge(1) := TO_BIT (Ba);
                                A10_precharge(1) := TO_BIT (Addr(10));
                            ELSIF CAS_latency_1 = '1' THEN
                                Command(0) := PRECH;
                                Bank_precharge(0) := TO_BIT (Ba);
                                A10_precharge(0) := TO_BIT (Addr(10));
                            END IF;
                            -- Record Precharge Bank and Current tRP time
                            RP_chk := NOW;
                        END IF;
                        
                        -- Burst Terminate
                        IF Burst_term = '1' THEN
                            IF CAS_latency_3 = '1' THEN
                                Command(2) := BST;
                            ELSIF CAS_latency_2 = '1' THEN
                                Command(1) := BST;
                            ELSIF CAS_latency_1 = '1' THEN
                                Command(0) := BST;
                            END IF;
                        END IF;
                        
                        -- Read, Write, Column Latch
                        IF Read_enable = '1' OR Write_enable = '1' THEN
                            -- Check to see if bank is open (ACT) for Read or Write
                            IF ((Ba = '0' AND Pc_b0 = '1') OR (Ba = '1' AND Pc_b1 = '1')) THEN
                                ASSERT (FALSE)
                                    REPORT "Cannot Read or Write - Bank is not Activated"
                                    SEVERITY WARNING;
                            END IF;
                            -- Activate to Read or Write
                            IF Ba = '0' THEN
                                ASSERT (NOW - RCD_chk0 >= tRCD)
                                    REPORT "tRCD violation during Read or Write to Bank 0"
                                    SEVERITY WARNING;
                            ELSIF Ba = '1' THEN
                                ASSERT (NOW - RCD_chk1 >= tRCD)
                                    REPORT "tRCD violation during Read or Write to Bank 1"
                                    SEVERITY WARNING;
                            END IF;
                            -- Read Command
                            IF Read_enable = '1' THEN
                                -- Read Terminate a Write Immediately
                                IF Data_in_enable = '1' THEN
                                    Data_in_enable := '0';
                                    RW_interrupt_write := '1';
                                END IF;
                                -- CAS Latency Pipeline
                                IF Cas_latency_3 = '1' THEN
                                    IF Addr(10) = '1' THEN
                                        Command(2) := READ_A;
                                    ELSE
                                        Command(2) := READ;
                                    END IF;
                                    Col_addr (2) := TO_BITVECTOR (Addr(col_bits - 1 DOWNTO 0));
                                    Bank_addr (2) := TO_BIT (Ba);
                                ELSIF Cas_latency_2 = '1' THEN
                                    IF Addr(10) = '1' THEN
                                        Command(1) := READ_A;
                                    ELSE
                                        Command(1) := READ;
                                    END IF;
                                    Col_addr (1) := TO_BITVECTOR (Addr(col_bits - 1 DOWNTO 0));
                                    Bank_addr (1) := TO_BIT (Ba);
                                ELSIF Cas_latency_1 = '1' THEN
                                    IF Addr(10) = '1' THEN
                                        Command(0) := READ_A;
                                    ELSE
                                        Command(0) := READ;
                                    END IF;
                                    Col_addr (0) := TO_BITVECTOR (Addr(col_bits - 1 DOWNTO 0));
                                    Bank_addr (0) := TO_BIT (Ba);
                                END IF;
                            -- Write Command
                            ELSIF Write_enable = '1' THEN
                                IF Addr(10) = '1' THEN
                                    Command(0) := WRITE_A;
                                ELSE
                                    Command(0) := WRITE;
                                END IF;
                                Col_addr (0) := TO_BITVECTOR (Addr(col_bits - 1 DOWNTO 0));
                                Bank_addr (0) := TO_BIT (Ba);
                                IF Data_in_enable = '1' THEN
                                    RW_interrupt_write := '1';
                                END IF;
                            END IF;
                            -- Read or Write with Auto Precharge
                            IF Addr(10) = '1' THEN
                                Auto_precharge (TO_INTEGER(Ba)) := '1';
                                Count_precharge (TO_INTEGER(Ba)) := 0;
                                IF Read_enable = '1' THEN
                                    Read_precharge (TO_INTEGER(Ba)) := '1';
                                ELSIF Write_enable = '1' THEN
                                    Write_precharge (TO_INTEGER(Ba)) := '1';
                                END IF;
                            END IF;
                        END IF;

                        -- Read with AutoPrecharge Calculation
                        --      The device start internal precharge when:
                        --          1.  BL/2 cycles after command
                        --      and 2.  Meet tRAS requirement
                        --       or 3.  Interrupt by a Read or Write (with or without Auto Precharge)
                        IF ((Auto_precharge(0) = '1') AND (Read_precharge(0) = '1')) THEN
                            IF (((NOW - RAS_chk0 >= tRAS) AND
                                ((Burst_length_1 = '1' AND Count_precharge(0) >= 1)  OR
                                 (Burst_length_2 = '1' AND Count_precharge(0) >= 2)  OR
                                 (Burst_length_4 = '1' AND Count_precharge(0) >= 4)  OR
                                 (Burst_length_8 = '1' AND Count_precharge(0) >= 8))) OR
                                ((Read_enable = '1' OR Write_enable = '1') AND Count_precharge(0) >= 1)) THEN
                                Pc_b0 := '1';
                                Act_b0 := '0';
                                RP_chk0 := NOW;
                                Auto_precharge(0) := '0';
                                Read_precharge(0) := '0';
                                Write_precharge(0) := '0';
                            END IF;
                        END IF;
                        IF ((Auto_precharge(1) = '1') AND (Read_precharge(1) = '1')) THEN
                            IF (((NOW - RAS_chk1 >= tRAS) AND
                                ((Burst_length_1 = '1' AND Count_precharge(1) >= 1)  OR
                                 (Burst_length_2 = '1' AND Count_precharge(1) >= 2)  OR
                                 (Burst_length_4 = '1' AND Count_precharge(1) >= 4)  OR
                                 (Burst_length_8 = '1' AND Count_precharge(1) >= 8))) OR
                                ((Read_enable = '1' OR Write_enable = '1') AND Count_precharge(1) >= 1)) THEN
                                Pc_b1 := '1';
                                Act_b1 := '0';
                                RP_chk1 := NOW;
                                Auto_precharge(1) := '0';
                                Read_precharge(1) := '0';
                                Write_precharge(1) := '0';
                            END IF;
                        END IF;
                        
                        -- Write with AutoPrecharge Calculation
                        --      The device start internal precharge when:
                        --          1.  tWR cycles after command
                        --      and 2.  Meet tRAS requirement
                        --       or 3.  Interrupt by a Read or Write (with or without Auto Precharge)
                        IF ((Auto_precharge(0) = '1') AND (Write_precharge(0) = '1')) THEN
                            IF (((NOW - RAS_chk0 >= tRAS) AND
                               (((Burst_length_1 = '1' OR Write_burst_mode = '1' ) AND Count_precharge(0) >= 1)  OR
                                 (Burst_length_2 = '1'                             AND Count_precharge(0) >= 2)  OR
                                 (Burst_length_4 = '1'                             AND Count_precharge(0) >= 4)  OR
                                 (Burst_length_8 = '1'                             AND Count_precharge(0) >= 8))) OR
                                 (RW_interrupt_write = '1' AND WR_chk(0) >= 1)) THEN
                                Pc_b0 := '1';
                                Act_b0 := '0';
                                RP_chk0 := NOW;
                                Auto_precharge(0) := '0';
                                Read_precharge(0) := '0';
                                Write_precharge(0) := '0';
                                RW_interrupt_write := '0';
                            END IF;
                        END IF;
                        IF ((Auto_precharge(1) = '1') AND (Write_precharge(1) = '1')) THEN
                            IF (((NOW - RAS_chk1 >= tRAS) AND
                               (((Burst_length_1 = '1' OR Write_burst_mode = '1' ) AND Count_precharge(1) >= 1)  OR
                                 (Burst_length_2 = '1'                             AND Count_precharge(1) >= 2)  OR
                                 (Burst_length_4 = '1'                             AND Count_precharge(1) >= 4)  OR
                                 (Burst_length_8 = '1'                             AND Count_precharge(1) >= 8))) OR 
                                 (RW_interrupt_write = '1' AND WR_chk(1) >= 1)) THEN
                                Pc_b1 := '1';
                                Act_b1 := '0';
                                RP_chk1 := NOW;
                                Auto_precharge(1) := '0';
                                Read_precharge(1) := '0';
                                Write_precharge(1) := '0';
                                RW_interrupt_write := '0';
                            END IF;
                        END IF;

                        -- Internal Precharge or Bst
                        IF Command(0) = PRECH THEN
                            IF Bank_precharge(0) = Bank OR A10_precharge(0) = '1' THEN
                                IF Data_out_enable = '1' THEN
                                    Data_out_enable := '0';
                                END IF;
                            END IF;
                        ELSIF Command(0) = BST THEN
                            IF Data_out_enable = '1' THEN
                                Data_out_enable := '0';
                            END IF;
                        END IF;

                        IF Data_out_enable = '0' THEN
                            Dq <= TRANSPORT (OTHERS => 'Z') AFTER tOH;
                        END IF;

                        -- Detect Read or Write Command
                        IF Command(0) = READ OR Command(0) = READ_A THEN
                            Bank := Bank_addr (0);
                            Col := Col_addr (0);
                            Col_brst := Col_addr (0);
                            IF Bank_addr (0) = '0' THEN
                                Row := B0_row_addr;
                            ELSE
                                Row := B1_row_addr;
                            END IF;
                            Burst_counter := 0;
                            Data_in_enable := '0';
                            Data_out_enable := '1';
                        ELSIF Command(0) = WRITE OR Command(0) = WRITE_A THEN
                            Bank := Bank_addr(0);
                            Col := Col_addr(0);
                            Col_brst := Col_addr(0);
                            IF Bank_addr (0) = '0' THEN
                                Row := B0_row_addr;
                            ELSE
                                Row := B1_row_addr;
                            END IF;
                            Burst_counter := 0;
                            Data_in_enable := '1';
                            Data_out_enable := '0';
                        END IF;

                        -- DQ (Driver / Receiver)
                        Row_index := TO_INTEGER (Row);
                        Col_index := TO_INTEGER (Col);
                        IF Data_in_enable = '1' THEN
                            IF Dqm /= "11" THEN
                                Init_mem (Bank, Row_index);
                                IF Bank = '0' THEN
                                    Dq_temp := Bank0 (Row_index) (Col_index);
                                    IF Dqm = "01" THEN
                                        Dq_temp (15 DOWNTO 8) := TO_BITVECTOR (Dq (15 DOWNTO 8));
                                    ELSIF Dqm = "10" THEN
                                        Dq_temp (7 DOWNTO 0) := TO_BITVECTOR (Dq (7 DOWNTO 0));
                                    ELSE
                                        Dq_temp (15 DOWNTO 0) := TO_BITVECTOR (Dq (15 DOWNTO 0));
                                    END IF;
                                    Bank0 (Row_index) (Col_index) := Dq_temp;
                                ELSIF Bank = '1' THEN
                                    Dq_temp := Bank1 (Row_index) (Col_index);
                                    IF Dqm = "01" THEN
                                        Dq_temp (15 DOWNTO 8) := TO_BITVECTOR (Dq (15 DOWNTO 8));
                                    ELSIF Dqm = "10" THEN
                                        Dq_temp (7 DOWNTO 0) := TO_BITVECTOR (Dq (7 DOWNTO 0));
                                    ELSE
                                        Dq_temp (15 DOWNTO 0) := TO_BITVECTOR (Dq (15 DOWNTO 0));
                                    END IF;
                                    Bank1 (Row_index) (Col_index) := Dq_temp;
                                END IF;
                                WR_chk(TO_INTEGER(Bank)) := 0;
                            END IF;
                            Burst_decode;
                        ELSIF Data_out_enable = '1' THEN
                            Init_mem (Bank, Row_index);
                            IF Bank = '0' THEN
                                Dq_temp (15 DOWNTO 0) := Bank0 (Row_index) (Col_index);
                                IF Dqm_reg(0) = "00" THEN
                                    Dq (15 DOWNTO 0) <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (15 DOWNTO 0)) AFTER tAC;
                                ELSIF Dqm_reg(0) = "01" THEN
                                    Dq (15 DOWNTO 8)  <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (15 DOWNTO 8)) AFTER tAC;
                                    Dq (7 DOWNTO 0)  <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                ELSIF Dqm_reg(0) = "10" THEN
                                    Dq (15 DOWNTO 8)  <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                    Dq (7 DOWNTO 0) <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (7 DOWNTO 0)) AFTER tAC;
                                ELSE
                                    Dq <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                END IF;
                            ELSIF Bank = '1' THEN
                                Dq_temp (15 DOWNTO 0) := Bank1 (Row_index) (Col_index);
                                IF Dqm_reg(0) = "00" THEN
                                    Dq (15 DOWNTO 0) <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (15 DOWNTO 0)) AFTER tAC;
                                ELSIF Dqm_reg(0) = "01" THEN
                                    Dq (15 DOWNTO 8)  <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (15 DOWNTO 8)) AFTER tAC;
                                    Dq (7 DOWNTO 0)  <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                ELSIF Dqm_reg(0) = "10" THEN
                                    Dq (15 DOWNTO 8)  <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                    Dq (7 DOWNTO 0) <= TRANSPORT TO_STDLOGICVECTOR (Dq_temp (7 DOWNTO 0)) AFTER tAC;
                                ELSE
                                    Dq <= TRANSPORT (OTHERS => 'Z') AFTER tAC;
                                END IF;
                            END IF;
                            Burst_decode;
                        END IF;

                        -- Checking internal wires
                        Pre_chk (0) <= Pc_b0;
                        Pre_chk (1) <= Pc_b1;
                        Act_chk (0) <= Act_b0;
                        Act_chk (1) <= Act_b1;
                        Dq_in_chk   <= Data_in_enable;
                        Dq_out_chk  <= Data_out_enable;
                        Bank_chk    <= Bank;
                        Row_chk     <= Row;
                        Col_chk     <= Col;
                    END IF;
        END PROCESS;


        -- Clock timing checks
        Clock_check : PROCESS
            VARIABLE Clk_low, Clk_high : TIME := 0 ns;
            BEGIN
                WAIT ON Clk;
                    IF (Clk = '1' AND NOW >= 10 ns) THEN
                        ASSERT (NOW - Clk_low >= tCL)
                            REPORT "tCL violation"
                            SEVERITY WARNING;
                        ASSERT (NOW - Clk_high >= tCK)
                            REPORT "tCK violation"
                            SEVERITY WARNING;
                        Clk_high := NOW;
                    ELSIF (Clk = '0' AND NOW /= 0 ns) THEN
                        ASSERT (NOW - Clk_high >= tCH)
                            REPORT "tCH violation"
                            SEVERITY WARNING;
                        Clk_low := NOW;
                    END IF;
        END PROCESS;

        -- Setup timing checks
        Setup_check : PROCESS
            BEGIN
                WAIT ON Clk;
                    IF Clk = '1' THEN
                        ASSERT(Cke'LAST_EVENT >= tCKS)
                            REPORT "CKE Setup time violation -- tCKS"
                            SEVERITY WARNING;
                        ASSERT(Cs_n'LAST_EVENT >= tCMS)
                            REPORT "CS# Setup time violation -- tCMS"
                            SEVERITY WARNING;
                        ASSERT(Cas_n'LAST_EVENT >= tCMS)
                            REPORT "CAS# Setup time violation -- tCMS"
                            SEVERITY WARNING;
                        ASSERT(Ras_n'LAST_EVENT >= tCMS)
                            REPORT "RAS# Setup time violation -- tCMS"
                            SEVERITY WARNING;
                        ASSERT(We_n'LAST_EVENT >= tCMS)
                            REPORT "WE# Setup time violation -- tCMS"
                            SEVERITY WARNING;
                        ASSERT(Dqm'LAST_EVENT >= tCMS)
                            REPORT "Dqm Setup time violation -- tCMS"
                            SEVERITY WARNING;
                        ASSERT(Addr'LAST_EVENT >= tAS)
                            REPORT "ADDR Setup time violation -- tAS"
                            SEVERITY WARNING;
                        ASSERT(Ba'LAST_EVENT >= tAS)
                            REPORT "BA Setup time violation -- tAS"
                            SEVERITY WARNING;
                        ASSERT(Dq'LAST_EVENT >= tDS)
                            REPORT "Dq Setup time violation -- tDS"
                            SEVERITY WARNING;
                    END IF;
        END PROCESS;

        -- Hold timing checks
        Hold_check : PROCESS
            BEGIN
                WAIT ON Clk'DELAYED (tCKH), Clk'DELAYED (tCMH), Clk'DELAYED (tAH), Clk'DELAYED (tDH);
                    IF Clk'DELAYED (tCKH) = '1' THEN
                        ASSERT(Cke'LAST_EVENT > tCKH)
                            REPORT "CKE Hold time violation -- tCKH"
                            SEVERITY WARNING;
                    END IF;
                    IF Clk'DELAYED (tCMH) = '1' THEN
                        ASSERT(Cs_n'LAST_EVENT > tCMH)
                            REPORT "CS# Hold time violation -- tCMH"
                            SEVERITY WARNING;
                        ASSERT(Cas_n'LAST_EVENT > tCMH)
                            REPORT "CAS# Hold time violation -- tCMH"
                            SEVERITY WARNING;
                        ASSERT(Ras_n'LAST_EVENT > tCMH)
                            REPORT "RAS# Hold time violation -- tCMH"
                            SEVERITY WARNING;
                        ASSERT(We_n'LAST_EVENT > tCMH)
                            REPORT "WE# Hold time violation -- tCMH"
                            SEVERITY WARNING;
                        ASSERT(Dqm'LAST_EVENT > tCMH)
                            REPORT "Dqm Hold time violation -- tCMH"
                            SEVERITY WARNING;
                    END IF;
                    IF Clk'DELAYED (tAH) = '1' THEN
                        ASSERT(Addr'LAST_EVENT > tAH)
                            REPORT "ADDR Hold time violation -- tAH"
                            SEVERITY WARNING;
                        ASSERT(Ba'LAST_EVENT > tAH)
                            REPORT "BA Hold time violation -- tAH"
                            SEVERITY WARNING;
                    END IF;
                    IF Clk'DELAYED (tDH) = '1' THEN
                        ASSERT(Dq'LAST_EVENT > tDH)
                            REPORT "DQ Hold time violation -- tDH"
                            SEVERITY WARNING;
                    END IF;
        END PROCESS;

END behave;
