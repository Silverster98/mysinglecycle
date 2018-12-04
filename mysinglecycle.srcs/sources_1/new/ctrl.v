`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* ctrl module
* 
*/
module ctrl(
    input wire[5:0] op,                     // operate code
    input wire[4:0] sa,                     // sa
    input wire[5:0] func,                   // func code
    input wire      beqout,                 // the single of alu answer is zero
    
    output wire[`ALU_CTRL-1:0] alu_ctrl,    // 
    output wire[`NPC_CTRL-1:0] npc_ctrl,
    output wire                reg_w_en,
    output wire                dm_w_en,
    output wire[`EXT-1:0]      ext_op       // extend option
    );
    
    wire typeR,sll,add,sub,_and,addiu,lw,sw,lui,ori,beq,j,jal;
    assign typeR = (op == `INST_TYPE_R) ? 1 : 0;
    assign sll   = (typeR && func == `INST_SLL) ? 1 : 0;
    assign add   = (typeR && func == `INST_ADD) ? 1 : 0;
    assign sub   = (typeR && func == `INST_SUB) ? 1 : 0;
    assign _and  = (typeR && func == `INST_SUB) ? 1 : 0;
    
    assign addiu = (op == `INST_ADDIU) ? 1 : 0;
    assign lw    = (op == `INST_LW) ? 1 : 0;
    assign sw    = (op == `INST_SW) ? 1 : 0;
    assign lui   = (op == `INST_LUI) ? 1 : 0;
    assign ori   = (op == `INST_ORI) ? 1 : 0;
    assign beq   = (op == `INST_BEQ) ? 1 : 0;
    
    assign j     = (op == `INST_J) ? 1 : 0;
    assign jal   = (op == `INST_JAL) ? 1 : 0;
    
    assign alu_ctrl = (add || addiu || lw || sw) ? `ALU_OP_ADD : 
                      (sub || beq) ? `ALU_OP_SUB : 
                      (_and) ? `ALU_OP_AND : 
                      (ori) ? `ALU_OP_OR :
                      (sll) ? `ALU_OP_SL :
                      3'b111;
    assign npc_ctrl = (j || jal) ? `NPC_OP_IMM26 : 
                      (beq) ? `NPC_OP_IMM16 :
                      `NPC_OP_ADD4;
    assign reg_w_en = (typeR || addiu || lw || lui || ori) ? 1 : 0;
    assign dm_w_en  = (sw) ? 1 : 0;
    assign ext_op   = (lui) ? `EXT_SL16 : 
                      (addiu || lw || sw) ? `EXT_SIGN :
                      `EXT_UNSIGN;
    
    
    
endmodule
