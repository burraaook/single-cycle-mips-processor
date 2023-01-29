module data_memory_tb();
// test bench for data_memory.v

reg clk = 1'b0;
reg [15:0] address;
reg [15:0] write_data;
reg memWrite;
reg memRead;

wire [15:0] read_data;

always begin
    #2 clk = ~clk;
end

data_memory mem(
    .clock(clk),
    .address(address),
    .write_data(write_data),
    .memWrite(memWrite),
    .memRead(memRead),
    .read_data(read_data)
);

initial begin

    // write to memory address 0
    address = 16'b0000_0000_0000_0000;
    write_data = 16'b0000_0000_0000_0001;
    memWrite = 1'b1;
    #5
    memWrite = 1'b0;

    // read from memory address 0
    memRead = 1'b1;
    #5

    // write to memory address 1
    address = 16'b0000_0000_0000_0001;
    write_data = 16'b0000_0000_0000_0010;
    memWrite = 1'b1;
    #5
    memWrite = 1'b0;

    // read from memory address 1
    memRead = 1'b1;
    #5
    
    // write to memory address 25
    address = 16'b0000_0000_0001_1001;
    write_data = 16'b0000_0000_0001_1001;
    memWrite = 1'b1;
    #5
    memWrite = 1'b0;

    // read from memory address 25
    memRead = 1'b1;
    #5

    // write to memory address 25
    address = 16'b0000_0000_0001_1001;
    write_data = 16'b0000_0000_0001_1001;
    memWrite = 1'b1;
    #5
    memWrite = 1'b0;

    // read from memory address 25
    memRead = 1'b1;
    #5

    // write to memory address 65535
    address = 16'b1111_1111_1111_1111;
    write_data = 16'b1111_1111_1111_1111;
    memWrite = 1'b1;
    #5

    // read from memory address 65535
    memRead = 1'b1;
    #5

    $stop;

end




endmodule
