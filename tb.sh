#! /bin/bash
foldername="tb_files"

filename="AllModulesV1_tb"
#filename="ALU_tb"
#filename="RegisterFile_tb"
#filename="PM_ID_BFM_tb"

clear
echo "====================================================================
              LAUNCHING TEST BENCH COMPILATION:
====================================================================="

rm "${foldername}"/$filename
rm "${foldername}"/"${filename}.vcd"   


iverilog -g2012 -o "${foldername}"/"${filename}" "${filename}.sv"
vvp "${foldername}"/"${filename}"
gtkwave "${foldername}"/"${filename}.gtkw" --rcvar 'fontname_signals Monospace 17' --rcvar 'fontname_waves Monospace 12'
