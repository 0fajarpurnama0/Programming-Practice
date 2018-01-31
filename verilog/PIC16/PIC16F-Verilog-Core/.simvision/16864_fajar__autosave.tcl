
# NC-Sim Command File
# TOOL:	ncsim(64)	15.10-s008
#

set tcl_prompt1 {puts -nonewline "ncsim> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias iprof profile
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves pic16test.i_pic16.i_pic16core.ALU_CB pic16test.i_pic16.i_pic16core.C pic16test.i_pic16.i_pic16core.CLK pic16test.i_pic16.i_pic16core.CO pic16test.i_pic16.i_pic16core.C_W pic16test.i_pic16.i_pic16core.DC pic16test.i_pic16.i_pic16core.DCO pic16test.i_pic16.i_pic16core.DC_W pic16test.i_pic16.i_pic16core.DDATA pic16test.i_pic16.i_pic16core.EA pic16test.i_pic16.i_pic16core.FSR pic16test.i_pic16.i_pic16core.F_W pic16test.i_pic16.i_pic16core.IMEM pic16test.i_pic16.i_pic16core.IR pic16test.i_pic16.i_pic16core.IRP pic16test.i_pic16.i_pic16core.NOP_S pic16test.i_pic16.i_pic16core.PC pic16test.i_pic16.i_pic16core.PCLATH pic16test.i_pic16.i_pic16core.PC_W pic16test.i_pic16.i_pic16core.PORTA pic16test.i_pic16.i_pic16core.PORTB pic16test.i_pic16.i_pic16core.RA pic16test.i_pic16.i_pic16core.RAM pic16test.i_pic16.i_pic16core.RB pic16test.i_pic16.i_pic16core.RDATA pic16test.i_pic16.i_pic16core.RP pic16test.i_pic16.i_pic16core.RST pic16test.i_pic16.i_pic16core.SDATA pic16test.i_pic16.i_pic16core.SLEEP pic16test.i_pic16.i_pic16core.SLP_S pic16test.i_pic16.i_pic16core.STK pic16test.i_pic16.i_pic16core.STKP pic16test.i_pic16.i_pic16core.STK_PO pic16test.i_pic16.i_pic16core.STK_PU pic16test.i_pic16.i_pic16core.TRISA pic16test.i_pic16.i_pic16core.TRISB pic16test.i_pic16.i_pic16core.WDATA pic16test.i_pic16.i_pic16core.WDT_C pic16test.i_pic16.i_pic16core.W_W pic16test.i_pic16.i_pic16core.Z pic16test.i_pic16.i_pic16core.ZO pic16test.i_pic16.i_pic16core.Z_W pic16test.i_pic16.i_pic16core.nPD pic16test.i_pic16.i_pic16core.nPD_C pic16test.i_pic16.i_pic16core.nPD_S pic16test.i_pic16.i_pic16core.nTO pic16test.i_pic16.i_pic16core.nTO_C pic16test.i_pic16.i_pic16core.nTO_S
probe -create -database waves pic16test.i_pic16.i_pic16core.i_alu.B pic16test.i_pic16.i_pic16core.i_alu.CB pic16test.i_pic16.i_pic16core.i_alu.CI pic16test.i_pic16.i_pic16core.i_alu.CLK pic16test.i_pic16.i_pic16core.i_alu.CO pic16test.i_pic16.i_pic16core.i_alu.DC pic16test.i_pic16.i_pic16core.i_alu.FI pic16test.i_pic16.i_pic16core.i_alu.FO pic16test.i_pic16.i_pic16core.i_alu.HC pic16test.i_pic16.i_pic16core.i_alu.W pic16test.i_pic16.i_pic16core.i_alu.WE pic16test.i_pic16.i_pic16core.i_alu.Z pic16test.i_pic16.i_pic16core.i_alu.bit_mask pic16test.i_pic16.i_pic16core.i_alu.sub pic16test.i_pic16.i_pic16core.i_alu.tmp

simvision -input /lab/hicc/fajar/Documents/Programming-Practice/verilog/PIC16/PIC16F-Verilog-Core/.simvision/16864_fajar__autosave.tcl.svcf
