.data	
	str: .space 100
	message1: .asciiz "Program count length of string!\nInput: "
	message2: .asciiz "Result is: "
.text
	# get input str from user
GETINPUT:
	li $v0, 54
	la $a0, message1
	la $a1, str
	li $a2, 100
	syscall 
	slt $t9, $a1, $zero 
	bne $t9, $zero, GETINPUT
MAIN:
	# $s0 = i = 0
	xor $s0, $s0, $s0
	la $s1, str
LOOP:
	add $t0, $s1, $s0  				# get address of str[i]
	lb $t1, 0($t0)					# get value of str[i]
	beq $t1, $zero, ENDLOOP			# end loop when str[i] = \0
	addi $s0, $s0, 1				# ++i
	j LOOP
ENDLOOP:
	subi $s0, $s0, 1				# the string contain \n in the end so we -1.
	move $a1, $s0
	li, $v0, 56
	la $a0, message2
	syscall
END: