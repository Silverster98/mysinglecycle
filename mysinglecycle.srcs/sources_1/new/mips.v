`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* mips module
*/
module mips(
    input wire clk,
    input wire rst
    );
    
    wire[31:0] inst;
    
    wire[5:0]  op;
    wire[15:0] imm16;
    wire[25:0] imm26;
    wire[4:0]  rs;
    wire[4:0]  rt;
    wire[4:0]  rd;
    wire[4:0]  sa;
    wire[5:0]  func;
    
    assign op    = inst[31:26];
    assign imm16 = inst[15:0];
    assign imm26 = inst[25:0];
    assign rs    = inst[25:21];
    assign rt    = inst[20:16];
    assign rd    = inst[15:11];
    assign sa    = inst[10:6];
    assign func  = inst[5:0];
    
    
    wire[`NPC_CTRL-1:0] if_op;
    wire[`EXT-1:0] ext_op;
    wire[1:0] reg_rd_sel;
    wire[1:0] reg_wdata_sel;
    wire reg_w_en;
    
    
    wire[31:0] ext_out;
    wire[31:0] rs1_out,rs2_out;
    wire[31:0] alu_out;
    wire       beqout;
    
    wire[31:0] dout; // dm output
    wire[31:0] pc_8; // IF output of pc+8
    
    
    
    inst_fetch U_IF(.rst(rst), .clk(clk), .imm_16(imm16), .imm_26(imm26), .op(if_op), .inst(inst));
    
    extend U_EXT(.imm_16(imm16), .ext_op(ext_op), .dout(ext_out));
    
    wire[4:0] mux4_5out;
    wire[31:0] mux4_32out;
    mux_4_5 U_MUX4_5(.in1(5'b11111), .in2(rt), .in3(rd), .sel(reg_rd_sel), .out(mux4_5out));
    mux_4_32 U_MUX4_32(.in1(alu_out), .in2(dout), .in3(pc_8), .in4(ext_out), .sel(reg_wdata_sel), .out(mux4_32out));
    regfile U_RF(.clk(clk), .rs1_i(rs), .rs2_i(rt), .rd_i(mux4_5out), .w_en(reg_w_en), .w_data(mux4_32out), .rs1_o(rs1_out), .rs2_o(rs1_out));
    
    
endmodule
