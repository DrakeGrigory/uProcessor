# EN / PL of State of Project

## What needs to be done.
+ Change the connections so that it is possible to make a jump from each section of the instructions as planned.
+ Rename the variables to snake_case - in the end I decided (arbitrarily) that this one would be the best.
+ Parameterize the width of I/O in each module.
+ Refactor to the latest version of iverilog

## QUESTIONS - Why...?
+ I was using an old version of iverilog? Due to problems with my own hardware, I had to use different computers, including one with an older version of Icarius Verilog.
+ Icarius Verilog and GTKwave? - the simplest solution (especially for a novice), which worked on any hardware, including a replacement 10-years-old laptop.
+ Such strange variable names? - Initially I assumed the use of UpperCamelCase, but by using abbreviations such as CE - Clock Enable in the definitions sometimes created variable definitions that looked like constants. Hence some chaos. Later, seeing the clarity of snake_case, I decided to change the standard to snake_case.

## Files explanation

### General:
+ The .sv files are described in the comments.
+ The tb.sh file is used to run testbench through icarius Verilog and gtkWave.


### In the Pictures folder:
+ There is a simulation run of the current version of the program (09.02.25) in two pictures.
+ There is a diagram showing the structure and connections of the processor.


### simulation screenshots:
+ The area up to the first marker A separates the testing period the Register section instructions.
+ The area between markers A and B is the testing period of the Data Memory section instructions.
+ The area between markers B and C is the testing period of the Immediate section instructions.
+ The area between markers C and D is the testing period of the NOP instructions.
+ The area between markers D and E is testing period of the JMP_IMD, ST_* instructions and preparation of the processor for the initial state with instructions.


### In the sim_files folder:
+ Simulation files are located there.
+ To run the gtkw file, change the path in its 5th and 8th lines. You can use the openOld_GTWK_file.sh file for this.
+ There should be 3 files with the same name as the module under test: no extension, .vcd, .gtkw.
+ The current testbench is top_tb.sv.


### In the ASSEMBLER folder:
+ The `assembler.m` file is used to create instructions in the binary.
+ The file `accuCheckValues.hex` contains within it the correct values of the accumulator in each cycle.
+ The file `InstructionDefines.csv` contains the definitions of numeric values for mnemonics (defines).
+ The file `InsBin.asm` contains instructions in binary.
+ File `Instructions_ValueCheck.asm` contains a set of processor test instructions - program.

### Bash scripts:
+ openOld_GTWK_file.sh &nbsp; Changes the paths in the GTKW file to point to the correct storage location and the .vcd simulation file.
+ tb.sh &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starts compilation and simulation.
+ tb_new.sh &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Starts compilation and simulation for the new gtkw file

### In the diagram folder:
+ Processor diagram files are located.


# Polish Version

## Co trzeba zrobić?
+ Zmienić połączenia, aby możliwym było wykonanie skoku z każdej sekcji instrukcji jak planowano.
+ Zmienić nazwy zmiennych na snake_case - ostatecznie uznałem (arbitralnie), że ta będzie najlepsza.
+ Sparametryzować szerokość wejść/wyjść w każdym module
+ Refaktoryzować dla najnowszej wersji iverilog

## PYTANIA - Dlaczego...?
+ Używałem starej wersji iverilog? Przez problemy z własnym sprzętem musiałem stosować różne komputery, w tym ten ze starszą wersją Icarius Verilog.
+ Icarius Verilog i GTKwave? - najprostsze rozwiązanie (szczególnie dla nowicjusza), które działało na każdym sprzęcie, w tym na zastępczym 10-letnim laptopie.
+ Tak dziwne nazwy zmiennych? - Początkowo zakładałem stosowanie UpperCamelCase, jednak przez stosowanie skrótków takich jak CE - Clock Enable powstawały czasem definicje zmiennych wyglądające jak stałe. Stąd pewien chaos. Później, widząc klarowność snake_case, zdecydowałem się zmienić standard na snake_case.

## Wyjaśnienie plików 

### Ogólne:
+ Pliki .sv są opisane w komentarzach.
+ Plik tb.sh służy do uruchamiania testbencha przez icarius Verilog oraz gtkWave.

### W folderze Pictures:
+ Znajduje się przebie symulacji obecnej wersji programu (09.02.25) na dwóch zdjęciach.
+ Znajduję się diagram przedstawiający budowę i połączenia procesora.

### zrzuty ekranu symulacji:
+ Obszar do pierwszego markera A oddziela okres testowania instrukcji sekcji rejestru.
+ Obszar między markerami A i B to okres testowania instrukcji sekcji Data Memory.
+ Obszar między markerami B i C to okres testowania instrukcji sekcji Immediate.
+ Obszar między markerami C i D to okres testowania instrukcji NOP.
+ Obszar między markerami D i E to okres testowania instrukcji JMP_IMD, ST_* oraz przygotowuje procesor do stanu początkowego za pomocą instrukcji.

### W folderze sim_files:
+ Znajdują się tam pliki symulacyjne.
+ Aby uruchomić plik gtkw należy zmienić ścieżkę w jego 5 i 8 linii. Można do tego wykorzystać plik openOld_GTWK_file.sh.
+ Powinny być 3 pliki o tej samej nazwie co testowany moduł: bez rozszerzenia, .vcd, .gtkw.
+ Obecnym testbenchem jest top_tb.sv.


### W folderze ASSEMBLER:
+ Plik `assembler.m`             służy do stworzenia instrukcji w binarce.
+ Plik `accuCheckValues.hex`          zawiera w sobie poprawne wartości akumulatora w każdym z cykli.
+ Plik `InstructionDefines.csv`       zawiera definicje wartości liczbowych do mnemoniców (definy).
+ Plik `InsBin.asm`                   zawiera instrukcje w binarce.
+ Plik `Instructions_ValueCheck.asm`  zawiera zestaw instrukcji testowych procesora - program.

### skrypty Bash:
+ openOld_GTWK_file.sh &nbsp; Zmienia ścieżki w pliku GTKW, aby wskazywały na odpowiednią lokalizację zapisu oraz pliku symulacji .vcd.
+ tb.sh &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Uruchamia kompilacje i symulacje.
+ tb_new.sh   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Uruchamia kompilacje i symulacje dla nowego pliku gtkw.


### W folderze diagram:
+ Znajdują się pliki diagramu procesora.