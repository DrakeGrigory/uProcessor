#! /bin/bash
foldername="tb_files"

#filename="ALU_tb"
#filename="RegisterFile_tb"
#filename="PC_PP_BFM_tb"
#filename="PP_ID_tb"
filename="ID_BFM_tb"

echo "====================================================================
              LAUNCHING TEST BENCH COMPILATION:
====================================================================="

rm "${foldername}"/$filename
rm "${foldername}"/"${filename}.vcd"   

iverilog -g2012 -o "${foldername}"/"${filename}" "${filename}.sv"

# if [$? -eq 1]; then
#     echo iverilog failure
#     exit -1
# fi


vvp "${foldername}"/"${filename}"

# if [$? -ne 1]; then
#     echo vpp failure
#     exit -1
# fi


gtkwave "${foldername}"/"${filename}.vcd" --rcvar 'fontname_signals Monospace 17' --rcvar 'fontname_waves Monospace 12'

# if [$? -ne 1]; then
#     echo gtkw failure
#     exit -1
# fi
