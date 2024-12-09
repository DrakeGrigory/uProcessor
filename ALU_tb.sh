#!/bin/bash

rm -f ALU_tb
rm -f ALU_tb.vcd

iverilog -g2012 -o ALU_tb ALU_tb.sv

if [$? -eq 1]; then
    echo iverilog failure
    exit -1
fi


vvp ALU_tb

if [$? -ne 1]; then
    echo vpp failure
    exit -1
fi


gtkwave ALU_tb.gtkw

# if [$? -ne 1]; then
#     echo gtkw failure
#     exit -1
# fi