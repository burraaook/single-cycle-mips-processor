module instruction_memory(
// instruction memory, 2^10 words, 32 bits each
input clock,
input [31:0] data,
input [9:0] rdaddress,
input [9:0] wraddress,
input wren,
output reg [31:0] q
);

reg [31:0] memory [0:1023];

// initial begin
// // initialize instruction memory from mem file
// $readmemb("instruction_init.mem", memory);
// end

always @ (posedge clock) begin
	if (wren) begin
		memory[wraddress] <= data;
	end
end

always @ (*) begin
	q <= memory[rdaddress];
end

endmodule

