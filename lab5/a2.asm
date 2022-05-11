.data
res:	  .asciiz "Result:\n "
Message1: .asciiz "Input first number: "
Message2: .asciiz "Input second number: "
Message3: .asciiz "The sum of "
Message4: .asciiz " and "
Message5: .asciiz " is: "
str: 	  .space 100
.text

# get first number from user
li $v0, 4
la $a0, Message1
syscall 

li $v0, 5
syscall 
move $s0, $v0 				

# get second number from user
li $v0, 4
la $a0, Message2
syscall 

li $v0, 5
syscall 
move $s1, $v0 

la $a0, Message3					
la $a1, str	

add $s2, $s0, $s1				# get sum of input

la $a0, Message3					
la $a1, str					

sb $s0, 12($a1)

xor $s0, $s0, $s0 			# i = 0
LOOP:
	add $t0, $s0, $a0 			
	lb $t1, 0($t0)				
	
	beq $t1, $zero, ENDLOOP			

	add $t2, $s0, $a1			
	sb $t1, 0($t2)				
	
	addi $s0, $s0, 1			
	j LOOP
ENDLOOP:

li $v0, 59
la $a0, res
la $a1, str
syscall