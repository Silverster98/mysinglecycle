`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    mips_soc SOC(.clk(clk), .rst(rst));
    
    initial begin
        rst = 1;
        clk = 0;
        
        #15 rst = 0;
        #300 $stop;
    end
        
    always #10 clk = ~clk;
    
endmodule
