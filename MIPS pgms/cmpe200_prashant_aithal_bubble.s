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
#msgc:	.asciiz "Inside for_loop : \n"
#msgd:	.asciiz "Inside move_address : \n"
#msge:	.asciiz "Inside swap : \n"


	.text
	.globl main

main:
	la 	$s0, n			# Get address of variable n
	lw 	$s0, 0($s0)		# Get value of n	
	la 	$s1, list		# Get address of input list
	
	la	$a0, msga			
	la 	$a1, list
	jal	PRINT			# Call PRINT with two arguments, msga and list

# Your CODE HERE

	move $t7,$s0 			# initialze the count in $t7

while_loop:
    la 	    $s1, list			# Get address of input list
    sub     $t8,$t7,1               	# get count
    beqz    $t8,end           
    li      $t2,0                   	# clear swap flag
    jal     load             		# for loop
    sub     $t7,$t7,1               	# decrement the passes 
    beqz    $t2,end           		# if no swap done, goto end
    j       while_loop


load:
    sub     $t8,$t8,1               	# reduce the loops
    lw      $s3,0($s1)              	# Load 1st element in s3
    lw      $s4,4($s1)              	# Load 2nd element in s4
    j check

  
move_address:
	#la $a0, msgd			
	#li	$v0, 4     		# print inside move_address
	#	syscall	
#	addu 		
    add     $s1,$s1,4               	# point  to next element in the "array"
    bgtz    $t8,load           		# swap  done? if no, loop, else  go below
    beqz    $t8,jump			#go to jump subroutine if $t8=0

check:
    bgt     $s3,$s4,swap       		# if (s3 > s4) ,swap elements
    j       move_address		#jump to move_address

swap:
    sw      $s4,0($s1)              	# put value of [i] in s4,swap them
    sw      $s3,4($s1)              	# put value of [i+1] in s3
    li      $t2,1                   	# make swap flag 1
    j       move_address		#jump to move_address
   
jump:    
    jr      $ra                     	#return   
end:
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

		

