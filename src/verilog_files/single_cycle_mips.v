module single_cycle_mips(

input clk

);

// program counter 10 bit
reg [9:0] pc;

initial begin
    pc = 10'b0;
end

wire regWrite, memRead, memWrite, memToReg, regDst, branch, branchNot, jumpAndLink, jumpReg, jump, aluSrc, loadImm;
wire alu_zero, branch_w;
wire [31:0] instruction;
wire [2:0] aluOp;
wire [3:0] write_reg_w, write_reg, read_reg1, read_reg2;
wire [15:0] alu_res, alu_b, alu_a, read_data_mem, write_back, read_data1, read_data2, write_data, immediate;
wire [9:0] next_pc, branch_addr, inc_pc;
wire [5:0] opcode;
wire [5:0] func;
wire [3:0] shamt;
wire [9:0] jump_addr;

assign opcode = instruction[31:26];
assign func = instruction[9:4];
assign shamt = instruction[13:10];
assign immediate = instruction[17:2];
assign jump_addr = instruction[25:16];

instruction_memory inst_mem(
    .clock(clk),
    .data(),
    .rdaddress(pc),
    .wraddress(),
    .wren(1'b0),
    .q(instruction)
);

// main controller, control.v
control main_control(
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

// rd or rt
assign write_reg_w = regDst ? instruction[17:14] : instruction[21:18];

// jal
assign write_reg = jumpAndLink ? 4'b1111 : write_reg_w;


assign read_reg1 = instruction[25:22];
assign read_reg2 = instruction[21:18];

// registers, registers.v
registers regs(
    .clk(clk),
    .write_reg(write_reg),
    .write_data(write_back),
    .regWrite(regWrite),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

assign alu_b = aluSrc ? immediate : read_data2;
assign alu_a = read_data1;
// alu, alu.v
alu alu(
    .aluOp(aluOp),
    .a(alu_a),
    .b(alu_b),
    .shamt(shamt),
    .out(alu_res),
    .zero(alu_zero)
);

assign write_data = read_data2;
// data memory, data_memory.v
data_memory data_mem(
    .clock(clk),
    .address(alu_res),
    .write_data(write_data),
    .read_data(read_data_mem),
    .memRead(memRead),
    .memWrite(memWrite)
);

assign branch_w = (branch & alu_zero) | (branchNot & ~alu_zero);

assign inc_pc = pc + 10'd1;
assign branch_addr = inc_pc + instruction[11:2];

assign write_back = memToReg ? read_data_mem : (loadImm ? immediate : (jumpAndLink ? inc_pc : alu_res));

assign next_pc = jump ? jump_addr : (branch_w ? branch_addr : (jumpReg ? read_data1[9:0] : (jumpAndLink ? jump_addr : inc_pc)));

always @(posedge clk) begin
    pc <= next_pc;
end


endmodule

