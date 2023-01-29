module data_memory(
// data memory, 2^16 words, 16 bits each
input clock,
input [15:0] address,
input [15:0] write_data,
input memWrite,
input memRead,
output reg [15:0] read_data
);

reg [15:0] memory [0:65535];

always @ (posedge clock) begin
	if (memWrite) begin
		memory[address] <= write_data;
	end
end

always @ (*) begin
	if (memRead) begin
		read_data <= memory[address];
	end
end

endmodule