`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* im module
* (.addr(), .inst())
*/
module im(
    input wire[11:2] addr,   // pc
    
    output wire[31:0] inst  // output is instruction
    );
    
    reg[31:0] im[`IM_CAPACITY:0];
    assign inst = im[addr];
endmodule
