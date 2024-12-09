//ALU
`define ALU_ADD 3'd0
`define ALU_SUB 3'd1
`define ALU_AND 3'd2
`define ALU_OR  3'd3
`define ALU_XOR 3'd4
`define ALU_NOT 3'd5
`define ALU_LDR 3'd6
`define ALU_DEF 3'd7


//INSTRUCTION
`define OPCODE_ADD 4'd0
`define OPCODE_SUB 4'd1
`define OPCODE_AND 4'd2
`define OPCODE_OR  4'd3
`define OPCODE_XOR 4'd4
`define OPCODE_NOT 4'd5
`define OPCODE_LDR 4'd6
`define OPCODE_NOP 4'd7
`define OPCODE_LD  4'd8
`define OPCODE_ST  4'd12

`define R0 2'd0
`define R1 2'd1
`define R2 2'd2
`define R3 2'd3

//INSTRUCTION DECODER
`define ALU_MAX_NUM 3'd7;
