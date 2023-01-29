module registers_tb();
// test bench for registers.v

reg clk = 1'b0;
reg [3:0] read_reg1;
reg [3:0] read_reg2;
reg [3:0] write_reg;
reg [15:0] write_data;
reg regWrite;

wire [15:0] read_data1;
wire [15:0] read_data2;

registers regs(
    .clk(clk),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data),
    .regWrite(regWrite),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

always begin
    #2 clk = ~clk;
end

initial begin

    // write to register 0
    write_reg = 4'b0000;
    write_data = 16'b0000_0000_0000_0001;
    regWrite = 1'b1;
    #5

    // write to register 1
    write_reg = 4'b0001;
    write_data = 16'b0000_0000_0000_0010;
    #5
    regWrite = 1'b0;

    // read from register 0 and 1
    read_reg1 = 4'b0000;
    read_reg2 = 4'b0001;
    #5

    // write to register 15
    write_reg = 4'b1111;
    write_data = 16'b0000_0000_0000_1111;
    regWrite = 1'b1;
    #5
    regWrite = 1'b0;

    // read from register 15
    read_reg1 = 4'b1111;
    read_reg2 = 4'b0000;
    #5

    // write to register 0
    write_reg = 4'b0000;
    write_data = 16'b0000_0000_0000_0000;
    regWrite = 1'b1;
    #5
    regWrite = 1'b0;

    $stop;
end
endmodule
