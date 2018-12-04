// instruction definition
// add,sub,addiu,lw,sw,j,jal,jr,lui,ori,and,ssl
// type r
`define INST_TYPE_R     6'b000000 // decode according to funct field, op = 6'b000000
    `define INST_SLL    6'b000000 // sll
    `define INST_ADD    6'b100000 // add
    `define INST_SUB    6'b100010 // sub
    `define INST_AND    6'b100100 // and
// type i
`define INST_ADDIU      6'b001001 // addiu
`define INST_LW         6'b100011 // lw
`define INST_SW         6'b101011 // sw
`define INST_LUI        6'b001111 // lui
`define INST_ORI        6'b001101 // ori
`define INST_BEQ        6'b000100 // beq

// type j
`define INST_J          6'b000010 // j
`define INST_JAL        6'b000011 // jal


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
`define ALU_OP_SL  3'b010
`define ALU_OP_SR  3'b011
`define ALU_OP_AND 3'b100
`define ALU_OP_OR  3'b101

// ctrl config


// ext config
`define EXT 2
`define EXT_SL16    2'b00
`define EXT_SIGN    2'b01
`define EXT_UNSIGN  2'b10