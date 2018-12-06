`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[31:0] addr;
    reg[31:0] wdata;
    reg wen;
    
    wire[31:0] dout;
    dm dm(.addr(addr[11:2]), .wdata(wdata), .w_en(wen), .clk(clk), .dout(dout));
    
    initial begin
        rst = 1;
        clk = 0;
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", dm.dm);
        addr = 32'h00000004;
        wdata = 32'h00abcdef;
        wen = 0;
        # 10 addr = 32'h00000018;
        wen = 1;
        #30
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
