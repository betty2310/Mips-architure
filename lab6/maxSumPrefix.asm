.data
A:	.word	-2, 6, -1, 3, -2

.text
main:	la $a0, A
		li $a1, 5
		jal mspfx
		
		move $a0, $v0s
		li $v0, 1
		syscall
end_main:		

end:	li $v0, 10
		syscall

# -----------------
# Procedure mspfx 
# @brief: find the maximum-sum prefix in a list of integers 
# @param[in]  a0 the base address of this list(A) need to be processed 
# @param[in] a1 the number of elements in list(A)
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array 
#-------------------

mspfx: 	li $v0, 0 			#initialize length of mspfx to 0 
		li $v1, 0 			#initialize max sum to 0
		li $t0, 0			# i = 0
		li $t1, 0			# temp = 0
		li $t3, 4					

loop:	mul $t9, $t0, $t3
		add $t4, $a0, $t9
		lw	$s0, 0($t4)
		add $t1, $t1, $s0
		slt $t5, $v1, $t1
		bne $t5, $zero, set_max
		j check
set_max:	add $v1, $t1, $zero,
			addi $v0, $v0, 1

check:	addi $t0, $t0, 1
		slt $t6, $t0, $a1
		bne $t6, $zero, loop
		jr $ra

