//ALU
`define ALU_ADD 3'd0
`define ALU_SUB 3'd1
`define ALU_AND 3'd2
`define ALU_OR  3'd3
`define ALU_XOR 3'd4
`define ALU_NOT 3'd5
`define ALU_LD  3'd6
`define ALU_DEF 3'd7


//INSTRUCTION
`define OPCODE_ADD_R {2'b00, 3'd0}
`define OPCODE_SUB_R {2'b00, 3'd1}
`define OPCODE_AND_R {2'b00, 3'd2}
`define OPCODE_OR_R  {2'b00, 3'd3}
`define OPCODE_XOR_R {2'b00, 3'd4}
`define OPCODE_NOT_R {2'b00, 3'd5}
`define OPCODE_JMP_R {2'b00, 3'd6}

`define OPCODE_ADD_DM {2'b01, 3'd0}
`define OPCODE_SUB_DM {2'b01, 3'd1}
`define OPCODE_AND_DM {2'b01, 3'd2}
`define OPCODE_OR_DM  {2'b01, 3'd3}
`define OPCODE_XOR_DM {2'b01, 3'd4}
`define OPCODE_NOT_DM {2'b01, 3'd5}
`define OPCODE_JMP_DM {2'b01, 3'd6}

`define OPCODE_ADD_IMD {2'b10, 3'd0}
`define OPCODE_SUB_IMD {2'b10, 3'd1}
`define OPCODE_AND_IMD {2'b10, 3'd2}
`define OPCODE_OR_IMD  {2'b10, 3'd3}
`define OPCODE_XOR_IMD {2'b10, 3'd4}
`define OPCODE_NOT_IMD {2'b10, 3'd5}
`define OPCODE_JMP_IMD {2'b10, 3'd6}

`define OPCODE_LD_R   5'd24  
`define OPCODE_ST_R   5'd25
`define OPCODE_LD_DM  5'd26  
`define OPCODE_ST_DM  5'd27
`define OPCODE_LD_IDM 5'd28
`define OPCODE_NOP    5'd31


`define R0 2'd0`
`define R1 2'd1`
`define R2 2'd2`
`define R3 2'd3

//INSTRUCTION DECODER
`define ALU_MAX_NUM 3'd7;
`define ID_IN_MSB 12;
