# mips 单周期个人设计
相比之前的单周期项目，本项目实现自行设计数据通路，并且更加规范的编写代码，实现更多指令。之前的那个是参考老师给的示例代码进行练手的。

所有代码在 mysinglecycle.srcs 目录下，clone 到本地后，选择 vivado 打开 mysinglecycle.xpr 这个文件就可以了。

##### 整个 mips 架构图如下
if module

![](./img/if.jpg)

mips module

![](./img/mips.jpg)

### IF module
inst fetch 模块是由 pc,npc,im 三个模块构成，这三个模块共同实现 instruction fetch 的功能。

testbench 测试代码：
```
`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[15:0] imm_16;
    reg[25:0] imm_26;
    reg[1:0]  im_op;
    
    wire[31:0] inst;
    
    inst_fetch MIPS_IF(.rst(rst), .clk(clk), .imm_16(imm_16), .imm_26(imm_26), .op(im_op), .inst(inst));
    
    initial begin
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", MIPS_IF.MIPS_IM.im); // read test inst
        rst = 1;
        clk = 0;
        im_op = 2'b00; // test im_op = NPC_OP_ADD4
        #30 rst = 0;   // reset disable
        #140;
        imm_16 = 'h0002; // test im_op = NPC_OP_IMM16
        im_op = 2'b10;
        #40
        imm_26 = 'h0000005; // test im_op = NPC_OP_IMM26
        im_op = 2'b01;
        #40
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule

```

### extend module
测试代码
```
`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[15:0] imm_16;
    reg[1:0]  ext_op;
    wire[31:0] extout;
    extend ext(.imm_16(imm_16), .ext_op(ext_op), .dout(extout));

    initial begin
        rst = 1;
        clk = 0;
        
        ext_op = 2'b00;
        imm_16 = 16'h0017;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        
        #10;
        ext_op = 2'b00;
        imm_16 = 16'hf113;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        
        #10;
        ext_op = 2'b00;
        imm_16 = 16'h0000;
        #10 ext_op = 2'b01;
        #10 ext_op = 2'b10;
        #10;
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule

```
工作正常。

### mux module
测试代码
```
`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[1:0] sel;
    reg[4:0] in1,in2,in3,in4;
    wire[4:0] out;
    
    mux_4_5 mux(.in1(in1), .in2(in2), .in3(in3), .sel(sel), .out(out));

    initial begin
        rst = 1;
        clk = 0;
        in1 = 5'b00001;
        in2 = 5'b00010;
        in3 = 5'b00011;
        in4 = 5'b00100;
        sel = 2'b00;
        #10 sel = 2'b01;
        #10 sel = 2'b10;
        #10 sel = 2'b11;
        #10;
        
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule

```
正常工作，其他两个mux按类似方式检验。

### regfile module
测试代码
```
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

```
工作正常，注意rf的 _$0_ 始终输出 32'h0. 

### alu module
测试代码
```
`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[31:0] A,B;
    wire[31:0] C;
    reg[4:0] s;
    reg[`ALU_CTRL-1:0] alu_ctrl;
    wire beqout;
    
    alu alu(.A(A), .B(B), .alu_ctrl(alu_ctrl), .s(s), .C(C), .beqout(beqout));
    initial begin
        rst = 1;
        clk = 0;
        A = 32'h001f;
        B = 32'h0001;
        s = 5'h3;
        alu_ctrl = 3'b000;
        #10
        B = 32'h001f;
        alu_ctrl = 3'b001;
        #10
        B = 32'h002a;
        alu_ctrl = 3'b100;
        #10
        alu_ctrl = 3'b101;
        #10
        alu_ctrl = 3'b010;
        #10
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule

```
正常工作。

### dm module
测试代码
```
`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    
    reg[31:0] addr;
    reg[31:0] wdata;
    reg wen;
    
    wire[31:0] dout;
    dm dm(.addr(addr[11:2]), .wdata(wdata), .w_en(wen), .clk(clk), .dout(dout));
    
    initial begin
        rst = 1;
        clk = 0;
        $readmemh("/home/silvester/project/mysinglecycle/instfile.txt", dm.dm);
        addr = 32'h00000004;
        wdata = 32'h00abcdef;
        wen = 0;
        # 10 addr = 32'h00000018;
        wen = 1;
        #30
        $stop;
    end
    
    always
        #20 clk = ~clk; // colck
endmodule

```
正常工作。

