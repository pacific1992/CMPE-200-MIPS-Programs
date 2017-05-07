# Traditional Matrix Multiply program
		.data
matrix_a:
		.word   1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12
		.word  13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
		.word  25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36
		.word  37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48
		.word  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
		.word  61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
		.word  73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
		.word  85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96
		.word  97, 98, 99,100,101,102,103,104,105,106,107,108
		.word 109,110,111,112,113,114,115,116,117,118,119,120
		.word 121,122,123,124,125,126,127,128,129,130,131,132
		.word 133,134,135,136,137,138,139,140,141,142,143,144

matrix_b:
		.word 133,134,135,136,137,138,139,140,141,142,143,144
		.word 121,122,123,124,125,126,127,128,129,130,131,132
		.word 109,110,111,112,113,114,115,116,117,118,119,120
		.word  97, 98, 99,100,101,102,103,104,105,106,107,108
		.word  85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96
		.word  73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
		.word  61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
		.word  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
		.word  37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48
		.word  25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36
		.word  13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
		.word   1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12

matrix_c:
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0

bs:		.word 3
n:		.word 12

nline:  .asciiz "\n"				#Define new line string
sp:		.asciiz " "
msga: 	.asciiz "Matrix A is: \n"
msgb: 	.asciiz "Matrix B is: \n"
msgc: 	.asciiz "Matrix C=A*B is: \n"

		.text
		.globl main
main:

		la	$s0, bs	
		lw	$s0, 0($s0)
		la	$s1, n
		lw	$s1, 0($s1)
		la	$s2, matrix_a
		la	$s3, matrix_b
		la	$s4, matrix_c

		la	$a0, msga
		la 	$a1, matrix_a
		jal	PRINT_MAT 
		la	$a0, msgb
		la 	$a1, matrix_b
		jal	PRINT_MAT 

# Your CODE HERE
		#===============================================================
		#===============================================================

		# Charles MacDonald
		# Homework #1
		# Takes 24,289 instructions to complete.
		
		# Constants
		.eqv	EL_SIZE		4	# Number of bytes per matrix element (4)
		.eqv	EL_SIZE_BITS	2	# Number of bits corresponding to element size (2^2=4)

		# Register names
		.eqv	dim		$t0	# Matrix dimension 
		.eqv	row_size	$t1	# Matrix row size in bytes
		.eqv	mat_size	$t2	# Matrix size in byts
		.eqv	row		$t3	# Row loop count
		.eqv	column		$t4	# Column loop count
		.eqv	z		$t5	# Z loop count
		.eqv	a_index		$t6	# Matrix A index
		.eqv	b_index		$t7	# Matrix B index
		.eqv	c_index		$t8	# Matrix C index
		.eqv	a_temp		$t9	# Matrix A data 
		.eqv	b_temp		$a0	# Matrix B data
		.eqv	mac_result	$a1	# Accumulator for matrix products
	
		# Get matrix dimension
		la	a_temp, n
		lw	dim, 0(a_temp)

		# Get addresses of matrices
		#
		# I'm assuming we cannot rely on the fact the matrices are
		# stored in order, sequentially, in the data section.
		#
		# Otherwise these three loads could be shortened to take
		# advantage of that fact.
		#
		la	a_index, matrix_a
		la	b_index, matrix_b
		la	c_index, matrix_c
		
		# Calculate row size (row_size = DIM * EL_SIZE)
		# This is the size of a matrix row in bytes
		#
		sll	row_size, dim, EL_SIZE_BITS
		
		# Calculate matrix size ((mat_size = DIM * ROW_SIZE) - EL_SIZE)
		# This is the size of the matrix in bytes, minus one element
		#
		mult	dim, row_size
		mflo	mat_size
		addi	mat_size, mat_size, -EL_SIZE
		
		# Reset row loop count
		move	row, $zero
		
	row_loop:
		# Reset column loop count
		move	column, $zero

	column_loop:
		# Get value from matrix C
		lw	mac_result, 0(c_index)
		
		# Reset Z loop count
		move	z, $zero

	z_loop:
		# Get value from matrix A
		lw	a_temp, 0(a_index)
		
		# Get value from matrix B
		lw	b_temp, 0(b_index)
		
		# Calculate product of matrix values A and B
		multu	a_temp, b_temp
		
		# Accumulate low 32-bits of result
		mflo	a_temp
		add	mac_result, mac_result, a_temp

		# Adjust matrix A index (forward by one column)
		addiu	a_index, a_index, EL_SIZE
		
		# Adjust matrix B index (forward by one row)
		add	b_index, b_index, row_size
		
		# Advance Z loop count
		addiu	z, z, 1
		blt	z, dim, z_loop
		
		# Store accumulated product to matrix C
		sw	mac_result, 0(c_index)

		# Adjust matrix A index (backward by one row)		
		sub	a_index, a_index, row_size
		
		# Adjust matrix B index (backward by the matrix size and then forward one element)
		sub	b_index, b_index, mat_size

		# Adjust matrix C index (forward by one element)
		addiu	c_index, c_index, EL_SIZE
				
		# Advance column loop count
		addiu	column, column, 1
		blt	column, dim, column_loop	
		
		# Adjust matrix A index (forward by one row)
		add	a_index, a_index, row_size
		
		# Adjust matrix B index (backward by one row)
		sub	b_index, b_index, row_size
		
		# Advance row loop count
		addiu	row, row, 1
		blt	row, dim, row_loop
					
		#===============================================================
		#===============================================================
# End CODE

		la	$a0, msgc
		la 	$a1, matrix_c
		jal	PRINT_MAT 

#   Exit
		li	 $v0,10
	    	syscall


PRINT_MAT:	li	$v0,4
		syscall
		addi $a2,$0,0	
PL4:		bge	$a2,$s1,PL1
		addi $a3,$0,0
PL3:		bge	$a3,$s1,PL2

		lw	$a0,0($a1)
		li	$v0,1
		syscall
		la	$a0,sp
		li	$v0,4
		syscall
		addi $a1,$a1,4
		addi $a3,$a3,1
		b 	PL3

PL2:		addi	$a2,$a2,1
		la	$a0,nline
		li	$v0,4
		syscall
		b	PL4
PL1:		jr	$ra
