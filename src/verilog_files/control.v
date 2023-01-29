module control(

input [5:0] opcode,
input [5:0] func,
output reg regDst, aluSrc, memToReg, regWrite, 
		memRead, memWrite, branch, branchNot, jumpAndLink, jumpReg, jump, loadImm,

output reg [2:0] aluOp

);

// op codes
wire r_type, lw, sw, beq, jal, j, addi, andi, ori, slti, li, bne;

// function codes for r type
wire add_f, sub_f, and_f, or_f, slt_f, mult_f, jr_f, sll_f, srl_f;

wire [2:0] aluOp_w;

// r type = 000000
assign r_type = ~opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0];

// lw = 100011
assign lw = opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0];

// sw = 101011
assign sw = opcode[5] & ~opcode[4] & opcode[3] & ~opcode[2] & opcode[1] & opcode[0];

// beq = 000100
assign beq = ~opcode[5] & ~opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1] & ~opcode[0];

// bne = 000101
assign bne = ~opcode[5] & ~opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1] & opcode[0];

// jal = 000011
assign jal = ~opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0];

// j = 000010
assign j = ~opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & ~opcode[0];

// addi = 001000
assign addi = ~opcode[5] & ~opcode[4] & opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0];

// andi = 001100
assign andi = ~opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & ~opcode[1] & ~opcode[0];

// ori = 001101
assign ori = ~opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & ~opcode[1] & opcode[0];

// slti = 001010
assign slti = ~opcode[5] & ~opcode[4] & opcode[3] & ~opcode[2] & opcode[1] & ~opcode[0];

// li = 001111
assign li = ~opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & opcode[1] & opcode[0];

// jr = func = 001000
assign jr_f = ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];

// add = func = 100000
assign add_f = func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];

// sub = func = 100010
assign sub_f = func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];

// and = func = 100100
assign and_f = func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];

// or = func = 100101
assign or_f = func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0];

// slt = func = 101010
assign slt_f = func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];

// mult = func = 011000
assign mult_f = ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];

// sll = func = 000000
assign sll_f = ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];

// srl = func = 000010
assign srl_f = ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];

always @(*)
begin
	regDst = 0;
	aluSrc = 0;
	memToReg = 0;
	regWrite = 0;
	memRead = 0;
	memWrite = 0;
	branch = 0;
	branchNot = 0;
	jumpAndLink = 0;
	jumpReg = 0;
	jump = 0;
	aluOp = 3'b010;
	loadImm = 0;
	
	if (r_type)
	begin
		regDst = 1;
		regWrite = 1;

		if (and_f)
			aluOp = 3'b000;
		else if (sub_f)
			aluOp = 3'b110;
		else if (add_f)
			aluOp = 3'b010;
		else if (or_f)
			aluOp = 3'b001;
		else if (slt_f)
			aluOp = 3'b111;
		else if (mult_f)
			aluOp = 3'b011;
		else if (jr_f)
		begin
			jumpReg = 1;
			regWrite = 0;
		end
		else if (sll_f)
			aluOp = 3'b100;

		else if (srl_f)
			aluOp = 3'b101;
	end

	else if (lw)
	begin
		aluSrc = 1;
		memToReg = 1;
		regWrite = 1;
		memRead = 1;
		aluOp = 3'b010;
	end

	else if (sw)
	begin
		aluSrc = 1;
		memWrite = 1;
		aluOp = 3'b010;
	end

	else if (beq)
	begin
		branch = 1;
		aluOp = 3'b110;
	end

	else if (bne)
	begin
		branchNot = 1;
		aluOp = 3'b110;
	end

	else if (jal)
	begin
		jumpAndLink = 1;
		regWrite = 1;
	end

	else if (j)
		jump = 1;

	else if (addi)
	begin
		aluOp = 3'b010;
		aluSrc = 1;
		regWrite = 1;
	end

	else if (andi)
	begin
		aluOp = 3'b000;
		aluSrc = 1;
		regWrite = 1;
	end

	else if (ori)
	begin
		aluOp = 3'b001;
		aluSrc = 1;
		regWrite = 1;
	end

	else if (slti)
	begin
		aluOp = 3'b111;
		aluSrc = 1;
		regWrite = 1;
	end

	else if (li)
	begin
		loadImm = 1;
		regWrite = 1;
	end
end

endmodule

