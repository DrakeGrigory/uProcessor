
# foldername="tb_files"
# filename="top_tb"
# fullpath=$foldername/$filename

# lineVCD="\"$(realpath $foldername/$filename.vcd)\""

# escLineVCD=$(printf '%s' "$lineVCD" | sed 's/[\/&]/\\&/g')

# echo "*** Opening old gtkw file without compiling ***"
# echo lineVCD:$lineVCD

# echo sed -i "5s/.*/$esclineVCD/" "tb_files/top_tb.gtkw" 

#  sed -i "5s/.*/$esclineVCD/" "tb_files/top_tb.gtkw" 


foldername="tb_files"
filename="top_tb"
fullpath=$foldername/$filename

lineVCD="[dumpfile] \"$(realpath $fullpath.vcd)\""
lineGTKW="[savefile] \"$(realpath $fullpath.gtkw)\""

escLineVCD=$(printf '%s' "$lineVCD" | sed 's/[\/&]/\\&/g') # Escaping special signs
escLineGTKW=$(printf '%s' "$lineGTKW" | sed 's/[\/&]/\\&/g') # Escaping special signs


echo "*** Opening old gtkw file without compiling ***"

#echo sed -i "5s/.*/$escLineVCD/" "$fullpath.gtkw" #change line (5, with what, in what file)
sed -i "5s/.*/$escLineVCD/" "$fullpath.gtkw"

#echo sed -i "8s/.*/$escLineGTKW/" "$fullpath.gtkw"
sed -i "8s/.*/$escLineGTKW/" "$fullpath.gtkw"

gtkwave "$fullpath.gtkw" --rcvar 'fontname_signals Monospace 17' --rcvar 'fontname_waves Monospace 12'
