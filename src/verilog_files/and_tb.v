module and_tb();

reg clock = 1'b0;

single_cycle_mips processor(clock);

always begin
	#2 clock = ~clock;
end

initial begin
	// initialize instruction memory from mem file
	$readmemb("instruction_init_and_tb.mem", processor.inst_mem.memory);
	
	#16

    // write registers to file
    $writememb("registers.txt", processor.regs.registers);

    // write memory to file
    $writememb("data_memory.txt", processor.data_mem.memory);

	// write instructions to file
	$writememb("instructions.txt", processor.inst_mem.memory);

	$stop;
end

initial begin

    $monitor("\nclock = %1b\nPC= %10b\ninstruction = %32b\nopcode = %6b\nRegDst = %1b, RegWrite = %1b, MemWrite = %1b, memToReg = %1b, branch = %1b\nbranchNot = %1b, jumpAndLink = %1b, jumpReg = %1b, jump = %1b, aluSrc = %1b, loadImm = %1b\nalu_a = %16b\nalu_b = %16b\nalu_res = %16b\nalu_zero = %1b\nalu_op = %3b\nread_reg1 = %4b, read_reg2 = %4b, write_reg = %4b\nread_data1 = %16b\nread_data2 = %16b\nwrite_back = %16b\n-----\n", 
		clock, processor.pc, processor.instruction, processor.opcode, processor.regDst, 
		processor.regWrite, processor.memWrite, processor.memToReg, processor.branch, 
		processor.branchNot, processor.jumpAndLink, processor.jumpReg, processor.jump, 
		processor.aluSrc, processor.loadImm, processor.alu_a, processor.alu_b, 
		processor.alu_res, processor.alu_zero, processor.aluOp, processor.read_reg1, processor.read_reg2, 
		processor.write_reg, processor.read_data1, processor.read_data2, processor.write_back);

end
endmodule
