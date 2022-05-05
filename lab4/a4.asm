.text

li $t0, 0 					#resutl : 0 mean no overflow and 1  is overflow
li $s1, 0x7FFFFFFF			# operand 1
li $s2, 0x7FFFFFFF			# operand 2

xor $t1, $s1, $s2
bltz $t1, END

addu $s3, $s1, $s2  		# $s2 = $s1 + $s2
xor $t2, $s3, $s1
bgtz $t2, END
addi $t0, $t0, 1


END: