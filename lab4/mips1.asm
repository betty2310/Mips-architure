.text
start:

	li $t0, 0
	li $s1, 0x7FFFFFFF	
	li $s2, 0x7FFFFFFF
	addu $s3, $s1, $s2 

	xor $t1, $s1, $s2 

	bltz $t1, EXIT 

	slt $t2, $s3, $s1

	bltz $s1, NEGATIVE 

	beq $t2, $zero, EXIT 
	
	j OVERFLOW

NEGATIVE:

	bne $t2, $zero, EXIT

OVERFLOW:

	li $t0, 1 

EXIT:
