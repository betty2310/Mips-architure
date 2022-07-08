#==========================================================================================
# @author: Duong Huu Huynh
#          Mac Van Khanh
# @date:   2022-07-07
# Hanoi University of Science and Technology
#==========================================================================================

.data
# -------------------------------------------------------------------------------------------
# global variable
	.eqv ASCII_0 		48				# ascii code of 0 in dec
	.eqv ASCII_9 		57				# ascii code of 9 in dec
	.eqv ASCII_SPACE    32				# ascii code of space in dec
	.eqv LETTER_SIZE 	23				# number of characters in a letter
	.eqv LINE_SIZE 		70				# number of characters in a line: LETTE_SIZE * 3 + 1 ("\n")
	.eqv N_LINE	   		16				# number of lines in image
 #---------------------------------------------------------------------------------------------------------
 #  default image
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
	line_14: .asciiz  "    / o o \\              *1111****   *****                           \n"
	line_15: .asciiz  "    \\   > /               **111111***111*                            \n"
	line_16: .asciiz  "     -----                   ***********      dce.hust.edu.vn        \n"
	
#---------------------------------------------------------------------------------------------------
# Message for user
	TITLE: 				.asciiz 	"------------VE HINH ASCII-----------\n"
	CASE_1_PROMPT:		.asciiz		"1. Hien thi hinh anh tren man hinh console.\n"
	CASE_2_PROMPT:		.asciiz		"2. Hien thi anh khong mau.\n"
	CASE_3_PROMPT:		.asciiz 	"3. Hien thi anh da hoan doi vi tri.\n"
	CASE_4_PROMPT:		.asciiz 	"4. Hien thi anh duoc doi mau.\n"
	EXIT_PROMPT:		.asciiz 	"5. Thoat!\n"
	USER_CHOICE:		.asciiz 	"Nhap gia tri: "
	D_COLOR_PROMPT:		.asciiz 	"Nhap mau cho ky tu D (0->9): "
	C_COLOR_PROMPT:		.asciiz 	"Nhap mau cho ky tu C (0->9): "
	E_COLOR_PROMPT:		.asciiz 	"Nhap mau cho ky tu E (0->9): "

#==========================================================================================

.text
main:
#------------------------------------------------------------------------------------------------------
# Print Menu 
	la $a0, TITLE	
	li $v0, 4
	syscall
	
	la $a0, CASE_1_PROMPT
	li $v0, 4
	syscall

	la $a0, CASE_2_PROMPT
	li $v0, 4
	syscall

	la $a0, CASE_3_PROMPT
	li $v0, 4
	syscall

	la $a0, CASE_4_PROMPT
	li $v0, 4
	syscall

	la $a0, EXIT_PROMPT
	li $v0, 4
	syscall

	la $a0, USER_CHOICE	
	li $v0, 4
	syscall
	
	# Get user choice
	li $v0, 5
	syscall

#---------------------------------------------------------------------------------------------------
# Process main	
	CASE_1:
		addi $v1, $zero, 1
		bne $v0 $v1, CASE_2
		j print_original_image
	CASE_2:
		addi $v1, $zero, 2
		bne $v0, $v1, CASE_3
		j print_colorless_image
	CASE_3:
		addi $v1, $zero, 3
		bne $v0 $v1 CASE_4
		j print_ecd_image
	CASE_4:
		addi $v1, $zero, 4
		bne $v0, $v1, CASE_5
		j print_new_color_image
	CASE_5:
		addi $v1, $zero, 5
		bne $v0, $v1, DEFAULT
		j EXIT_MAIN
	DEFAULT:
		j main

#==========================================================================================
# Process subroutines																	  =
#==========================================================================================

#----------------------------------------------------------------------------------------------
# hiển thị hình ảnh trên giao diện console
#----------------------------------------------------------------------------------------------
print_original_image:
    li $s0, N_LINE  					# $s0 ~ number of lines in image	
	li $t0, 0							# $t0 ~ index i = 0
	la $a0, line_1						# $a0 ~ address of line_1

for_loop_original_image:
    beq $t0, $s0, main					# if i = number of lines in image, end process, go to main
    li  $v0, 4							# call syscall 4 to print string in address $a0
    syscall
        
    addi $a0, $a0, LINE_SIZE			# $a0 += LINE_SIZE + 1
	addi $a0, $a0, 1					# we change $a0 to point to next line
    addi $t0, $t0, 1					# ++i
    j for_loop_original_image

