.data 
	A: .word 7, -2, 5, 1, 5, 6, -3, 7, 3, 6, 8, 8, 9, 5, 4
	Aend: .word
.text 
main:
	la $a0, A
	addi $a0, $a0, 4
	la $a1, Aend
	j func_sort
end:
	li $v0, 10
	syscall

func_sort:	beq $a0, $a1, end_func_sort

			# j = i - 1
			move $t0, $a0
			addi $t0, $t0, -4
			
			# t9 = a[i] = key, t8 = a[j]
			lw $t9, 0($a0)
			lw $t8, 0($t0)

			
while:		lw $s0, 0($a0)
			lw $s1, 0($t0)
			la $t3, A
			slt $t1, $t0, $t3
			bne $t1, $zero, end_while
			
			slt $t2, $t9, $s1
			beq $t2, $zero, end_while
			
			addi $t5, $t0, 4
			sw $s1, 0($t5)
			addi $t0, $t0, -4
			j while
			
end_while:	addi $t5, $t0, 4
			sw $t9, 0($t5)
			addi $a0, $a0, 4
			j func_sort

end_func_sort: 	j end

