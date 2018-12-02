`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* npc module
* (.pc(), .imm_16(), .imm_26(), .npc_op(), .npc())
*/
module npc(
    input wire[31:0]  pc,       // output of pc
    input wire[15:0]  imm_16,   // the 16-bit immediate num 
    input wire[25:0]  imm_26,   // the 26-bit immediate num
    input wire[1:0]   npc_op,   // option of npc
    
    output wire[31:0] npc       // output of npc to change pc
    );
    
    assign npc = (npc_op == `NPC_OP_ADD4) ? pc + 4 : // pc + 4
                 (npc_op == `NPC_OP_IMM26) ? {pc[31:28], imm_26, 2'b00} : // pc <- (imm_26 << 2)
                 (npc_op == `NPC_OP_IMM16) ? pc + 4 + {{14{imm_16[15]}}, imm_16, 2'b00} : // pc + 4 + unsigned(imm_16 << 2)
                 32'h00000000;
endmodule
