// instruction definition
`define INST_TYPE_R 6'b000000 // decode according to funct field, op = 6'b000000
    `define INST_ADD 6'b100000 // add

// NPC option definition
`define NPC_CTRL 2
`define NPC 2'b11
`define NPC_OP_ADD4  2'b00
`define NPC_OP_IMM26 2'b01
`define NPC_OP_IMM16 2'b10

// im config
`define IM_CAPACITY 1023

// alu config
`define ALU_CTRL     3
`define ALU_OP_ADD 3'b000
`define ALU_OP_SUB 3'b001

// ctrl config


// ext config
`define EXT 2