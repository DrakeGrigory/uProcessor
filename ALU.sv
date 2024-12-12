`include "defines.sv"

module ALU
(input [2:0] ALUCode,
 input [7:0] Accu, //Aku
 input [7:0] memIn, //Reg
 input Ci,
 
 output logic Co,
 output logic [7:0] out
 
);

always @(*) begin
    case (ALUCode)
        `ALU_ADD: begin //ADD
            {Co,out} = Accu + memIn + Ci;
        end

        `ALU_SUB: begin //SUB
            {Co,out} = Accu - memIn - Ci;
        end

        `ALU_AND: begin //AND
            out = Accu & memIn;
            Co = 0;
        end

        `ALU_OR: begin //OR
            out = Accu | memIn;
            Co = 0;                
        end

        `ALU_XOR: begin //XOR
            out = Accu ^ memIn;
            Co = 0;   
        end
        `ALU_NOT: begin //NOT
            out = ~Accu;
            Co = 0;
        end
        `ALU_LD: begin //LD
            out = memIn;
            Co = 0;
        end
        default:
        begin
            out = 0;
            Co = 0;
        end
    endcase
end
endmodule