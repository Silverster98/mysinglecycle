`timescale 1ns / 1ps

module mem_map(
    input wire[31:0] w_addr_i,
    input wire w_en,
    
    output wire ram_w_en,
    output wire io_w_en,
    output wire[31:0] w_addr_o
    );
    // 0x00000000~0x0fffffff for ram 256M
    // 0x10000000~0x1fffffff for io  256M
    
    wire[3:0] sel;
    
    assign sel = w_addr_i[31:28];
    assign ram_w_en = (sel == 4'b0000 && w_en == 1'b1) ? 1'b1 : 1'b0;
    assign io_w_en = (sel == 4'b0001 && w_en == 1'b1) ? 1'b1 : 1'b0;
    assign w_addr_o = {16'b0,w_addr_i[15:0]};
    
endmodule