end_loop_original_image:

#----------------------------------------------------------------------------------------------
# sửa ảnh để các chữ cái DCE chỉ còn lại viền, không còn màu số ở giữa, và hiển thị
#-----------------------------------------------------------------------------------------------
print_colorless_image:
    li $s0, N_LINE  					# $s0 ~ number of lines in image	
	li $t0, 0							# $t0 ~ index i = 0
	la $a0, line_1						# $a0 ~ address of line_1

for_loop_print_colorless_image:
    beq $t0, $s0, main					# if i = number of lines in image, end process, go to main

	li $a1, 0							# assign argument to $a0, $a1, $a2, $a3 to call function
	li $a2, LINE_SIZE
	li $a3, ASCII_SPACE
	
	jal change_digit_character_in_line  # call function
	
    addi $a0, $a0, LINE_SIZE			# $a0 += LINE_SIZE + 1
	addi $a0, $a0, 1					# we change $a0 to point to next line
    addi $t0, $t0, 1					# ++i
	j for_loop_print_colorless_image

end_loop_print_colorless_image:

#-----------------------------------------------------------------------------------------
# sửa ảnh để hoán đổi vị trí của các chữ, thành ECD, và hiển thị.
#------------------------------------------------------------------------------------------
print_ecd_image:
	li $s0, N_LINE
	li $t0, 0
	la $s1, line_1

for_loop_print_ecd_image:
    beq $t0, $s0, main					# if i = number of lines in image, end process, go to main

	# assign "\0" to end of each leter in a line
    sb  $zero, 22($s1)     				# line_i[22] = '\0'
    sb  $zero, 45($s1)     				# line_i[45] = '\0'
    sb  $zero, 68($s1)     				# line_i[68] = '\0'
        
    li $v0 4
    la $a0 46($s1)     					# print E
    syscall
        
        
    li $v0 4
    la $a0 23($s1)     					# print C
    syscall
        
    li $v0 4
    la $a0 0($s1)      					# print D
    syscall
        
    li $v0 4
    la $a0 69($s1)						# print "\n"
    syscall
        
    addi $t1, $zero, ASCII_SPACE		# $t1 = ' '

	# restore value we change before
	sb $t1, 22($s1)     				# line_i[22] = '\0'  ---> line_i[22] = ' '
	sb $t1, 45($s1)     				# line_i[45] = '\0'  ---> line_i[45] = ' '
	sb $t1, 68($s1)     				# line_i[68] = '\0'  ---> line_i[68] = ' '
        
    addi $s1, $s1, LINE_SIZE			# $s1 += LINE_SIZE + 1
	addi $s1, $s1, 1					# we change $a0 to point to next line
    addi $t0, $t0, 1					# ++i
    j for_loop_print_ecd_image

#==========================================================================================

print_new_color_image:	
#------------------------------------------------------------------------------------------
# nhập từ bàn phím kí tự màu cho chữ D, C, E, rồi hiển thị ảnh trên với màu mới.
#------------------------------------------------------------------------------------------

# get user input
get_new_d:	
		li 	$v0, 4		
		la 	$a0, D_COLOR_PROMPT
		syscall
	
		li 	$v0, 5							# get number input to $v0
		syscall

		addi $a0, $v0, 48   				# make $a0 from number to ascii code
		jal is_digit						# check if $a0 is a digit by call function is_digit
		
		beq $v0, $zero, get_new_d 			# if $v0 is not a digit, go back
		
		add $s1, $a0, $zero					# $s1 = $a0. $s1 contain ascii code of new color in letter D

get_new_c:	
		li 	$v0, 4		
		la 	$a0, C_COLOR_PROMPT
		syscall
	
		li 	$v0, 5							# get number input to $v0
		syscall

		addi $a0, $v0, 48					# make $a0 from number to ascii code
		jal is_digit						# check if $a0 is a digit by call function is_digit
		
		beq $v0, $zero, get_new_c			# if $v0 is not a digit, go back
		
		add $s2, $a0, $zero					# $s2 = $a0. $s2 contain ascii code of new color in letter C

