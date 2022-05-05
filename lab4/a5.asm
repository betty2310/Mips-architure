.data   
user_input: .asciiz "\n\nEnter n: " 
result_display: .asciiz "\nResult of n * 4 is: "             
Greeting:   .asciiz "\n\nThank you!"    
.text
main:

#user input
li $v0, 4
la $a0, user_input
syscall

#allow user input
li $v0, 5
syscall

#store the input value into t1
move $t1, $v0

# use shift left to multiply: 2 mean *2^2 = 4;   $s0 = $t1 * 4
sll $s0, $t1, 2

# Display the result
li $v0, 4
la $a0, result_display
syscall

# Print out the result
li $v0, 1
move $a0, $s0
syscall

# Greets the user
li $v0, 4
la $a0, Greeting
syscall