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
        3'd0: begin //ADD
            {Co,out} = A + R + Ci;
        end

        3'd1: begin //SUB
            {Co,out} = A - R - Ci;
        end

        3'd2: begin //AND
            out = A & R;
            Co = 0;
        end

        3'd3: begin //OR
            out = A | R;
            Co = 0;                
        end

        3'd4: begin //XOR
            out = A ^ R;
            Co = 0;   
        end
        3'd5: begin //NOT
            out = ~A;
            Co = 0;
        end
        3'd6: begin //LD
            out = R;
            Co = 0;
        end
    endcase
end
endmodule