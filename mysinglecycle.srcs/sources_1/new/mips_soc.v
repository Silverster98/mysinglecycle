`timescale 1ns / 1ps

module mips_soc(
    input wire clk,
    input wire rst,
    
    output wire io_o
    );
    
    wire[31:0] addr;
    wire[31:0] inst;
    wire[31:0] wout_addr;
    wire[31:0] wout_data;
    wire wout_en;
    
    wire[31:0] w_addr;
    wire ram_w_en;
    wire io_w_en;
    reg io_out;
    
    always @ (posedge clk) begin
        if (io_w_en == 1'b1) begin
            io_out <= 1; 
        end
    end
    assign io_o = io_out;
    
    
    mips MIPS_MIPS(
      .clk(clk),
      .rst(rst),
      .inst(inst),
      .pc(addr),
      .wout_addr(wout_addr),
      .wout_data(wout_data),
      .wout_en(wout_en)
    );
    
    mem_map MIPS_MEM_MAP(
      .w_addr_i(wout_addr),
      .w_en(wout_en),
      .ram_w_en(ram_w_en),
      .io_w_en(io_w_en),
      .w_addr_o(w_addr)
    );
    
    
//    rom MIPS_ROM(
//      .clka(clk),    // input wire clka
//      .addra(addr[11:2]),  // input wire [9 : 0] addra
//      .douta(inst)  // output wire [31 : 0] douta
//    );
    blk_mem_gen_0 MIPS_ROM(
      .clka(clk),    // input wire clka
      .addra(addr[11:2]),  // input wire [9 : 0] addra
      .douta(inst)  // output wire [31 : 0] douta
    );
endmodule
