module alu32(

input [15:0] a,
input [15:0] b,
input [2:0] aluOp,

output [15:0] out

);

wire [15:0] add_res, sub_res, and_res, or_res, slt_res, mult_res;

assign add_res = a + b;
assign sub_res = a - b;
assign and_res = a & b;
assign or_res = a | b;
assign slt_res = (a < b) ? 16'b1 : 16'b0;
assign mult_res = a * b;

assign out = (aluOp == 3'b000) ? add_res :
    (aluOp == 3'b001) ? sub_res :
    (aluOp == 3'b010) ? and_res :
    (aluOp == 3'b011) ? or_res :
    (aluOp == 3'b100) ? slt_res :
    (aluOp == 3'b101) ? mult_res :
    16'b0;


endmodule

