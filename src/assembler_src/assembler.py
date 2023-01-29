# converts mips assembly code to machine code
# input file: program.asm
# output file: program.mem
# instructions are 32 bits
# r type: 6 opcode, 4 rs, 4 rt, 4 rd, 4 shamt, 6 funct, 0000
# i type: 6 opcode, 4 rs, 4 rt, 16 immediate, 00
# j type: 6 opcode, 10 address, 0000000000000000

# instruction set
# r types:
# add $1, $2, $3 -> opcode: 000000, rs: 0010, rt: 0011, rd: 0001, shamt: 00000, funct: 100000
# sub $1, $2, $3 -> opcode: 000000, rs: 0010, rt: 0011, rd: 0001, shamt: 00000, funct: 100010
# and $1, $2, $3 -> opcode: 000000, rs: 0010, rt: 0011, rd: 0001, shamt: 00000, funct: 100100
# or $1, $2, $3 -> opcode: 000000, rs: 0010, rt: 0011, rd: 0001, shamt: 00000, funct: 100101
# slt $1, $2, $3 -> opcode: 000000, rs: 0010, rt: 0011, rd: 0001, shamt: 00000, funct: 101010
# sll $1, $2, 3 -> opcode: 000000, rs: 0000, rt: 0010, rd: 0001, shamt: 00011, funct: 000000
# srl $1, $2, 3 -> opcode: 000000, rs: 0000, rt: 0010, rd: 0001, shamt: 00011, funct: 000010
# jr $1 -> opcode: 000000, rs: 0001, rt: 0000, rd: 0000, shamt: 00000, funct: 001000

# i types:
# addi $1, $2, 3 -> opcode: 001000, rs: 0010, rt: 0001, immediate: 0000000000000011
# andi $1, $2, 3 -> opcode: 001100, rs: 0010, rt: 0001, immediate: 0000000000000011
# ori $1, $2, 3 -> opcode: 001101, rs: 0010, rt: 0001, immediate: 0000000000000011
# slti $1, $2, 3 -> opcode: 001010, rs: 0010, rt: 0001, immediate: 0000000000000011
# lw $1, 3($2) -> opcode: 100011, rs: 0010, rt: 0001, immediate: 0000000000000011
# sw $1, 3($2) -> opcode: 101011, rs: 0010, rt: 0001, immediate: 0000000000000011
# beq $1, $2, 3 -> opcode: 000100, rs: 0001, rt: 0010, immediate: 0000000000000011
# bne $1, $2, 3 -> opcode: 000101, rs: 0001, rt: 0010, immediate: 0000000000000011
# li $1, 3 -> opcode: 001111, rs: 0000, rt: 0001, immediate: 0000000000000011

# j types:
# j 3 -> opcode: 000010, address: 0000000011
# jal 3 -> opcode: 000011, address: 0000000011

# input file consists of instructions above
# output file consists of 32 bit machine code
# each line of output file is one instruction

# example input file:
# add $1, $2, $3
# sub $1, $2, $3
# and $1, $2, $3
# or $1, $2, $3
# example output file:
# 00000000100100110010000000000000
# 00000000100100110010001000000000
# 00000000100100110010010000000000
# 00000000100100110010010100000000


# ----- testbench ----- #
# test for tb
# input_file = open("program.asm", "r")
# output_file = open("instruction_init.mem", "w")

# test for spec1
input_file = open("spec1.asm", "r")
output_file = open("instruction_init_spec1.mem", "w")

# test for spec2
# input_file = open("spec2.asm", "r")
# output_file = open("instruction_init_spec2.mem", "w")

# test for tb1
# input_file = open("tb1.asm", "r")
# output_file = open("instruction_init_tb1.mem", "w")

# test for tb2
# input_file = open("tb2.asm", "r")
# output_file = open("instruction_init_tb2.mem", "w")

# test for tb3
# input_file = open("tb3.asm", "r")
# output_file = open("instruction_init_tb3.mem", "w")

# test for tb4
# input_file = open("tb4.asm", "r")
# output_file = open("instruction_init_tb4.mem", "w")

# test for add_tb
# input_file = open("add_tb.asm", "r")
# output_file = open("instruction_init_add_tb.mem", "w")

# test for sub_tb
# input_file = open("sub_tb.asm", "r")
# output_file = open("instruction_init_sub_tb.mem", "w")

# test for addi_tb
# input_file = open("addi_tb.asm", "r")
# output_file = open("instruction_init_addi_tb.mem", "w")

# test for lw_tb
# input_file = open("lw_tb.asm", "r")
# output_file = open("instruction_init_lw_tb.mem", "w")

# test for sw_tb
# input_file = open("sw_tb.asm", "r")
# output_file = open("instruction_init_sw_tb.mem", "w")

# test for beq_tb
# input_file = open("beq_tb.asm", "r")
# output_file = open("instruction_init_beq_tb.mem", "w")

# test for bne_tb
# input_file = open("bne_tb.asm", "r")
# output_file = open("instruction_init_bne_tb.mem", "w")

# test for slt_tb
# input_file = open("slt_tb.asm", "r")
# output_file = open("instruction_init_slt_tb.mem", "w")

# test for slti_tb
# input_file = open("slti_tb.asm", "r")
# output_file = open("instruction_init_slti_tb.mem", "w")

# test for j_tb
# input_file = open("j_tb.asm", "r")
# output_file = open("instruction_init_j_tb.mem", "w")

