`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[31:0] A,B;
    wire[31:0] C;
    reg[4:0] s;
    reg[`ALU_CTRL-1:0] alu_ctrl;
    wire beqout;
    
    alu alu(.A(A), .B(B), .alu_ctrl(alu_ctrl), .s(s), .C(C), .beqout(beqout));
    initial begin
        rst = 1;
        clk = 0;
        A = 32'h001f;
        B = 32'h0001;
        s = 5'h3;
        alu_ctrl = 3'b000;
        #10
        B = 32'h001f;
        alu_ctrl = 3'b001;
        #10
        B = 32'h002a;
        alu_ctrl = 3'b100;
        #10
        alu_ctrl = 3'b101;
        #10
        alu_ctrl = 3'b010;
        #10
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
