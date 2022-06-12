.eqv MONITOR_SCREEN 0x10010000 
.eqv RED 0x00FF0000 
.eqv GREEN 0x0000FF00 
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF 
.eqv YELLOW 0x00FFFF00 

.text 

	li $k0, MONITOR_SCREEN
	li $s0, 0
	li $s1, 4
	li $t0, RED 
	sw $t0, 0($k0)
loop:
	slti $t0, $s0, 256
	beq $t0, $zero, end_loop
	addi $k0, $k0, 4
	li $t0, RED 
	sw $t0, 0($k0)
	addi $s0, $s0, 1
	j loop
end_loop:
	li $k0, MONITOR_SCREEN
	li $t0, YELLOW
	sw $t0, 284($k0)
	sw $t0, 288($k0)
	sw $t0, 348($k0)
	sw $t0, 352($k0)
	sw $t0, 408($k0)
	sw $t0, 412($k0)
	sw $t0, 416($k0)
	sw $t0, 420($k0)
	sw $t0, 456($k0)
	sw $t0, 460($k0)
	sw $t0, 464($k0)
	sw $t0, 468($k0)
	sw $t0, 472($k0)
	sw $t0, 476($k0)
	sw $t0, 480($k0)
	sw $t0, 484($k0)
	sw $t0, 488($k0)
	sw $t0, 492($k0)
	sw $t0, 496($k0)
	sw $t0, 500($k0)
	sw $t0, 528($k0)
	sw $t0, 532($k0)
	sw $t0, 536($k0)
	sw $t0, 540($k0)
	sw $t0, 544($k0)
	sw $t0, 548($k0)
	sw $t0, 552($k0)
	sw $t0, 556($k0)
	sw $t0, 600($k0)
	sw $t0, 604($k0)
	sw $t0, 608($k0)
	sw $t0, 612($k0)
	sw $t0, 660($k0)
	sw $t0, 664($k0)
	sw $t0, 676($k0)
	sw $t0, 680($k0)
	sw $t0, 720($k0)
	sw $t0, 724($k0)
	sw $t0, 728($k0)
	sw $t0, 740($k0)
	sw $t0, 744($k0)
	sw $t0, 748($k0)
	sw $t0, 784($k0)
	sw $t0, 812($k0)
	li $v0, 10
	syscall