module PP (
    input [4:0] addr,
    output reg [5:0] InsOut
);

integer i=0;
reg [5:0] Mem [31:0];

initial begin
    for(i=0; i<31; i=i+1) begin
        Mem[i] = {`OPCODE_NOP,2'bxx};
    end

    Mem[0] = {`OPCODE_ADD,`R1};
    Mem[1] = {`OPCODE_SUB,`R1};
    Mem[2] = {`OPCODE_ADD,`R2};
    Mem[3] = {`OPCODE_AND,`R3};
    Mem[4] = {`OPCODE_ADD,`R3};
    
end

assign InsOut = Mem[addr];




endmodule