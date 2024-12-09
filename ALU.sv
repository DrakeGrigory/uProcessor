`include "defines.sv"

module ALU
(input [2:0] ALUCode,
 input [7:0] A, //Aku
 input [7:0] R, //Reg
 input Ci,
 
 output logic Co,
 output logic [7:0] out
 
);

always @(*) begin
    case (ALUCode)
        `ALU_ADD: begin //ADD
            {Co,out} = A + R + Ci;
        end

        `ALU_SUB: begin //SUB
            {Co,out} = A - R - Ci;
        end

        `ALU_AND: begin //AND
            out = A & R;
            Co = 0;
        end

        `ALU_OR: begin //OR
            out = A | R;
            Co = 0;                
        end

        `ALU_XOR: begin //XOR
            out = A ^ R;
            Co = 0;   
        end
        `ALU_NOT: begin //NOT
            out = ~A;
            Co = 0;
        end
        `ALU_LDR: begin //LDR
            out = R;
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