.data	
	str: .space 21
	res: .space 21
	message1: .asciiz "String: "
	message2: .asciiz "Inverse String: "
.text
MAIN:

Get_input:
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 21
	syscall 

Get_strlen:
	# t9 = \n
	li $t9, 10
	
	# $s0 = i = 0
	xor $s0, $s0, $s0
	move $s1, $a0
	LOOP:
		add $t0, $s1, $s0  				# get address of str[i]
		lb $t1, 0($t0)					# get value of str[i]
		beq $t1, $t9, ENDLOOP			# end loop when str[i] = \0 or \n
		beq $t1, $zero, ENDLOOP			# end loop when str[i] = \0 or \n
		addi $s0, $s0, 1				# ++i
		j LOOP
	ENDLOOP:
	
Inverse_string:	
	# s2 contain address of res string, $t8 = i and $t9 = j
	la $s2, res	
	add $t8, $zero, $s0
	li $t9, 0
	LOOP_1:
		add $t0, $s1, $t8  				# get address of str[i]
		subi $t0, $t0, 1
		lb $t5, ($t0)					# get value of str[i]
		
		add $t2, $s2, $t9 				# get address of res[j]
		sb $t5, 0($t2)					# store 
		subi $t8, $t8, 1				# --i
		bltz $t8, ENDLOOP_1
		addi $t9, $t9, 1				# ++j
		j LOOP_1
	ENDLOOP_1:

OUTPUT:
	li $v0, 4
	la $a0, message2
	syscall
	li $v0, 4
	la $a0, res
	syscall