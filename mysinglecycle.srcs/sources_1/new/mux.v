/**
* muxs module
*/
module mux_2_32(
    input wire[31:0] in1,in2,
    input wire       sel,
    
    output reg[31:0] out
    );
    
    always @ (*) begin
        case (sel)
            1'b0 : out <= in1;
            1'b1 : out <= in2;
        endcase
    end
endmodule

module mux_4_5(
    input wire[4:0] in1,in2,in3,
    input wire[1:0] sel,
    
    output reg[4:0] out
    );
    
    always @ (*) begin
        case (sel)
            2'b00 : out <= in1;
            2'b01 : out <= in2;
            2'b10 : out <= in3;
            default : out <= 5'b11111;
        endcase
    end
endmodule

module mux_4_32(
    input wire[31:0] in1,in2,in3,in4,
    input wire[1:0]  sel,
    
    output reg[31:0] out
    );
    
    always @ (*) begin
        case (sel)
            2'b00 : out <= in1;
            2'b01 : out <= in2;
            2'b10 : out <= in3;
            2'b11 : out <= in4;
            default : out <= 32'h00000000;
        endcase
    end
endmodule
