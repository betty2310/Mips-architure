.text

MAIN:
	li $v0, 5
	syscall
	
	# $a0 = n
	move $a0, $v0
	
	# solve
	jal FACT
	
	#output
	j END
	
FACT:
	# store var
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	#func
	slti $t0, $a0, 2
	beq $t0, $zero, RECURSION
	addi $v0, $zero, 1
	jr $ra
	
RECURSION:	
	subi $a0, $a0, 1
	jal FACT
	#restore var 
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	
	mul $v0, $a0, $v0
	jr $ra
	
END:
	move $a0, $v0
	li $v0, 1
	syscall
