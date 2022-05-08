.data
	x: .space 30
	y: .asciiz "Hello World!\n"
.text 
	# $a0 = y, $a1 = x, $s0 = i
	
	la $a0, y					# $a0 stored address of y
	la $a1, x					# $a1 stored address of x
	
	xor $s0, $s0, $s0 			# i = 0
LOOP:
	add $t0, $s0, $a0 			# get address of y[i]
	lb $t1, 0($t0)				# get valuse of y[i] 
	
	beq $t1, $zero, ENDLOOP			# $t1 == 0 means \0 and end loop

	add $t2, $s0, $a1			# get address of x[i]
	sb $t1, 0($t2)				# x[i] = t1
	
	addi $s0, $s0, 1			# ++i
	j LOOP
ENDLOOP:
	# ouput string dialog, we set $a0 and $a1 below. 
	li $v0, 59
	syscall
	