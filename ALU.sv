/* WHAT IS THIS? 
// This module is an Arithmetic Logic Unit
// It calculates results of most of the instructions.
// The output directly feeds the Accumulator
// It has 7 operations and 1 default case.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
*/

`include "defines.sv"

module ALU
(input [2:0] ALUCode,           // ALUCode provided by InsDec - selects proper operation described in Instruction
 input [7:0] AccuIn,            // Data from Accumulator output
 input [7:0] DataIn,            // Data from Secondary output (RegisterFile / Immediate / DataMemory)
 input Ci,                      // Carry In - used in overflow/underflow cases of ADD/SUB operations
 
 output logic Co,               // Carry Out - signalises whether overflow/underflow occured during ADD/SUB operations
 output logic [7:0] DataOut     // Outputs result of ALU operation
 
);

always @(*) begin
    case (ALUCode)
        `ALU_ADD: begin //0. ADD
            {Co,DataOut} = AccuIn + DataIn + Ci;
        end

        `ALU_SUB: begin //1. SUB
            {Co,DataOut} = AccuIn - DataIn - Ci;
        end

        `ALU_AND: begin //2. AND
            DataOut = AccuIn & DataIn;
            Co = 0;
        end

        `ALU_OR: begin //3. OR
            DataOut = AccuIn | DataIn;
            Co = 0;                
        end

        `ALU_XOR: begin //4. XOR
            DataOut = AccuIn ^ DataIn;
            Co = 0;   
        end
        `ALU_NOT: begin //5. NOT
            DataOut = ~AccuIn;
            Co = 0;
        end
        `ALU_LD: begin //6. LD
            DataOut = DataIn;
            Co = 0;
        end
        default:      //any other but in practise 7
        begin
            DataOut = 0;
            Co = 0;
        end
    endcase
end
endmodule