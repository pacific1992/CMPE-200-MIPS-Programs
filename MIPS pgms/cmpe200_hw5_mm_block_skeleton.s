# FP program
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

bs:		.word 4
n:		.word 12

nline:  .asciiz "\n"				#Define new line string
sp:	.asciiz " "
msga: .asciiz "Matrix A is: \n"
msgb: .asciiz "Matrix B is: \n"
msgc: .asciiz "Matrix C=A*B is: \n"

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
   		#blocks=2, N=12
		add 	$v0,$0,2
		
		add 	$t3,$0,$0			#$t3 = i
LPI:		bge	$t3,$s1,ELPI

		add 	$t4,$0,$0			#$t4 = j
LPJ:		bge	$t4,$s1,ELPJ

		add 	$t5,$0,$0			#$t5 = k
LPK:		bge	$t5,$s1,ELPK

		add     	$s7, $t5, $v0         # $s7 - k=k+b
                		add     	$s6, $t4, $v0         # $s6 - j=j+b
                		add     	$s5, $t3, $v0         # $s5 - i=i+b


		move 	$t2,$t3			#$t2 = ii=i
LPII:		bge	$t2,$s5,ELPII

		move 	$t1,$t4			#$t1 = jj=j
LPJJ:		bge	$t1,$s6,ELPJJ

		move 	$t0,$t5			#$t0 = kk=k
LPKK:		bge	$t0,$s7,ELPKK


		#  for(ii=i; ii < i+b; ii++) 
		
		# for(jj=j; jj < j+b; jj++)  
		  
		# for(kk=k; kk < k+b; kk++)    
		  
		# C[ii][jj] = C[ii][jj] + A[ii][kk] * B[kk][jj];
		
INNER:		mul	$t6,$t2,$s1		#$t6 = 12*ii
		add	$t6,$t6,$t0		#$t6 = 12*ii+kk
		sll	$t6,$t6,2			#$t6 = $t6*4 to make byte offset
		add	$t7,$t6,$s2
		lw	$t8,0($t7)
		
		mul	$t6,$t0,$s1		#$t6 = 12*kk
		add 	$t6,$t6,$t1		#$t6 = 12*kk+jj
		sll	$t6,$t6,2		# $t6*4 for byte offset
		add	$t7,$t6,$s3
		lw	$t9,0($t7)

		mul	$t8,$t8,$t9

		mul	$t6,$t2,$s1		#$t6 = 12*ii
		add 	$t6,$t6,$t1		#$t6 = 12*ii+jj
		sll	$t6,$t6,2		#$t6*4 for byte offset
		add	$t7,$t6,$s4
		lw	$t9,0($t7)

		add	$t9,$t8,$t9
		sw	$t9,0($t7)


        		addi $t0,$t0,1      #kk++;	
		b LPKK
ELPKK:		addi $t1,$t1,1	#jj++;
		b LPJJ
ELPJJ:		addi $t2,$t2,1	#ii++;
		b LPII
ELPII:	
        		add $t5,$t5,$v0            # k+b
		b	LPK
ELPK:		add $t4,$t4,$v0 	       #j+b   	
		b 	LPJ
ELPJ:		add $t3,$t3,$v0	       #i+b 
		b	LPI
ELPI:	
		
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
PL4:	bge	$a2,$s1,PL1
		addi $a3,$0,0
PL3:	bge	$a3,$s1,PL2

		lw	$a0,0($a1)
		li	$v0,1
		syscall
		la	$a0,sp
		li	$v0,4
		syscall
		addi $a1,$a1,4
		addi $a3,$a3,1
		b 	PL3

PL2:	addi	$a2,$a2,1
		la	$a0,nline
		li	$v0,4
		syscall
		b	PL4
PL1:	jr	$ra