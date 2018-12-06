# mips 单周期个人设计
相比之前的单周期项目，本项目实现自行设计数据通路，并且更加规范的编写代码，实现更多指令。之前的那个是参考老师给的示例代码进行练手的。

所有代码在 mysinglecycle.srcs 目录下，clone 到本地后，选择 vivado 打开 mysinglecycle.xpr 这个文件就可以了。

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

具体各模块代码详见 srcs 目录下文件。
