#! /bin/bash

#filename="ALU_tb"
#filename="RegisterFile_tb"
#filename="PC_PP_BFM_tb"
filename="PP_ID_tb"

rm $filename
rm "${filename}.vcd"   

iverilog -g2012 -o "${filename}" "${filename}.sv"

if [$? -eq 1]; then
    echo iverilog failure
    exit -1
fi


vvp "${filename}"

if [$? -ne 1]; then
    echo vpp failure
    exit -1
fi


gtkwave "${filename}.gtkw" --rcvar 'fontname_signals Monospace 17' --rcvar 'fontname_waves Monospace 12'

if [$? -ne 1]; then
    echo gtkw failure
    exit -1
fi
