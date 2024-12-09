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
        `ADD: begin //ADD
            {Co,out} = A + R + Ci;
        end

        `SUB: begin //SUB
            {Co,out} = A - R - Ci;
        end

        `AND: begin //AND
            out = A & R;
            Co = 0;
        end

        `OR: begin //OR
            out = A | R;
            Co = 0;                
        end

        `XOR: begin //XOR
            out = A ^ R;
            Co = 0;   
        end
        `NOT: begin //NOT
            out = ~A;
            Co = 0;
        end
        `LD: begin //LD
            out = R;
            Co = 0;
        end
    endcase
end
endmodule