//ALU
`define ALU_ADD  3'd0
`define ALU_SUB  3'd1
`define ALU_AND  3'd2
`define ALU_OR   3'd3
`define ALU_XOR  3'd4
`define ALU_NOT  3'd5
`define ALU_LD   3'd6
`define ALU_DEF  3'd7


//INSTRUCTION
`define OPCODE_ADD_R {2'b00, 3'd0}
`define OPCODE_SUB_R {2'b00, 3'd1}
`define OPCODE_AND_R {2'b00, 3'd2}
`define OPCODE_OR_R  {2'b00, 3'd3}
`define OPCODE_XOR_R {2'b00, 3'd4}
`define OPCODE_JMP_R {2'b00, 3'd5}

`define OPCODE_ADD_DM {2'b01, 3'd0}
`define OPCODE_SUB_DM {2'b01, 3'd1}
`define OPCODE_AND_DM {2'b01, 3'd2}
`define OPCODE_OR_DM  {2'b01, 3'd3}
`define OPCODE_XOR_DM {2'b01, 3'd4}
`define OPCODE_JMP_DM {2'b01, 3'd5}

`define OPCODE_ADD_IMD {2'b10, 3'd0}
`define OPCODE_SUB_IMD {2'b10, 3'd1}
`define OPCODE_AND_IMD {2'b10, 3'd2}
`define OPCODE_OR_IMD  {2'b10, 3'd3}
`define OPCODE_XOR_IMD {2'b10, 3'd4}
`define OPCODE_JMP_IMD {2'b10, 3'd5}

`define OPCODE_LD_R   {2'b11, 3'd0}
`define OPCODE_LD_DM  {2'b11, 3'd1}
`define OPCODE_LD_IMD {2'b11, 3'd2}
`define OPCODE_ST_DM  {2'b11, 3'd3}
`define OPCODE_ST_R   {2'b11, 3'd4}
`define OPCODE_NOT    5'd29  //3'd5

`define OPCODE_NOP    5'd31  //3'd7


`define R0 {2'd0,6'd0}
`define R1 {2'd1,6'd0}
`define R2 {2'd2,6'd0}
`define R3 {2'd3,6'd0}

//INSTRUCTION DECODER
`define PM_ID_INS_WIDTH 13;

`define SEC_R    2'd0
`define SEC_DM   2'd1
`define SEC_IMD  2'd2
`define SEC_REST 2'd3

`define JMP 3'd5


