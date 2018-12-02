// instruction definition
`define INST_TYPE_R 6'b000000 // decode according to funct field, op = 6'b000000
    `define INST_ADD 6'b100000 // add

// NPC option definition
`define NPC 2'b11
`define NPC_OP_ADD4  2'b00
`define NPC_OP_IMM26 2'b01
`define NPC_OP_IMM16 2'b10

// im config
`define IM_CAPACITY 1023