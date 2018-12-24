`timescale 1ns / 1ps

module mips_soc(
    input wire clk,
    input wire rst,
    
    output wire io_o
    );
    
    wire[31:0] addr;
    wire[31:0] inst;
    
    mips MIPS_MIPS(
      .clk(clk),
      .rst(rst),
      .inst(inst),
      .pc(addr)
    );
    
    rom MIPS_ROM(
      .clka(clk),    // input wire clka
      .addra(addr[11:2]),  // input wire [9 : 0] addra
      .douta(inst)  // output wire [31 : 0] douta
    );
endmodule
