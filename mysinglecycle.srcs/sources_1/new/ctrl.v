`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* ctrl module
* 
*/
module ctrl(
    input wire[5:0] op,
    input wire[4:0] sa,
    input wire[5:0] func,
    input wire      beqout,
    
    output wire[`ALU_CTRL-1:0] alu_ctrl,
    output wire[`NPC_CTRL-1:0] npc_ctrl,
    output wire                reg_w_en,
    output wire                dm_w_en,
    output wire[`EXT-1:0]      ext_op
    );
    
    
endmodule
