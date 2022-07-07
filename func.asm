.data
	ascii_0:     .word 48
    ascii_1:     .word 49
    ascii_2:     .word 50
    ascii_3:     .word 51
    ascii_5:     .word 53
    ascii_9:     .word 57

    letter_size: .word 23
    
    n_line:		 .word 16
    
	line_1:  .asciiz  "                                               *************         \n"
	line_2:  .asciiz  "**************                                *3333333333333*        \n"
	line_3:  .asciiz  "*222222222222222*                             *33333********         \n"
	line_4:  .asciiz  "*22222******222222*                           *33333*                \n"
	line_5:  .asciiz  "*22222*      *22222*                          *33333********         \n"
	line_6:  .asciiz  "*22222*       *22222*       *************     *3333333333333*        \n"
	line_7:  .asciiz  "*22222*       *22222*     **11111*****111*    *33333********         \n"
	line_8:  .asciiz  "*22222*       *22222*   **1111**       **     *33333*                \n"
	line_9:  .asciiz  "*22222*      *222222*   *1111*                *33333********         \n"
	line_10: .asciiz  "*22222*******222222*   *11111*                *3333333333333*        \n"
    line_11: .asciiz  "*2222222222222222*     *11111*                 *************         \n"
	line_12: .asciiz  "***************        *11111*                                       \n"
	line_13: .asciiz  "      ---               *1111**                                      \n"
	line_14: .asciiz  "    / o o \              *1111****   *****                           \n"
	line_15: .asciiz  "    \   > /               **111111***111*                            \n"
	line_16: .asciiz  "     -----                   ***********      dce.hust.edu.vn        \n"
	
.text

main:

	la $s0, n_line
	lw $s0, 0($s0)

	la $s1, line_1

func:
	beq $t1, $s0, end_func
	add $a0, $s1, $zero
	add $a1, $zero, $zero



end_func:	
	
end_main:
	li $v0, 10
	syscall

#--------------------------------------------------------------------
# FUNCTION		change digit charactor to new charactor in line from start index and end.
# @param[in] 	$a0: address of line
# @param[in] 	$a1: postion to start
# @param[in] 	$a2: postiton end
# @param[in] 	$a3: charactor
# @return  	 	
#--------------------------------------------------------------------
change_digit_charactor_in_line:
	add $k0, $a0, $zero    		#backup $a0
	add $k1, $ra, $zero			#backup $ra
for_loop_to_change_digit:
	beq $a1, $a2, end_loop
	add $t0, $a0, $a1
	lb $s0, 0($t0)
	addi $a1, $a1, 1
	
	
	add $a0, $s0, $zero			# we change $a0, so need to backup and restore
	jal is_digit
	
	add $a0, $k0, $zero			# restore
	
	beq $v0, $zero, for_loop_to_change_digit
	sb $a3, 0($t0)
	
	j for_loop_to_change_digit
	
end_loop:
	add $ra, $k1, $zero
	jr $ra

#--------------------------------------------------------------------
# FUNCTION		is_digit:	check charactor is digit from 0 to 9
# @param[in] 	$a0: charactor
# @return  	 	$v0: 1 if character is digit from 0 to 9 and 0 if else
#--------------------------------------------------------------------
is_digit:
backup:
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
func:
	la $t0, ascii_0
	lw $t1, 0($t0)				#t1 = 0
	la $t0, ascii_9
	lw $t2, 0($t0)				#t2  = 9
	
	blt $a0, $t1, false	
	blt $t2, $a0, false

true:
	addi $v0, $zero, 1
	j restore
false:
	li $v0, 0
	j restore
restore:
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
return:
	jr $ra 