### addiu 指令测试代码
```
addiu $10,$0,0x0001          00100100 00001010 00000000 00000001      0x240a0001
addiu $11,$10,0x0010         00100101 01001011 00000000 00010001      0x254b0010
addiu $10,$11,0xffff         00100101 01101010 11111111 11111111      0x256affff
```
### add 指令测试代码
```
addiu $10,$0,0xb             00100100 00001010 00000000 00001011      0x240a000b
addiu $11,$0,0x5             00100100 00001011 00000000 00000101      0x240b0005
add   $12,$10,$11            00000001 01001011 01100000 00100000      0x014b6020
add   $13,$12,$10            00000001 10001010 01101000 00100000      0x018a6820
```
### sub 指令
```
addiu $10,$0,0x0009          00100100 00001010 00000000 00001001      0x240a0009
addiu $11,$0,0x0003          00100100 00001011 00000000 00000011      0x240b0003
sub $12,$10,$11              00000001 01001011 01100000 00100010      0x014b6022
sub $11,$12,$10              00000001 10001010 01011000 00100010      0x018a5822
```
### sll 指令
```
addiu $10,$0,0xb             00100100 00001010 00000000 00001011      0x240a000b
addiu $11,$0,0x5             00100100 00001011 00000000 00000101      0x240b0005
sll $12,$10,2                00000000 00001010 01100000 10000000      0x000a6080
sll $12,$11,4                00000000 00001011 01100001 00000000      0x000b6100
```
### and 指令
```
addiu $10,$0,0xb             00100100 00001010 00000000 00001011      0x240a000b
addiu $11,$0,0x5             00100100 00001011 00000000 00000101      0x240b0005
and $12,$10,$11              00000001 01001011 01100000 00100100      0x014b6024
```
### lui 指令
```
lui $10,1                    00111100 00001010 00000000 00000001      0x3c0a0001
lui $11,5                    00111100 00001011 00000000 00000101      0x3c0b0005
add $12,$11,$10              00000001 01101010 01100000 00100000      0x016a6020
```
### beq 指令
```
addiu $10,$0,5               00101000 00001010 00000000 00000101      0x240a0005
addiu $11,$0,5               00101000 00001011 00000000 00000101      0x240b0005
beq $10,$11,1                00010001 01001011 00000000 00000001      0x114b0001
add $12,$10,$11              00000001 01001011 01100000 00100000      0x014b6020
sub $12,$10,$11              00000001 01001011 01100000 00100010      0x014b6022
```
### ori 指令
```
addiu $10,$0,0xb             00100100 00001010 00000000 00001011      0x240a000b
ori $11,$10,0xfff5           00110101 01001011 11111111 11110101      0x354bfff5
```
### sw 指令
```
addiu $10,$0,0x0009          00100100 00001010 00000000 00001001      0x240a0009
sw $10,4($0)                 10101100 00001010 00000000 00000100      0xac0a0004
sw $0,3($10)                 10101101 01000000 00000000 00000011      0xad400003
```
### lw 指令
```
addiu $10,$0,0x0009          00100100 00001010 00000000 00001001      0x240a0009
sw $10,4($0)                 10101100 00001010 00000000 00000100      0xac0a0004
sw $0,3($10)                 10101101 01000000 00000000 00000011      0xad400003
lw $11,4($0)                 10001100 00001011 00000000 00000100      0x8c0b0004
lw $12,3($10)                10001101 01001100 00000000 00000011      0x8d4c0003
```
### j 指令
```
j 0x4                        00001000 00000000 00000000 00000100      0x08000004
addiu $10,$0,1               00101000 00001010 00000000 00000001      0x240a0001
addiu $10,$0,2               00101000 00001010 00000000 00000010      0x240a0002
addiu $10,$0,3               00101000 00001010 00000000 00000011      0x240a0003
addiu $10,$0,4               00101000 00001010 00000000 00000100      0x240a0004
addiu $11,$10,5              00101001 01001011 00000000 00000101      0x254b0005
```
# jal 指令
```
jal 0x4                      00001100 00000000 00000000 00000100      0x0c000004
addiu $10,$0,1               00101000 00001010 00000000 00000001      0x240a0001
addiu $10,$0,2               00101000 00001010 00000000 00000010      0x240a0002
addiu $10,$0,3               00101000 00001010 00000000 00000011      0x240a0003
addiu $10,$0,4               00101000 00001010 00000000 00000100      0x240a0004
addiu $11,$10,5              00101001 01001011 00000000 00000101      0x254b0005
```
jal 和 j 差别不大，就是指令操作码差1位。

具体各模块代码详见 srcs 目录下文件。以上只给出测试代码，在验证的时候就看vivado输出吧，符合预期就OK。
