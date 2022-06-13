.eqv KEY_CODE 			0xFFFF0004
.eqv KEY_CONTROL		0xFFFF0000

.eqv DISPLAY_CODE 		0xFFFF000C
.eqv DISPLAY_CONTROL 	0xFFFF0008

.text
	
	li $k0, KEY_CODE
	li $k1, KEY_CONTROL
	
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_CONTROL
	
	li $s3, 4
	li $s4, 17
	move $fp, $sp
loop:
wait:
	bne $v0, $zero, exit_main
	lw $t0, 0($k1)
	beq $t0, $zero, wait
	nop
	
read:
	lw $t1, 0($k0)
	slt $t3, $s3, $s4
	beq $t3, $zero, stack
continue:	
	sub $sp, $sp, 4
	addi $s3, $s3, 4
	sw $t1, 0($sp)	
	j wait_display
	nop
	
stack:
	lw $t4, 8($sp)
	sw $t4, 12($sp)
	lw $t4, 4($sp)
	sw $t4, 8($sp)
	lw $t4, 0($sp)
	sw $t4, 4($sp)
	sw $t1, 0($sp)
	jal check
	nop
	j wait_display
	nop
		
wait_display:
	lw $t2, 0($s1)
	beq $t2, $zero, wait_display
	nop
display:
	sw $t1, 0($s0)
	j loop
	nop

exit_main:
	li $v0, 10
	syscall

check:
	lw $t6, -4($fp)
	lw $t7, -8($fp)
	lw $t8, -12($fp)
	lw $t9, -16($fp)
	subi $t6, $t6, 101
	subi $t7, $t7, 120
	subi $t8, $t8, 105
	subi $t9, $t9, 116
	
c1:
	beqz $t6, change1
	li $v0, 0
c2:
	beqz $t7, change2
	li $v0, 0
c3:
	beqz $t8, change3
	li $v0, 0
c4:
	beqz $t9, change4
	li $v0, 0
end_check:
	jr $ra
	
change1:
	li $v0, 1
	j c2
change2:
	li $v0, 1
	j c3
change3:
	li $v0, 1
	j c4
change4:
	j end_check
