li  $a0,4
 la  $a1,0x80000C
#la $ra,0x40000 
#la $sp,0x7fffeffc


sum: addi $sp, $sp, -12
addi $t0, $a0, -1
sw $t0, 0($sp)
sw $ra, 4($sp)
bge $t0, $zero, ELSE2
li $v0, 0
addi $sp, $sp, 12
jr $ra
ELSE2: addi $t7, $zero, 4
mul $t1, $t0, $t7
add $t1, $t1, $a1
lw $t2, 0($t1)
andi $t3, $t2, 1
beq $t3, $zero, ELSE3
sw $t2, 8($sp)
move $a0, $t0
jal sum
lw $t2, 8($sp)
add $v0, $v0, $t2
lw $ra, 4($sp)
addi $sp, $sp, 12
jr $ra
ELSE3: move $a0, $t0
jal sum
lw $ra, 4($sp)
addi $sp, $sp, 12
jr $ra
