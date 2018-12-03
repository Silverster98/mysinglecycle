`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* alu module
* (.A(), .B(), .alu_ctrl(), .C(), .beqout())
*/

module alu(
    input wire[31:0] A,             // operation number A
    input wire[31:0] B,             // operation number B
    input wire[`ALU_CTRL-1:0] alu_ctrl,   // alu ctrl signal
    
    output wire[31:0] C,            // answer
    output wire beqout              // singal of answer is zero 
    );
    
    reg[32:0] temp;                 // temp variable
    assign C = temp[31:0];
    assign beqout = (temp == 0) ? 1'b1 : 1'b0;
    
    always @ (*) begin
        case (alu_ctrl)
            `ALU_OP_ADD : temp <= {A[31], A} + {B[31], B}; // add operation
            `ALU_OP_SUB : temp <= {A[31], A} - {B[31], B}; // sub operation
            
            default : temp <= {B[31], B};
        endcase
    end
endmodule
