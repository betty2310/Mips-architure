.text

li $s0, 0x12345678

A:
andi $t0, $s0, 0xff000000		#extract MSB of $s0 to $t0
B:
andi $s0, $s0, 0xffffff00 		#clear LSB of $s0
C: 
ori $t2, $s0, 0x00000040		#set bits 7 from 0 to 1
D:
andi $s0, $s0, 0x00000000