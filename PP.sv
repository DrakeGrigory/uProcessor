module PP (
    input [4:0] addr,
    output reg [5:0] Mem [31:0] 
)

integer i;


initial begin
    for(i=0; i<31; i=i+1)
        Mem[i] = 6'b{`OPCODE_NOP,R0};    

    Mem[0] = 6'b{`OPCODE_ADD,R1};
    Mem[1] = 6'b{`OPCODE_ADD,R1};
    Mem[2] = 6'b{`OPCODE_ADD,R1};
    Mem[3] = 6'b{`OPCODE_ADD,R1};
    Mem[4] = 6'b{`OPCODE_ADD,R4};
    
end


endmodule