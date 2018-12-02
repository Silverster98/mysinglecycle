`timescale 1ns / 1ps
/**
* instruction fetch module
* (.rst(), .clk(), .imm_16(), .imm_26(), .op(), .inst())
*/
module inst_fetch(
    input wire        rst,      // 
    input wire        clk,      //
    input wire[15:0]  imm_16,   // 16-bit immediate num
    input wire[25:0]  imm_26,   // 26-bit immediate num
    input wire[1:0]   op,       // npc option
    
    output wire[31:0] inst      // instruction
    );
    
    wire[31:0] npc_out; // inner wire of npc output
    wire[31:0] pc_out;  // inner wire of pc output
    
    pc MIPS_PC(.rst(rst), .clk(clk), .npc(npc_out), .pc(pc_out)); // instantiation of pc
    npc MIPS_NPC(.pc(pc_out), .imm_16(imm_16), .imm_26(imm_26), .npc_op(op), .npc(npc_out)); // instantiation of npc
    im MIPS_IM(.addr(pc_out[11:2]), .inst(inst)); // instantiation of im
endmodule
