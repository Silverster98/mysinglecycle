`timescale 1ns / 1ps
/**
* pc module
* (.rst(), .clk(), .npc(), .pc())
*/
module pc(
    input wire       rst,
    input wire       clk,
    input wire[31:0] npc, // output of npc module
    
    output reg[31:0] pc   // output pc at the moment 
    );
    
    always @ (posedge rst or posedge clk) begin
        if (rst) begin
            pc <= 32'h00000000;
        end else begin
            pc <= npc;
        end
    end
endmodule
