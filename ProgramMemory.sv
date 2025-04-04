/* WHAT IS THIS? 
// This module is a Program Memory
// It loads instructions in binary from a file generated by a custom made assembler.
// Then it pushes the instructions to the memory of this module.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module ProgramMemory (
    input [5:0] addr,           //Address of instruction
    output reg [12:0] InsOut    //Outputed instruction
);

localparam insFilePath = "Assembler/InsBin.asm";

integer i=0;
reg [12:0] Mem  [63:0];

//memory initialisation 
initial begin 
    for(i=0; i<=63; i=i+1) begin
        Mem[i] = {`OPCODE_NOP,8'bxxxx_xxxx};
    end

//loading instructions
$readmemb(insFilePath, Mem,0,63);
end 

assign InsOut = Mem[addr];

endmodule