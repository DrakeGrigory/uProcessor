`include "defines.sv"

module ALU
(input [2:0] ALUCode,
 input [7:0] Accu, //Aku
 input [7:0] MemIn, //Reg
 input Ci,
 
 output logic Co,
 output logic [7:0] Out
 
);

always @(*) begin
    case (ALUCode)
        `ALU_ADD: begin //ADD
            {Co,Out} = Accu + MemIn + Ci;
        end

        `ALU_SUB: begin //SUB
            {Co,Out} = Accu - MemIn - Ci;
        end

        `ALU_AND: begin //AND
            Out = Accu & MemIn;
            Co = 0;
        end

        `ALU_OR: begin //OR
            Out = Accu | MemIn;
            Co = 0;                
        end

        `ALU_XOR: begin //XOR
            Out = Accu ^ MemIn;
            Co = 0;   
        end
        `ALU_NOT: begin //NOT
            Out = ~Accu;
            Co = 0;
        end
        `ALU_LD: begin //LD
            Out = MemIn;
            Co = 0;
        end
        default:
        begin
            Out = 0;
            Co = 0;
        end
    endcase
end
endmodule