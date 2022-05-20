
#Laboratory Exercise 7, Home Assignment 3 
.text 
push: 
li $s0, 8
li $s1, 2

sw $s0,0($sp) #push $s0 to stack
subi $sp, $sp, 4
sw $s1,0($sp) #push $s1 to stack