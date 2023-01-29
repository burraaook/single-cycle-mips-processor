module alu(

input [15:0] a,
input [15:0] b,
input [2:0] aluOp,
input [3:0] shamt,

output [15:0] out,
output zero
);

wire [15:0] add_res, sub_res, and_res, or_res, slt_res, mult_res, sll_res, srl_res;

assign add_res = a + b;
assign sub_res = a - b;
assign and_res = a & b;
assign or_res = a | b;
assign slt_res = (a < b) ? 16'b1 : 16'b0;
assign mult_res = a * b;
assign sll_res = b << shamt;
assign srl_res = b >> shamt;

assign out = (aluOp == 3'b000) ? and_res :
    (aluOp == 3'b001) ? or_res :
    (aluOp == 3'b010) ? add_res :
    (aluOp == 3'b110) ? sub_res :
    (aluOp == 3'b111) ? slt_res :
    (aluOp == 3'b011) ? mult_res :
    (aluOp == 3'b100) ? sll_res:
    (aluOp == 3'b101) ? srl_res:
    16'b0;
assign zero = (out == 16'b0) ? 1'b1 : 1'b0;

endmodule

