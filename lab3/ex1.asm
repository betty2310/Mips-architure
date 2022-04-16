#Laboratory Exercise 3, Home Assignment 1 

.text
	addi $s1, $zero, 4 	#i
	addi $s2, $zero, 3 	#j

start:
	slt 	$t0, $s2, $s1	#j<i
	beq 	$t0, $zero, else
	addi	$t1, $t1, 1
	addi 	$t3, $zero, 1
	j		endif
else:
	addi	$t2, $t2, -1
	add		$t3, $t3, $t3
endif: