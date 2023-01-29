module single_cycle_mips_spec2tb();
// special testbench 1 for single_cycle_mips.v

reg clock = 1'b0;

single_cycle_mips processor(clock);

always begin
	#2 clock = ~clock;
end

initial begin
	// initialize instruction memory from mem file
	$readmemb("instruction_init_spec2.mem", processor.inst_mem.memory);
	
	#205

    // write registers to file
    $writememb("registers.txt", processor.regs.registers);

    // write memory to file
    $writememb("data_memory.txt", processor.data_mem.memory);

	// write instructions to file
	$writememb("instructions.txt", processor.inst_mem.memory);

	$stop;
end

endmodule
