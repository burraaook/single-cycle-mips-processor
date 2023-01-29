li $1, 15
li $2, 20
li $3, 0
beq $1, $2, 3
addi $3, $3, 1
addi $1, $1, 1
j 3
slti $4, $3, 6
bne $4, $0, 1
add $6, $1, $2
sub $7, $1, $2