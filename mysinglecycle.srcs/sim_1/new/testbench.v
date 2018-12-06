`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[15:0] imm_16;
    reg[1:0]  ext_op;
    wire[31:0] extout;
    extend ext(.imm_16(imm_16), .ext_op(ext_op), .dout(extout));

    initial begin
        rst = 1;
        clk = 0;
        
        ext_op = 2'b00;
        imm_16 = 16'h0017;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        
        #10;
        ext_op = 2'b00;
        imm_16 = 16'hf113;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        
        #10;
        ext_op = 2'b00;
        imm_16 = 16'h0000;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        #10;
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
