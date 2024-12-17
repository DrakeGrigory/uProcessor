
foldername="tb_files"
filename="top_tb"
fullpath=$foldername/$filename

lineVCD="\"$(realpath $foldername/$filename.vcd)\""

escLineVCD=$(printf '%s' "$lineVCD" | sed 's/[\/&]/\\&/g')

echo "*** Opening old gtkw file without compiling ***"
echo lineVCD:$lineVCD

echo sed -i "5s/.*/$esclineVCD/" "tb_files/top_tb.gtkw" 

 sed -i "5s/.*/$esclineVCD/" "tb_files/top_tb.gtkw" 