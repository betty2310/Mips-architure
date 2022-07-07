.data
	numberOfStudent:	 .word    11
	studentMark:  		 .float   8.5, 6.25, 3.5, 5.0, 9.25, 4.75, 7.0, 2.5, 1.5, 10 10
	student1: 			 .asciiz  "Nguyen Dinh Thanh An"
	space1:				 .space   11
	student2: 			 .asciiz  "Nguyen Hoang Hieu"
	space2:				 .space   14
	student3: 			 .asciiz  "Nguyen Thi Thanh Hien"
	space3:				 .space   10
	student4: 			 .asciiz  "Nguyen Ngoc Dung"	
	space4:				 .space   15
	student5: 			 .asciiz  "Tran Van Nam"
	space5:				 .space   19
	student6: 			 .asciiz  "Dao Kim Duong"
	space6:				 .space   18
	student7: 			 .asciiz  "Dinh Trong Huy"
	space7:				 .space   17
	student8: 			 .asciiz  "Nguyen Si Anh Khoa"
	space8:				 .space   13
	student9: 			 .asciiz  "Mac Anh Khoa"
	space9:				 .space   19
	student10: 			 .asciiz  "Duong Huu Huynh"
	space10:			 .space   16
	student11: 			 .asciiz  "Mac Van Khanh"
	space11:			 .space   18
	minScore: 		     .float   4.0
	title:               .asciiz  "Mark\t\tName\n"
	tab:				 .asciiz  "\t"
	nextline:            .asciiz  "\n"
	
.text 
.globl main 
.ent main 
main:
	# lưu dữ liệu từ data
	la $s0, numberOfStudent 	#s0 = number of student
	lw $s0, 0($s0)
	la $s1, studentMark			#s1 lưu địa chỉ studentMark[0]
	la $s2, student1			#s3 lưu địa chỉ studentName[0]
	la $t0, minScore			
	l.s $f0, 0($t0)				#f0 = min score
	
	li $t0, 4					#t0 lưu kích thước phần tử mảng stuentMark
	li $t1, 32					#t1 lưu kích thước phần tử mảng studentName
	li $s3, 0					#s3 là biến chạy i = 0
	
	# in title ra console
	li $v0, 4
	la $a0, title
	syscall

loop:	slt $t2, $s3, $s0				# t2 = (i < number of student) ? 1 : 0
		beq	$t2, $zero, end_loop		# nếu t2 = 0 kết thúc vòng lặp
		nop
		mul $t3, $s3, $t0				# t3 = i * 4 : khoảng cách từ studentMark[0] đến studentMark[i]
		mul $t4, $s3, $t1				# t4 = i * 32 : khoảng cách từ studentName[0] đến studentName[i]
		add $t5, $s1, $t3				# t5 = &studentMark[i]
		add $t6, $s2, $t4				# t6 = &studentName[i]
		addi $s3, $s3, 1				# ++i

		l.s $f1, 0($t5)					# f1 = studentMark[i]
		jal compare
		nop
		
	 	bne $v0, $zero, loop			# if $v0 == 0; studentMark[i] < minScore, bỏ qua sinh viên
		nop

		# in sinh viên thoả mãn ra console
		move $a0, $t5			
		move $a1, $t6
		jal print						
		nop
		j loop
		nop
end_loop:
	# Kết thúc chương trình 
	li $v0, 10
	syscall
.end main

#--------------------------------------------------------------------
# FUNCTION	print:	In thông tin sinh viên 
# @param[in] 	$a0: địa chỉ điểm của sinh viên
# @param[in] 	$a1: địa chỉ tên của sinh viên
# @return  	 
# @note 
#--------------------------------------------------------------------
.ent print
print:
	# in điểm sinh viên ra console
	li $v0, 2
	l.s $f12, 0($a0)
	syscall

	# in ký tự \t <tab>
	li $v0, 4
	la $a0, tab
	syscall
	
	# in tên sinh viên
	li $v0, 4
	move $a0, $a1
	syscall

	# in ký tự  \n <newline>
	li $v0, 4
	la $a0, nextline
	syscall
	jr $ra
.end print

#--------------------------------------------------------------------
# FUNCTION   compare: 	So sánh giá trị 2 số hạng kiểu float.
# @param[in] 	$f0: thanh ghi lưu giá trị số hạng thứ nhất
# @param[in] 	$f1: thanh ghi lưu giá trị số hạng thứ hai
# @return $v0 	lưu giá trị 1 nếu $f0 < $f1 và 0 trong trường hợp còn lại 
# @note 
#--------------------------------------------------------------------
.ent compare
compare:
	c.lt.s $f0, $f1			# flag = ($f0 < $f1) ? 1 : 0
	li $t8, 0
	li $t9, 1
	movt $t8, $t9			# if flag == 1, $t8 = $t9 
	add $v0, $t8, $zero
	jr $ra	
.end compare
