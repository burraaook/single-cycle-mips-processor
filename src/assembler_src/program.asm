li $1, 12
li $2, 15
add $3, $1, $2
sub $4, $2, $1
slt $5, $1, $2
li $6, 0
addi $1, $1, 1
beq $5, $6, 1
j 3
sw $1, 0($3)
lw $6, 0($3)
add $7, $6, $4