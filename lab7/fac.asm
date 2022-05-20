.data
Message: .asciiz "Result: 3!="

.text
main: 
	jal WARP

quit:
	add $a1, $v0, $zero
	li $v0, 56
	la $a0, Message
	syscall
	
	li $v0, 10
	syscall
	
endmain:
#--------------------------------------------------------------------
# Procedure WARP: assign value and call FACT 
#---------------------------------------------------------------------

WARP:
	sw $fp, -4($sp)				# store old fp
	move $fp, $sp 				# new fp point to top of stack data
	addi $sp, $sp, -8			# adjust stack to save data
	
	# now, fp point to old sp and sp -= 8 and store new data
	sw $ra, 0($sp) 				# save $ra
	
	# asumme we solve 6!
	li $a0, 3
	jal FACT					# solve
	nop
	
	# return values to $ra, $sp and $fp
	lw $ra, 0($sp)				
	addi $sp, $fp, 0
	lw $fp, -4($sp)
	jr $ra
WARP_END:

#--------------------------------------------------------------------
# Procedure FACT: compute N!

# param[in] $a0 integer N

# return $v0 the largest value #
#---------------------------------------------------------------------
FACT:
	#store valuse
	sw $fp, -4($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -12
	
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	# n < 2 ?
	slti $t0, $a0, 2
	beq $t0, $zero, recursive
	nop
	
	# return 1 when n = 1
	li $v0, 1
	j done
	nop
	
recursive:
	addi $a0, $a0, -1
	jal FACT
	nop
	
	# load $a0
	lw $v1, 0($sp)
	mul $v0, $v1, $v0
	
done:
	lw $ra, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $fp, 0
	lw $fp, -4($sp)
	jr $ra
FACT_END:
