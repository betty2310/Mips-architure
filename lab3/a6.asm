#Laboratory 3, Home Assigment 2
 
.data
	A:		.word 1, 2, -1, 3, -3, 9, 4, 0, -1, 2, 5, -2, 2
	n:		.word 12
	result: .word 0               	# we assume 0 is min 
	
.text
	la $s1, A
	la $s2, n
	la $s3, result
	lw $t1, ($s1) 					# get A
	lw $t2, ($s2) 					# get n
	lw $t3, ($s3) 					# get result
	add $t4, $zero, $zero			# $t4 = i = 0
	addi $t5, $zero, 1				# $t5 = step = 1
	li $t9, -1 						# -1 used in absolute func
		
loop: 
	slt $s4, $t4, $t2 				# $s4= i < n ? 1 : 0
	beq $s4, $zero, endloop	
			
	# get value of A[i]
	add  $t6, $t4, $t4 
	add  $t6, $t6, $t6 				# t4 = 4 * i (a[i], a[i+1])
	add  $t6, $t6, $s1 				# get address of A[i] (address of A[0] + t3)
	lw   $t0, 0($t6)   				# get value of A[i]
	
	BeginFunc:						# get absolute of A[i]
		slt $t7, $t0, $zero
		beq $t7, $zero, endFunc
		mult $t0, $t9
		mflo $t0
	endFunc:
		
	startif:
		slt $t8, $t3, $t0			# t8 = (res < a[i]) ? 1:0
		beq $t8, $zero, endif
	else:
		add $t3, $zero, $t0   		# res = a[i]
	endif:
	
	add  $t4, $t4, $t5				# ++i
	j loop  
endloop:
	sw $t3, ($s3) 					# store value in result.
