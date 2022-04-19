#Laboratory 3, Home Assigment 2 
.data
	A:		.word 1, 2, 1, 3
	sum: 	.word 0
	i:		.word 0
	n:		.word 4
	step:	.word 1
	
.text
	la $s1, i
	la $s2, A
	la $s3, n
	la $s4, sum
	la $s5, step
	
	lw $t1, ($s1) # get i
	lw $t2, ($s3) # get n
	
	lw $t5, ($s4) # get sum
	lw $t6, ($s5) # step
		
loop: 
	slt $s6, $t1, $t2 				# $s6= i < n ? 1 : 0
	beq $s6, $zero, endloop			
	
	add  $t3, $t1, $t1 
	add  $t3, $t3, $t3 				# t3 = 4 * i (a[i], a[i+1])
	add  $t3, $t3, $s2 				# get address of A[i] (address of A[0] + t3)
	lw   $t0, 0($t3)   				# get value of A[i]
	add  $t5, $t5, $t0 				# sum += A[i]
	add  $t1, $t1, $t6				# ++i
	j loop  
endloop:
	sw $t5, ($s4) 					# store value in Sum.
