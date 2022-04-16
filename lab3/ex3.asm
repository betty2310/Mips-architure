#Laboratory Exercise 3, Home Assignment 3 

.data 
	test: .word 1 
	
.text
	la $s0, test
	lw $s1, ($s0)
	
	li $s2, 2 #a
	li $s3, 3 #b
	li $t0, 0 # case 0
	li $t1, 1 # case 1
	li $t2, 2 # case 2
	
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	j default
	
case_0: 
	addi $s2, $s2, 1
	j continue
case_1:
	sub $s2, $s2, $t1
	j continue
case_2:
	add $s3, $s3, $s3
	j continue
default:
continue:
	