# test for jr_tb
# input_file = open("jr_tb.asm", "r")
# output_file = open("instruction_init_jr_tb.mem", "w")

# test for jal_tb
# input_file = open("jal_tb.asm", "r")
# output_file = open("instruction_init_jal_tb.mem", "w")

# test for and_tb
# input_file = open("and_tb.asm", "r")
# output_file = open("instruction_init_and_tb.mem", "w")

# test for or_tb
# input_file = open("or_tb.asm", "r")
# output_file = open("instruction_init_or_tb.mem", "w")

# test for andi_tb
# input_file = open("andi_tb.asm", "r")
# output_file = open("instruction_init_andi_tb.mem", "w")

# test for ori_tb
# input_file = open("ori_tb.asm", "r")
# output_file = open("instruction_init_ori_tb.mem", "w")

# test for sll_tb
# input_file = open("sll_tb.asm", "r")
# output_file = open("instruction_init_sll_tb.mem", "w")

# test for srl_tb
# input_file = open("srl_tb.asm", "r")
# output_file = open("instruction_init_srl_tb.mem", "w")

# ----- testbench ----- #

# read input file
lines = input_file.readlines()

# convert each line to machine code
for line in lines:
    # remove newline character if it exists

    if line[-1] == "\n":
        line = line[:-1]

    # split line into tokens
    tokens = line.split()
    # delete commas, and $ signs
    for i in range(len(tokens)):
        tokens[i] = tokens[i].replace(",", "")
        tokens[i] = tokens[i].replace("$", "")

    print(tokens)
    # r type
    if tokens[0] == "add":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[3]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        shamt = "0000"
        funct = "100000"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")
    
    elif tokens[0] == "sub":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[3]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        shamt = "0000"
        funct = "100010"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")

    elif tokens[0] == "and":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[3]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        shamt = "0000"
        funct = "100100"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")

    elif tokens[0] == "or":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[3]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        shamt = "0000"
        funct = "100101"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")
    
    elif tokens[0] == "sll":
        opcode = "000000"
        # find rs 4 bits
        rs = "0000"
        # find rt 4 bits
        rt = bin(int(tokens[2]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        # find shamt 4 bits
        shamt = bin(int(tokens[3]))[2:]
        shamt = shamt.zfill(4)
        funct = "000000"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")

    elif tokens[0] == "srl":
        opcode = "000000"
        # find rs 4 bits
        rs = "0000"
        # find rt 4 bits
        rt = bin(int(tokens[2]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        # find shamt 4 bits
        shamt = bin(int(tokens[3]))[2:]
        shamt = shamt.zfill(4)
        funct = "000010"
        # print(shamt)
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")

    elif tokens[0] == "jr":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[1]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = "0000"
        # find rd 4 bits
        rd = "0000"
        shamt = "0000"
        funct = "001000"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")
    
    elif tokens[0] == "slt":
        opcode = "000000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[3]))[2:]
        rt = rt.zfill(4)
        # find rd 4 bits
        rd = bin(int(tokens[1]))[2:]
        rd = rd.zfill(4)
        shamt = "0000"
        funct = "101010"
        output_file.write(opcode + rs + rt + rd + shamt + funct + "0000")
        output_file.write("\n")


    # i type
    elif tokens[0] == "addi":
        opcode = "001000"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "li":
        # sample format: li $t0, 10
        opcode = "001111"
        # find rs 4 bits
        rs = "0000"
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[2]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "andi":
        opcode = "001100"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "ori":
        opcode = "001101"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "lw":
        opcode = "100011"
        # tokens2 sample format: 0(1)
        tokens2 = tokens[2].split("(")
        # find rs 4 bits
        rs = bin(int(tokens2[1][:-1]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens2[0]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")
    

    elif tokens[0] == "sw":
        opcode = "101011"
        # tokens2 sample format: 0(1)
        tokens2 = tokens[2].split("(")
        # find rs 4 bits
        rs = bin(int(tokens2[1][:-1]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens2[0]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "beq":
        opcode = "000100"
        # find rs 4 bits
        rs = bin(int(tokens[1]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[2]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "bne":
        opcode = "000101"
        # find rs 4 bits
        rs = bin(int(tokens[1]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[2]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    elif tokens[0] == "slti":
        opcode = "001010"
        # find rs 4 bits
        rs = bin(int(tokens[2]))[2:]
        rs = rs.zfill(4)
        # find rt 4 bits
        rt = bin(int(tokens[1]))[2:]
        rt = rt.zfill(4)
        # find immediate 16 bits
        immediate = bin(int(tokens[3]))[2:]
        immediate = immediate.zfill(16)
        output_file.write(opcode + rs + rt + immediate + "00")
        output_file.write("\n")

    # j type
    elif tokens[0] == "j":
        opcode = "000010"
        # find address 10 bits
        address = bin(int(tokens[1]))[2:]
        address = address.zfill(10)
        output_file.write(opcode + address + "0000000000000000")
        output_file.write("\n")

    elif tokens[0] == "jal":
        opcode = "000011"
        # find address 10 bits
        address = bin(int(tokens[1]))[2:]
        address = address.zfill(10)
        output_file.write(opcode + address + "0000000000000000")
        output_file.write("\n")

    else:
        print("Error: Invalid instruction")
        print(tokens[0])
output_file.close()
