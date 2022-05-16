.data 
	A: .word 7, -2, 5, 1, 5, 6, -3, 7, 3, 6, 8, 8, 9, 5 
	Aend: .word
.text 
main:
	la $a0, A
	la $a1, Aend
	j func_sort
end:
	li $v0, 10
	syscall

func_sort:	beq $a0, $a1, end_func_sort
			move $t0, $a0
			
loop:		lw $s0, 0($a0)
			addi $t0, $t0, 4
			lw $s1, 0($t0)
			beq $t0, $a1, end_loop
			slt $t1, $s1, $s0
			bne $t1, $zero, func_swap
			
countinue:	j loop
			
end_loop:	addi $a0, $a0, 4
			j func_sort

end_func_sort: 	j end

func_swap:	sw $s0, 0($t0)
			sw $s1, 0($a0)
			j countinue
			nop