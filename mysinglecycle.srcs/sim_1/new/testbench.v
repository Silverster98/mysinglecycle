`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    mips my_mips(clk, rst);
    initial begin
        rst = 1;
        clk = 0;
        // read instruction
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", my_mips.U_IF.MIPS_IM.im);
        #30 rst = 0;
        #130;
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
