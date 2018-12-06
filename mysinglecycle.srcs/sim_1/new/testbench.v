`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[1:0] sel;
    reg[4:0] in1,in2,in3,in4;
    wire[4:0] out;
    
    mux_4_5 mux(.in1(in1), .in2(in2), .in3(in3), .sel(sel), .out(out));

    initial begin
        rst = 1;
        clk = 0;
        in1 = 5'b00001;
        in2 = 5'b00010;
        in3 = 5'b00011;
        in4 = 5'b00100;
        sel = 2'b00;
        #10 sel = 2'b01;
        #10 sel = 2'b10;
        #10 sel = 2'b11;
        #10;
        
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
