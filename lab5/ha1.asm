.data 
Message: .asciiz "This is NOTIF from MARS:\n"
string: .asciiz "Hello"
buffer: .byte 1

.text


li $v0, 33 
li $a0, 152 
li $a1, 2000 
li $a2, 0 
li $a3, 212


syscall



# the interger to be printed is 0x307 # execute
