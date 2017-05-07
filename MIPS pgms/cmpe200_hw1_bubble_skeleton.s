# CMPE200 HW1
# Fall 2016
# Bubble Sort
# This program sorts a list of n elements

	.data
list: 	.word 15, 20, 9, 8, 7, 6, 5, 3, 10, 2 	# An example list; your code will be tested with different lists
n: 	.word 10							# An example list length; your code will be tested with different size lists

nline:	.asciiz "\n"					# Define new line string
space:	.asciiz " "					# Define space string
msga:	.asciiz "Input list is: \n"
msgb:	.asciiz "The sorted list is : \n"

	.text
	.globl main

main:
	la 	$s0, n			# Get address of variable n
	lw 	$s0, 0($s0)		# Get value of n	
	la 	$s1, list			# Get address of input list
	
	la	$a0, msga			
	la 	$a1, list
	jal	PRINT			# Call PRINT with two arguments, msga and list

# Your CODE HERE
	






# End CODE

	la	$a0, msgb			
	la 	$a1, list
	jal	PRINT			# Call PRINT with two arguments, msgb and list
	
	li	 $v0,10			# Exit
    	syscall
    	

PRINT:
	li	$v0, 4
	syscall					# Print an input message in $a0
	add $a2, $0, $0		
  PRINT_L: 		
	li	$v0,1
	lw	$a0,0($a1)
	syscall					# Print the element in list[i]
	la	$a0, space	
	li	$v0, 4
	syscall					#	Print a space
	addi $a2, $a2, 1
	addi $a1, $a1, 4
	blt 	$a2, $s0, PRINT_L	# for (int i = 0; i < N; i++)	
	
	la	$a0, nline
	li	$v0, 4
	syscall					#     Print "\n"
	jr	$ra

		

