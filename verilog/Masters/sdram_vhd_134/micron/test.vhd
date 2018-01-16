LIBRARY ieee;
LIBRARY work;
USE ieee.std_logic_1164.ALL;
USE work.std_logic_arith.ALL;
USE work.util_1164.ALL;
USE std.textio.ALL;
USE work.mti_pkg.ALL;

ENTITY tb IS
END tb;


ARCHITECTURE test OF tb IS
    CONSTANT addr_bits     : INTEGER := 11;
    CONSTANT clk_start     : time    :=  5 ns;
    CONSTANT clk_period    : time    := 10 ns;
    CONSTANT continue_time : time    := 10 ns;
    CONSTANT data_bits     : INTEGER := 16;

    COMPONENT mt48lc1m16a1
        PORT (
            Dq    : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0) := (OTHERS => 'Z');
            Addr  : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
            Ba    : IN    STD_LOGIC := '0';
            Clk   : IN    STD_LOGIC := '0';
            Cke   : IN    STD_LOGIC := '0';
            Cs_n  : IN    STD_LOGIC := '1';
            Cas_n : IN    STD_LOGIC := '0';
            Ras_n : IN    STD_LOGIC := '0';
            We_n  : IN    STD_LOGIC := '0';
            Dqm   : IN    STD_LOGIC_VECTOR (1 DOWNTO 0) := "00"
        ); 
    END COMPONENT;
  
    FOR ALL : mt48lc1m16a1 USE ENTITY work.mt48lc1m16a1 (behave);

    SIGNAL pDq       : STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0);
    SIGNAL pAddr     : STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0);
    SIGNAL pBa       : STD_LOGIC;
    SIGNAL pClk      : STD_LOGIC;
    SIGNAL pCke      : STD_LOGIC;
    SIGNAL pCs       : STD_LOGIC;
    SIGNAL pCas      : STD_LOGIC;
    SIGNAL pRas      : STD_LOGIC;
    SIGNAL pWe       : STD_LOGIC;
    SIGNAL pDqm      : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL stim_done : boolean := false;
    SIGNAL clk_done  : boolean := false;

BEGIN
    u1: mt48lc1m16a1
        PORT MAP(
            Dq    => pDq,
            Addr  => pAddr,
            Ba    => pBa,
            Clk   => pClk,
            Cke   => pCke,
            Cs_n  => pCs,
            Ras_n => pRas,
            Cas_n => pCas,
            We_n  => pWe,
            Dqm   => pDqm
        );

    stimulator : PROCESS
        FILE stim_file:text IS IN "test.txt";
        VARIABLE l : line;
        VARIABLE time_var     : TIME;
        VARIABLE pCke_var     : STD_LOGIC;
        VARIABLE pCs_var      : STD_LOGIC;
        VARIABLE pRas_var     : STD_LOGIC;
        VARIABLE PCas_var     : STD_LOGIC;
        VARIABLE pWe_var      : STD_LOGIC;
        VARIABLE pDqm_var     : STD_LOGIC_VECTOR (1 DOWNTO 0);
        VARIABLE pBa_var      : STD_LOGIC;
        VARIABLE pAddr_var    : INTEGER;
        VARIABLE pDq_var      : INTEGER;            -- -100 is converted to hi-Z state
        VARIABLE pMa_var_vect : STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0);
        CONSTANT HiZ          : STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0) := (OTHERS => 'Z');
        BEGIN
        WHILE not ENDFILE(stim_file) LOOP
            readline(stim_file,l);
            IF l'length > 0 THEN
                read(l, time_var);
                read(l, pCke_var);
                read(l, pCs_var);
                read(l, pRas_var);
                read(l, pCas_var);
                read(l, pWe_var);
                read(l, pDqm_var);
                read(l, pBa_var);
                read(l, pAddr_var);
                read(l, pDq_var);
                IF now > time_var THEN
                    ASSERT false 
                        REPORT "Detected a time in the stim file that is in the past"
                        SEVERITY error;
                ELSE
                    WAIT FOR time_var-now;
                        IF pWe_var='1' THEN
                            pCke <= pCke_var;
                            pCs <= pCs_var;
                            pRas <= pRas_var;
                            pCas <= pCas_var;
                            pWe <= pWe_var;
                            pDqm <= pDqm_var;
                            pBa <= pBa_var;
                            pMa_var_vect := CONV_STD_LOGIC_VECTOR(pAddr_var, addr_bits);
                            pAddr <= pMa_var_vect;
                            IF pDq_var = -100 THEN
                                pDq <= HiZ;
                            ELSE  
                                pDq <= CONV_STD_LOGIC_VECTOR(pDq_var, data_bits);
                            END IF;
                        ELSE
                            pCke <= pCke_var;
                            pCs <= pCs_var;
                            pRas <= pRas_var;
                            pCas <= pCas_var;
                            pWe <= pWe_var;
                            pDqm <= pDqm_var;
                            pBa <= pBa_var;
                            pMa_var_vect := CONV_STD_LOGIC_VECTOR(pAddr_var, addr_bits);
                            pAddr <= pMa_var_vect;
                            IF pDq_var = -100 THEN
                                pDq <= HiZ;
                            ELSE  
                                pDq <= CONV_STD_LOGIC_VECTOR(pDq_var, data_bits);            
                            END IF;
                        END IF;
                END IF;
            END IF;
        END LOOP;
        ASSERT false
            REPORT "End of Stimulation File Detected!"
            SEVERITY note;
        stim_done <= true;
        WAIT;
    END PROCESS;

    clock : PROCESS
    VARIABLE done_time : time;
    BEGIN
        pclk <= '0';
        WAIT for clk_start;
            WHILE not stim_done loop
                pclk <= '1';
                WAIT for clk_period/2;
                pclk <= '0';
                WAIT for clk_period/2;
            END LOOP;
            done_time := now+continue_time;
            WHILE now < done_time LOOP            --one last clock to finish last command
                pclk <= '1';
                WAIT for clk_period/2;
                pclk <= '0';
                WAIT for clk_period/2;
            END LOOP;
            ASSERT false 
                REPORT "Suspending clock activity"
                SEVERITY note;
            clk_done <= true;
            WAIT;
    END PROCESS;

END test;


