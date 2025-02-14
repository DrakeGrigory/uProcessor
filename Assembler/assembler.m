clc; close all; clear;
%Quick version of custom ASSEMBLER; Its bad, need to be refactored, but it works

%filenameReadIns = "Instructions.asm";
filenameReadIns = "Instructions_ValueCheck.asm";
filenameReadDefines = "InstructionDefines.csv" ;
filenameWrite = "InsBin.asm";
correctAccumulatorValueFile = "accuCheckValues.hex";

binSize=[5,8]; %[opcode, arg]

%Creating Define Rules from the CSV
opcodeDefines = getDefinesFromCSV(filenameReadDefines);          

%Getting number of instructions to translate
numOfLines = getNumOfLines(filenameReadIns);               

%Getting Instructions seprated for Opcodes and Arguments as strings
[opcodes, args] = getInstructionsToOpcodesAndArgs(filenameReadIns,numOfLines,correctAccumulatorValueFile);

flag_empty_args=1;
for i=1:numOfLines
   if(args(i)~="")
       flag_empty_args=0;
   end
end
if(flag_empty_args)
    fprintf(2,"\nERROR --- NO ARGS \n")
    return
end



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
    [opcodesDef, argsDef] = getOpcodesAndArgsFromDefines(filenameReadDefines,numOfLinesDef,';',anyarg,anyarg,';');
    
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





function[opcodes, args] = getOpcodesAndArgsFromDefines(filename,numOfLines,sep1,sep2,sep3,sep4)

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




function[opcodes, args] = getInstructionsToOpcodesAndArgs(filename,numOfLines,correctAccumulatorValueFile)
    
    sepSpace = ' ';
    sepSemicolon = ';';
    regChar = 'R';
    

    %predefine sizes of matrixes
    opcodes = strings(numOfLines,1);
    args = strings(numOfLines,1);
    correctAccuValues = strings(numOfLines,1);

    %open file and check for fail
    fileRead = fopen(filename,"r");
    if(fileRead==0) 
            return; 
    end
    
    % GET OPCODE
    for j=1:numOfLines
        %get line
        fileLine = fgetl(fileRead);
    
        %reset variables
        i=1;
        opcode="";
       
        while(fileLine(i)~=sepSpace)
            opcode=opcode+fileLine(i);
            i=i+1;
        end

        %save opcode
        opcodes(j)=opcode;


     %INSTRUCTION ARGS
        arg = "";
     
        while(fileLine(i)~=sepSemicolon)    
            
            if((fileLine(i)~=sepSpace) && fileLine(i)~=regChar)
                arg=arg+fileLine(i);
            end
            if(i~=length(fileLine)) 
                i=i+1;
            else
                break
            end
        end
        args(j)=arg;


      %CORRECT ACCUMULATOR VALUES
        correctAccuValue = "";
        i=i+1; %skip first semicolon
        while(fileLine(i)~=sepSemicolon)    
            
            if(fileLine(i)=="S")
               correctAccuValue="0";
               break;
            end

            if(fileLine(i)~=sepSpace)
                correctAccuValue=correctAccuValue+fileLine(i);
            end

            if(i~=length(fileLine)) 
                i=i+1;
            else
                break
            end
        end
        correctAccuValues(j) = correctAccuValue;
    end


    CAVFile = fopen(correctAccumulatorValueFile,"w");
    if(CAVFile==0)
            fprintf("Fopen Err");
            return; 
    end

    %fprintf(FID, '%50s \n', STR);

    CAVDoubleChar=dec2hex(str2double(correctAccuValues));
    CAVString = strings(numOfLines,1);
    CAVString = CAVString + CAVDoubleChar(:,1) +  CAVDoubleChar(:,2);
    fprintf(CAVFile,"%s\n",CAVString);
    fclose(CAVFile);


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


