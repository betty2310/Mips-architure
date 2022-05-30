.data
	largest_str: .asciiz "Largest: "
	smallest_str: .asciiz "\nSmallest: "
	s1: .ascii ", "
	
.text
	li $s0, 1
	li $s1, 3
	li $s2, -2
	li $s3, -9
	li $s4, 7
	li $s5, -4
	li $s6, 2
	li $s7, 2
	
main:
 	# store in stack
	la $fp, 0($sp)						
	addi $sp, $sp, -4
	sw $s0, 0($sp)					
	addi $sp, $sp, -4				
	sw $s1, 0($sp) 				
	addi $sp, $sp, -4				
	sw $s2, 0($sp)
	addi $sp, $sp, -4				
	sw $s3, 0($sp)
	addi $sp, $sp, -4				
	sw $s4, 0($sp)
	addi $sp, $sp, -4				
	sw $s5, 0($sp)
	addi $sp, $sp, -4				
	sw $s6, 0($sp)
	addi $sp, $sp, -4				
	sw $s7, 0($sp)
	addi $sp, $sp, -4				
	sw $s0, 0($sp)							# base value = $s0
	addi $sp, $sp, -4				
	sw $zero, 0($sp)						# base index = 0
	
	jal find_largest_number
	
	move $t0, $v0
	div $t0, $t0, 4
	la $a0, largest_str
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, s1
	li $v0, 4
	syscall
	move $a0, $v1
	li $v0, 1
	syscall

	jal find_smallest_number
	
	move $t0, $v0
	div $t0, $t0, 4
	
	la $a0, smallest_str
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, s1
	li $v0, 4
	syscall
	move $a0, $v1
	li $v0, 1
	syscall
	

end_main:	li $v0, 10
			syscall
	

#--------------------------------------------------------------------
# Procedure find_largest_number: find largest number and inex in stack (from $sp to $fp)

# Return: $v0: index 
# 		  $v1: value

#---------------------------------------------------------------------
find_largest_number:
	la $t0, 0($sp)
	addi $t0, $t0, 8

loop:	slt $t9, $t0, $fp
		beq $t9, $zero, end_func
		lw $t1, 4($sp)
		lw $t2, 0($t0)
		addi $t0, $t0, 4
		slt $t3, $t1, $t2
		beq $t3, $zero, end_loop
		sw $t2, 4($sp)
		sub $t4, $fp, $t0
		sw $t4, 0($sp)
end_loop:
		j loop
end_func:
		lw $v0, 0($sp)
		lw $v1, 4($sp)
		jr $ra
#--------------------------------------------------------------------
# Procedure find_smallest_number: find smallest number and inex in stack (from $sp to $fp)

# Return: $v0: index 
# 		  $v1: value

#---------------------------------------------------------------------	
find_smallest_number:
	la $t0, 0($sp)
	addi $t0, $t0, 8

loop_:	slt $t9, $t0, $fp
		beq $t9, $zero, end_func_
		lw $t1, 4($sp)
		lw $t2, 0($t0)
		addi $t0, $t0, 4
		slt $t3, $t2, $t1
		beq $t3, $zero, end_loop_
		sw $t2, 4($sp)
		sub $t4, $fp, $t0
		sw $t4, 0($sp)
end_loop_:
		j loop_
end_func_:
		lw $v0, 0($sp)
		lw $v1, 4($sp)
		jr $ra