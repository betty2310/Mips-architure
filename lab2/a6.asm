#Laboratory Exercise 2, Assignment 6 
.data                      
	X: 	.word	5
	Y: 	.word	1
	Z:	.word
	
.text
	la	$t8, X
	la 	$t9, Y
	lw	$t1, 4($t8)
	lw	$t2, 4($t9)
	
	add $s0, $t1, $t1
	add $s0, $s0, $t2
	
	la $t7, Z
	sw $s0, 0($t7)
