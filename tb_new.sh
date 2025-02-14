#! /bin/bash
foldername="sim_files"

#filename="ALU_tb"
#filename="RegisterFile_tb"
#filename="PM_ID_BFM_tb"
#filename="AllModulesV1_tb"
filename="PC_tb"

echo "====================================================================
              LAUNCHING TEST BENCH COMPILATION:
              FOR THE FIRST TIME
====================================================================="

rm "${foldername}"/$filename
rm "${foldername}"/"${filename}.vcd"   


iverilog -g2012 -o "${foldername}"/"${filename}" "${filename}.sv"
vvp "${foldername}"/"${filename}"
gtkwave "${foldername}"/"${filename}.vcd" --rcvar 'fontname_signals Monospace 17' --rcvar 'fontname_waves Monospace 12'
