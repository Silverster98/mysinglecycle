`timescale 1ns / 1ps
`include "instruction_head.v"
/**
* extend module
* (.imm_16(), .ext_op(), .dout())
*/
module extend(
    input wire[15:0]     imm_16,
    input wire[`EXT-1:0] ext_op,
    
    output wire[31:0]    dout
    );
    
    assign dout = (ext_op == `EXT_SL16) ? {imm_16,16'b0} : 
                  (ext_op == `EXT_SIGN) ? {{16{imm_16[15]}}, imm_16} : 
                  (ext_op == `EXT_UNSIGN) ? {16'b0, imm_16} : 
                  32'h00000000;
endmodule
