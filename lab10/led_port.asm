.eqv SEG_RIGHT_AD	0xFFFF0010
.eqv SEG_LEFT_AD  	0xFFFF0011

.text 
main:
	li $a0, 79 						# display 3 in right led?
	jal seg_right
	nop
	
	li $a0, 91						# display 2 in left led
	jal seg_left
	nop
	
exit:	
	li $v0, 10
	syscall
	
seg_right:
	li $t0, SEG_RIGHT_AD
	sb $a0, 0($t0)
	jr $ra
	nop
	
seg_left:
	li $t0, SEG_LEFT_AD
	sb $a0, 0($t0)
	jr $ra
	nop