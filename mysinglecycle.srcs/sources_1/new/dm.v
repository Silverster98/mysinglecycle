`timescale 1ns / 1ps
/**
* dm module
*/
module dm(
    input wire[11:2] addr,
    input wire[31:0] wdata,
    input wire       w_en,
    input wire       clk,
    
    output wire[31:0] dout
    );
    
    reg[31:0] dm[1023:0];
    assign dout = dm[addr];
    
    always @ (posedge clk) begin
        if (w_en) begin
            dm[addr] <= wdata;
        end
    end
endmodule
