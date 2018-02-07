#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/opt/XILINX/SDK/2016.4/bin:/opt/XILINX/Vivado/2016.4/ids_lite/ISE/bin/lin64:/opt/XILINX/Vivado/2016.4/bin
else
  PATH=/opt/XILINX/SDK/2016.4/bin:/opt/XILINX/Vivado/2016.4/ids_lite/ISE/bin/lin64:/opt/XILINX/Vivado/2016.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/opt/XILINX/Vivado/2016.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/opt/XILINX/Vivado/2016.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/lab/hicc/fajar/Documents/Programming-Practice/verilog/PIC16/PIC16F-Verilog-Core/vivado/PIC16CORE/PIC16CORE.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log pic16.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source pic16.tcl
