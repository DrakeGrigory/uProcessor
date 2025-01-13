clc; close all; clear;

filenameReadIns = "InstructionsV3.asm";
filenameReadDefines = "InstructionDefines.csv" ;
filenameWrite = "InsBin.asm";

% opcodeDefines= {
% "ADD_R",	0;
% "SUB_R",	1;
% "AND_R",	2;
% "OR_R",		3;
% "XOR_R",	4;
% "JMP_R",	5;
% "ADD_DM",	8;
% "SUB_DM",	9;
% "AND_DM",	10;
% "OR_DM",	11;
% "XOR_DM",	12;
% "JMP_DM",	13;
% "ADD_IMD",	16;
% "SUB_IMD",	17;
% "AND_IMD",	18;
% "OR_IMD",	19;
% "XOR_IMD",	20;
% "JMP_IMD",	21;
% "LD_R",		24;
% "LD_DM",	25;
% "LD_IMD",	26;
% "ST_DM",	27;
% "ST_R",		28;
% "NOT",		29;
% "NOP"		31}; 


numOfLinesDef = getNumOfLines(filenameReadDefines);
[opcodesDef, argsDef] = getInstructionsCodenames(filenameReadDefines,numOfLinesDef)



return
numOfLines = getNumOfLines(filenameReadIns);
[opcodes, args] = getInstructionsCodenames(filenameReadIns,numOfLines);


[opcodesValDec,argsValDec,opcodesValBin,argsValBin] = getInstructionValues(opcodes, args, opcodeDefines, numOfLines);

InstructionBin = [opcodesValBin,argsValBin];

saveInstructionBinToFile(filenameWrite,InstructionBin)
open(filenameWrite)





%% Functions

function saveInstructionBinToFile(filenameWrite,InstructionBin)
    fileWrite = fopen(filenameWrite,"w");
    if(fileWrite==0)
        return
    end

    fprintf(fileWrite, '%s\n', string(InstructionBin));
    fclose(fileWrite);
end

function [opcodesValDec,argsValDec,opcodesValBin,argsValBin] = getInstructionValues(opcodes, args, opcodeDefines, numOfLines)
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
    opcodesValBin = dec2bin(opcodesValDec);
    
    
    for i=1:numOfLines
        if(args(i)~="")
            argsValDec(i) =  str2double(args(i));
        end
    end
    
    argsValBin=dec2bin(argsValDec,8);
end



function[opcodes, args] = getInstructionsCodenames(filename,numOfLines)

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
        while(fileLine(i)~=' ')
            opcode=opcode+fileLine(i);
            i=i+1;
        end
        opcodes(j)=opcode;
        % GET ARG/DATA
        arg = "";
        while(fileLine(i)~=';')
            if(fileLine(i)~=' ' && fileLine(i)~='R')
                arg=arg+fileLine(i);
            end
            i=i+1;
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


