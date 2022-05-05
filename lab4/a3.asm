.text
A: #abs
	li $s0, 0xF0121314
	subi $s0, $s0, 1
	nor $s1, $s0, $zero 		#$s1 = not ($s0)

