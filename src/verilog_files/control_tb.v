module control_tb();
// test bench for control.v

reg [5:0] func;
reg [5:0] opcode;

wire [2:0] aluOp;
wire regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, branchNot, jumpAndLink, jumpReg, jump, loadImm;

control control1(
    .opcode(opcode),
    .func(func),
    .regDst(regDst),
    .aluSrc(aluSrc),
    .memToReg(memToReg),
    .regWrite(regWrite),
    .memRead(memRead),
    .memWrite(memWrite),
    .branch(branch),
    .branchNot(branchNot),
    .jumpAndLink(jumpAndLink),
    .jumpReg(jumpReg),
    .jump(jump),
    .loadImm(loadImm),
    .aluOp(aluOp)
);

initial begin
    // r type, and
    opcode = 6'b000000;
    func = 6'b100100;
    #10

    // r type, sub
    opcode = 6'b000000;
    func = 6'b100010;
    #10

    // r type, add
    opcode = 6'b000000;
    func = 6'b100000;
    #10

    // r type, or
    opcode = 6'b000000;
    func = 6'b100101;
    #10

    // r type, slt
    opcode = 6'b000000;
    func = 6'b101010;
    #10

    // r type, mult
    opcode = 6'b000000;
    func = 6'b011000;
    #10

    // r type, jr
    opcode = 6'b000000;
    func = 6'b001000;
    #10

    // lw
    opcode = 6'b100011;
    #10

    // sw
    opcode = 6'b101011;
    #10

    // beq
    opcode = 6'b000100;
    #10

    // j
    opcode = 6'b000010;
    #10

    // jal
    opcode = 6'b000011;
    #10

    // addi
    opcode = 6'b001000;
    #10

    // andi
    opcode = 6'b001100;
    #10

    // ori
    opcode = 6'b001101;
    #10

    // slti
    opcode = 6'b001010;
    #10

    // bne
    opcode = 6'b000101;
    #10

    // sll
    opcode = 6'b000000;
    func = 6'b000000;
    #10

    // srl
    opcode = 6'b000000;
    func = 6'b000010;
    #10
    
    // li
    opcode = 6'b001111;
    #10

    $stop;
end

 

endmodule

