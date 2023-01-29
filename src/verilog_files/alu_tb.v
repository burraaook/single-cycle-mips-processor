module alu_tb();
// test bench for alu.v

reg [15:0] a;
reg [15:0] b;
reg [2:0] aluOp;
reg [3:0] shamt;

wire [15:0] out;
wire zero;

alu alu1(
    .a(a),
    .b(b),
    .aluOp(aluOp),
    .shamt(shamt),
    .out(out),
    .zero(zero)
);

initial begin
    // numbers
    a = 16'b0111_0011_0010_0101;
    b = 16'b0100_1001_0100_0001;

    // add
    aluOp = 3'b010;
    #2

    // sub
    aluOp = 3'b110;
    #2

    // and
    aluOp = 3'b000;
    #2

    // or
    aluOp = 3'b001;
    #2

    // slt
    aluOp = 3'b111;
    #2

    // zero
    a = 16'b0000_0000_0000_0000;
    b = 16'b0000_0000_0000_0000;
    aluOp = 3'b010;
    #2

    // sll
    b = 16'b0101_1001_0100_0001;
    shamt = 4'b0010;
    aluOp = 3'b100;
    #2

    // srl
    b = 16'b0101_1001_0100_0001;
    shamt = 4'b0010;
    aluOp = 3'b101;
    #2

	$stop;
end
endmodule
