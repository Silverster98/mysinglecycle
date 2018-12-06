`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[4:0] rs1,rs2,rd;
    reg wen;
    reg[31:0] wdata;
    wire[31:0] rs1o,rs2o;
    regfile regfile(.clk(clk), .rs1_i(rs1), .rs2_i(rs2), .rd_i(rd), .w_en(wen), .w_data(wdata), .rs1_o(rs1o), .rs2_o(rs2o));

    initial begin
        rst = 1;
        clk = 0;
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", regfile.gpr);        
        rs1 = 5'b00000;
        rs2 = 5'b00001;
        #10 rs1 = 5'b00010;
        #10 rd  = 5'b00011;
        #10 wdata = 32'h000000ff;
        wen = 1;
        #40;
        
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule
