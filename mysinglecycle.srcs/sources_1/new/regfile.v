`timescale 1ns / 1ps
/**
* reg file module
* (.clk(), .rs1_i(), .rs2_i(), .rd_i(), .w_en(), .w_data(), .rs1_o(), .rs2_o())
*/

module regfile(
    input wire       clk,   // clk
    input wire[4:0]  rs1_i, // rs1 address
    input wire[4:0]  rs2_i, // rs2 address
    input wire[4:0]  rd_i,  // rd address
    input wire       w_en,  // write enable
    input wire[31:0] w_data, // write data
    
    output wire[31:0] rs1_o, // rs1 output
    output wire[31:0] rs2_o  // rs2 output
    );
    
    reg[31:0] gpr[31:0]; // 32 gpr
    
    assign rs1_o = (rs1_i == 0) ? 32'h00000000 : gpr[rs1_i]; // 
    assign rs2_o = (rs2_i == 0) ? 32'h00000000 : gpr[rs2_i]; // 
    
    always @ (posedge clk) begin
        if (w_en) begin
            gpr[rd_i] <= w_data; // if write data then write at clk posedge
        end
    end
endmodule
