#Laboratory Exercise 3, Home Assignment 3 

.data 
	test: 	.word 0 
	a: 		.word 2
	b: 		.word 4
	
.text
	la $s0, test				# $s0 contain address of test
	lw $s1, ($s0)				# $s1 is value of test
	
	li $t0, 0 					# case 0
	li $t1, 1 					# case 1
	li $t2, 2 					# case 2
	
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	j default
	
	la $s4, a
	lw $s5, ($s4) 				# get value of a
case_0: 				
	addi $s5, $s5, 1			# a+=1
	sw $s5, ($s4)				# return value to a
	j continue
case_1:
	
	j continue
case_2:
	
	j continue
default:
continue:
	
