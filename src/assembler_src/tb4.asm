li $1, 511
sw $1, 0($0)
lw $2, 0($0)
addi $3, $2, $1
sw $3, 10($0)
li $4, 0
li $5, 10
addi $4, $4, 1
beq $4, $5, 2
sw $4, 4($4)
j 7
li $6, 1
lw $7, 4($6)
addi $7, $7, 1
slt $8, $7, $5
bne $8, $0, 1
j 12
sub $9, $6, $4