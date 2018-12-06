`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* ctrl module
* (.op(), .sa(), .func(), .beqout(), .alu_ctrl(), .npc_ctrl(), .reg_w_en(), .dm_w_en(), 
.ext_op(), .reg_rd_sel(), .reg_wdata_sel(), .alu_in_sel())
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
    output wire[`EXT-1:0]      ext_op,      // extend option
    output wire[1:0]           reg_rd_sel,
    output wire[1:0]           reg_wdata_sel,
    output wire                alu_in_sel
    );
    
    wire typeR,sll,add,sub,_and,addiu,lw,sw,lui,ori,beq,j,jal;
    assign typeR = (op == `INST_TYPE_R) ? 1 : 0;
    assign sll   = (typeR && func == `INST_SLL) ? 1 : 0;
    assign add   = (typeR && func == `INST_ADD) ? 1 : 0;
    assign sub   = (typeR && func == `INST_SUB) ? 1 : 0;
    assign _and  = (typeR && func == `INST_AND) ? 1 : 0;
    
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
    assign reg_w_en = (typeR || addiu || lw || lui || ori || jal) ? 1 : 0;
    assign dm_w_en  = (sw) ? 1 : 0;
    assign ext_op   = (lui) ? `EXT_SL16 : 
                      (addiu || lw || sw) ? `EXT_SIGN :
                      `EXT_UNSIGN;
    assign reg_rd_sel = (jal) ? 2'b00 : 
                        (addiu || lw || lui || ori) ? 2'b01 : 
                        (typeR) ? 2'b10 :
                        2'b11;
    assign reg_wdata_sel = (typeR || addiu || ori) ? 2'b00 : 
                           (lw) ? 2'b01 :
                           (jal) ? 2'b10 :
                           2'b11;
    assign alu_in_sel = (typeR || beq) ? 1'b0 : 1'b1;
endmodule
