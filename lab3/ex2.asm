#Laboratory 3, Home Assigment 2 

# i    == $s1
# A[0] == $s2
# sum  == $s5
# n    == $s3
# step == $s4

.text
	addi $s5, $zero, 0
	addi $s1, $zero, 0
	addi $s3, $zero, 3
	addi $s4, $zero, 1
	
loop: 
	slt $t2, $s1, $s3
	beq $t2, $zero, endloop
	
	add  $t1, $s1, $s1 
	add  $t1, $t1, $t1 
	add  $t1, $t1, $s2 
	lw   $t0, 0($t1)   
	add  $s5, $s5, $t0 
	add  $s1, $s1, $s4
	j loop  
endloop: