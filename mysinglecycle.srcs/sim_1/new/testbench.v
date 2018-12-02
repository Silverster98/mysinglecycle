`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[15:0] imm_16;
    reg[25:0] imm_26;
    reg[1:0]  im_op;
    
    wire[31:0] inst;
    
    inst_fetch MIPS_IF(.rst(rst), .clk(clk), .imm_16(imm_16), .imm_26(imm_26), .op(im_op), .inst(inst));
    
    initial begin
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", MIPS_IF.MIPS_IM.im); // read test inst
        rst = 1;
        clk = 0;
        im_op = 2'b00; // test im_op = NPC_OP_ADD4
        #30 rst = 0;   // reset disable
        #140;
        imm_16 = 'h0002; // test im_op = NPC_OP_IMM16
        im_op = 2'b10;
        #40
        imm_26 = 'h0000005; // test im_op = NPC_OP_IMM26
        im_op = 2'b01;
        #40
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
