# Final Report PIC16 Microcontroller Implementation on Verilog Hardware Description Language

1. Introduction
2. Verilog HDL Design
   - Arithmetic Logic Unit
        - alu_op.v
        - alu.v
   - PIC16 Core Behavior
        - pic_dcm.vhd
        - pic16.v
        - pic16core.v

        - Program Counter and Return Stack
        - Instruction Memory and Register
        - Decoder and Control Signal Generation
        - Special Registers
        - Shared Memory
        - Data path
        - Instantiate for ALU Module
        - Sleepmode
        - Data path
        - Tristate Buffer for GPIO
3. Simulation and Implementation Result
   - Simulation
        - program.asm, program.hex, program.lst

~kuga/bin/gpasm program.asm
~kuga/bin/hex2vmemh.py program.hex

        - Test Bench

alu_test.txt, alu_test.v, pic16test.v.
create and add INCLUDE /opt/XILINX/14.7/ncsim/cds.lib
ssh –X calc1.st.cs.kumamoto-u.ac.jp
source ~kuga/setup/creative2016
ncverilog pic16test.v pic16.v pic16core.v alu.v pic_dcm.vhd -V93 +nc64bit -gui +access+r
4. Field Programmable Gate Array Implementation
   - pic16.xdc
5. Summary