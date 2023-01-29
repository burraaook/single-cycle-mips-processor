module instruction_memory_tb();
// test bench for instruction_memory.v

reg clock = 1'b0;
reg [31:0] data;
reg [9:0] rdaddress;
reg [9:0] wraddress;
reg wren = 1'b0;

wire [31:0] q;

instruction_memory inst(
    .clock(clock),
    .data(data),
    .rdaddress(rdaddress),
    .wraddress(wraddress),
    .wren(wren),
    .q(q)
);

always begin
    #2 clock = ~clock;
end

initial begin

    $readmemb("instruction_init.mem", inst.memory);

    // test initialization
    #50

    // write to output file
    $writememb("instructions.txt", inst.memory);
    $stop;
end

endmodule
