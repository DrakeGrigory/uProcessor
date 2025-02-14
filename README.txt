Ogólne:
> Pliki .sv są opisane w komentarzach.
> Plik tb.sh służy do uruchamiania testbencha przez icarius Verilog oraz gtkWave.

w folderze Pictures:
> Znajduje się przebie symulacji obecnej wersji programu (09.02.25) na dwóch zdjęciach.
> Znajduję się diagram przedstawiający budowę i połączenia procesora.


w folderze sim_files:
> Znajdują się tam pliki symulacyjne.
> Aby uruchomić plik gtkw należy zmienić ścieżkę w jego 5 i 8 linii. Można do tego wykorzystać plik openOld_GTWK_file.sh.
> Powinny być 3 pliki o tej samej nazwie co testowany moduł: bez rozszerzenia, .vcd, .gtkw.
> Obecnym testbenchem jest top_tb.sv.


w folderze ASSEMBLER:
> Plik assembler.m                  służy do stworzenia instrukcji w binarce.
> Plik accuCheckValues.hex          zawiera w sobie poprawne wartości akumulatora w każdym z cykli.
> Plik InstructionDefines.csv       zawiera definicje wartości liczbowych do mnemoniców (definy).
> Plik InsBin.asm                   zawiera instrukcje w binarce.
> Plik Instructions_ValueCheck.asm  zawiera zestaw instrukcji testowych procesora - program.


w folderze tb_unit: 
> Znajdują się tam stare pliki testowe, które jednostkowo testowały moduły procesora na samym początku jego tworzenia.

