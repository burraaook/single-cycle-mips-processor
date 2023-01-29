module registers(

input clk,
input [3:0] read_reg1,
input [3:0] read_reg2,
input [3:0] write_reg,
input [15:0] write_data,
input regWrite,

output reg [15:0] read_data1,
output reg [15:0] read_data2

);

// 16 registers
reg [15:0] registers [0:15];

initial begin 
    // register 0 is always 0
    registers[0] = 16'b0000_0000_0000_0000;
end

always @ (posedge clk) begin
    if (regWrite) begin
        registers[write_reg] <= write_data;
    end
end

always @ (*) begin
    read_data1 = registers[read_reg1];
    read_data2 = registers[read_reg2];
end



endmodule