get_new_e:	
		li 	$v0, 4		
		la 	$a0, E_COLOR_PROMPT
		syscall
	
		li 	$v0, 5							# get number input to $v0
		syscall
	
		addi $a0, $v0, 48					# make $a0 from number to ascii code
		jal is_digit						# check if $a0 is a digit by call function is_digit
		
		beq $v0, $zero, get_new_e			# if $v0 is not a digit, go back

		add $s3, $a0, $zero					# $s3 = $a0. $s3 contain ascii code of new color in letter E
		
#-----------------------------------------------------------------------------------------------------------
# process 
    li $s0, N_LINE  						# $s0 ~ number of lines in image	
	li $t0, 0								# $t0 ~ index i = 0
	la $a0, line_1							# $a0 ~ address of line_1

for_loop_print_new_color_image:
	beq $t0, $s0, main						# if i = number of lines in image, end process, go to main

	li $a1, 0								
	li $a2, LETTER_SIZE					
	add $a3, $s1, $zero						# $a3 = $s1 ~ new color in letter D
											# change digit character in line from index 0 to 23 (mean index of letter D) to new color	
	jal change_digit_character_in_line
	
	li $a1, LETTER_SIZE						# $a1 = LETTER_SIZE
	add $a2, $a2, LETTER_SIZE				# $a2 = LETTER_SIZE * 2  
	add $a3, $s2, $zero						# $a3 = $s2 ~ new color in letter C
											# change digit character in line from index 23 to 46 (mean index of letter C) to new color	
	jal change_digit_character_in_line
	
	li $a1, LETTER_SIZE
	addi $a1, $a1, LETTER_SIZE
	addi $a2, $a2, LETTER_SIZE
	addi $a2, $a2, 1
	add $a3, $s3, $zero						# $a3 = $s3 ~ new color in letter E
											# change digit character in line from index 46 to 70 (mean index of letter E) to new color	
	
	jal change_digit_character_in_line
	
    addi $a0, $a0, LINE_SIZE				# $a0 += LINE_SIZE + 1
	addi $a0, $a0, 1						# we change $a0 to point to next line
    addi $t0, $t0, 1						# ++i
	j for_loop_print_new_color_image
		
#======================================================================================	
EXIT_MAIN:
	li $v0, 10
	syscall

#=======================================================================================
# FUNCTION		change digit character to new character in line from start index to end, and print each character 
#				to console.
# @param[in] 	$a0: address of line
# @param[in] 	$a1: postion start
# @param[in] 	$a2: postiton end
# @param[in] 	$a3: new character
# @return  	 	void
#=======================================================================================
change_digit_character_in_line:
	# backup
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	add $k0, $a0, $zero    						#backup $a0
	add $k1, $ra, $zero							#backup $ra

	# process:
for_loop_to_change_digit:
	beq $a1, $a2, end_loop						# if $a1 = $a2 ~ start = end, end process
	add $t0, $a0, $a1							# $t0 = &line[start]
	lb $s0, 0($t0)								# $s0 = line[start]
	addi $a1, $a1, 1							# ++start
	
	add $a0, $s0, $zero							# asign arugment to function is_digit: check $s0 

	jal is_digit
	
	beq $v0, $zero, print_char					# fasle, print $s0 to console

	li $v0, 11									# true, print new character ($a3) to console	
	add $a0, $a3, $zero
	syscall

	add $a0, $k0, $zero							# restore $a0 because we change it in function is_digit
	j for_loop_to_change_digit
	
print_char:
	li $v0, 11
	syscall

	add $a0, $k0, $zero							# backup $a0
	j for_loop_to_change_digit
	
	
end_loop:
	
	#restore
	lw $s0, 0($sp)				
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	add $ra, $k1, $zero
	jr $ra

#=======================================================================================
# FUNCTION		is_digit to check character is digit from 0 to 9
# @param[in] 	$a0: character
# @return  	 	$v0: 1 if true and 0 if false
#=======================================================================================
is_digit:
	# backup 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	
	# process
	li $t1, ASCII_0				#t1 = 0
	li $t2, ASCII_9				#t2  = 9
	
	blt $a0, $t1, false			# if $a0 < 0, return false	
	blt $t2, $a0, false			# if $a0 > 9, return false

true:
	addi $v0, $zero, 1
	j restore
false:
	li $v0, 0
	j restore
	
	# restore
restore:
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
return:
	jr $ra 