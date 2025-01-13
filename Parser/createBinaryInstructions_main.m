clc; close all; clear;




filenameReadIns = "InstructionsV3.asm";
filenameReadDefines = "InstructionDefines.csv" ;
filenameWrite = "InsBin.asm";
binSize=[5,8]; %[opcode, arg]

%Creating Define Rules from the CSV
opcodeDefines = getDefinesFromCSV(filenameReadDefines);          

%Getting number of instructions to translate
numOfLines = getNumOfLines(filenameReadIns);               

%Getting Instructions seprated for Opcodes and Arguments as strings
[opcodes, args] = getInstructionsToOpcodesAndArgs(filenameReadIns,numOfLines,32,';',32,'R');

%Getting Values out of Opcodes and Arguments as doubles and binaries
[opcodesValDec,argsValDec,opcodesValBin,argsValBin] = getInstructionValues(opcodes, args, opcodeDefines, numOfLines, binSize);

%Concating instructions into one
InstructionBin = [opcodesValBin,argsValBin];

%Saving Instructions in a file
saveInstructionBinToFile(filenameWrite,InstructionBin)

%Opening file for 
%open(filenameWrite)





%% Functions

function opcodeDefines = getDefinesFromCSV(filenameReadDefines)
    anyarg=32;
    numOfLinesDef = getNumOfLines(filenameReadDefines);
    [opcodesDef, argsDef] = getInstructionsToOpcodesAndArgs(filenameReadDefines,numOfLinesDef,';',anyarg,anyarg,';');
    
    opcodeDefines=cell(numOfLinesDef,2);
    opcodeDefines(1:numOfLinesDef,1)=deal({""});
    for i=1:numOfLinesDef
        opcodeDefines(i,1:2)={opcodesDef(i,1),str2double(argsDef(i,1))};
    end
end
function saveInstructionBinToFile(filenameWrite,InstructionBin)
    fileWrite = fopen(filenameWrite,"w");
    if(fileWrite==0)
        return
    end

    fprintf(fileWrite, '%s\n', string(InstructionBin));
    fclose(fileWrite);
end

function [opcodesValDec,argsValDec,opcodesValBin,argsValBin] = getInstructionValues(opcodes, args, opcodeDefines, numOfLines,binSize)
    opcodeDefinesStrings = string(opcodeDefines(:,1));
    opcodeDefinesValuesDec = cell2mat(opcodeDefines(:,2));
    opcodeDefinesLen = length(opcodeDefines(:,1));

    opcodesValDec = zeros(numOfLines,1);
    argsValDec = zeros(numOfLines,1);
    
    for j=1:opcodeDefinesLen
        defStr = opcodeDefinesStrings(j);
        for i=1:numOfLines
            if(strcmp(defStr,opcodes(i)))
                opcodesValDec(i) = opcodeDefinesValuesDec(j);
            end
        end
    
    end
    opcodesValBin = dec2bin(opcodesValDec,binSize(1));
    
    
    for i=1:numOfLines
        if(args(i)~="")
            argsValDec(i) =  str2double(args(i));
        end
    end
    
    argsValBin=dec2bin(argsValDec,binSize(2));
end



function[opcodes, args] = getInstructionsToOpcodesAndArgs(filename,numOfLines,sep1,sep2,sep3,sep4)

    opcodes = strings(numOfLines,1);
    args = strings(numOfLines,1);
    fileRead = fopen(filename,"r");
    if(fileRead==0) 
            return; 
    end
    
    % GET OPCODE
    for j=1:numOfLines
        fileLine = fgetl(fileRead);
    
        i=1;
        opcode="";
        while(fileLine(i)~=sep1)
            opcode=opcode+fileLine(i);
            i=i+1;
        end
        opcodes(j)=opcode;
        % GET ARG/DATA
        arg = "";
        while(fileLine(i)~=sep2)
            if((fileLine(i)~=sep3) && (fileLine(i)~=sep4))
                    arg=arg+fileLine(i);
            end
            if((sep1==sep4 && i~=length(fileLine))) %%This line for defines
                i=i+1;
            else
                break
            end
        end
        args(j)=arg;
    end
    
    fclose(fileRead);
end

function numOfLines = getNumOfLines(filename)
    fileRead = fopen(filename,"r");
    if(fileRead==0) 
        return; 
    end
    
    numOfLines = 0;
     while ~feof(fileRead)
         fgetl(fileRead);
         numOfLines=numOfLines+1;
     end
    fclose(fileRead);
end


