.eqv IN_ADDRESS_HEXA_KEYBOARD 	0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 	0xFFFF0014

.text
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t2, OUT_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x4
	
pooling:
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	
	li $v0, 34
	syscall
	
	li $a0, 100
	li $v0, 32
	syscall
	
	j pooling
