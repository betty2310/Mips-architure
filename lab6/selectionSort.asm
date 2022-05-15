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

func_sort:	beq $a0, $a1, end_sort
			subi $a1, $a1, 4
			jal func_find_max
			lw $s0, 0($a1)
			sw $v0, 0($a1)
			sw $s0, 0($v1)
			
			j func_sort

end_sort: 	j end

func_find_max:	move $t0, $a0
				lw $v0, 0($a0)
				move $v1, $a0
				
loop:	beq $t0, $a1, end_loop
		addi $t0, $t0, 4
		lw $t1, 0($t0)
		slt $t2, $v0, $t1
		beq $t2, $zero, loop
		move $v0, $t1
		move $v1, $t0
		j loop

end_loop: jr $ra		

