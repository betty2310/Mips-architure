.eqv HEADING		0xffff8010
.eqv LEAVETRACK		0xffff8020
.eqv MOVING			0xffff8050
.eqv WHEREX			0xffff8030
.eqv WHEREY			0xffff8040

.text
main:	
	jal TRACK
	nop
	
	# xac dinh huong di cua bot
	li $a0, 90
	jal ROTATE
	nop
	
	# gio moi go ne` :v
	jal GO
	nop

	li $v0, 32
	li $a0, 2000
	syscall
	
	li $a0, 180
	jal ROTATE
	nop
	li $v0, 32
	li $a0, 2000
	syscall
	
	jal UNTRACK
	nop
	jal TRACK
	nop
	
	li $a0, 90
	jal ROTATE
	nop
	li $v0, 32
	li $a0, 2000
	syscall
	
	li $a0, 20
	jal ROTATE
	nop
	li $v0, 32
	li $a0, 2000
	syscall
	
	jal UNTRACK
	nop
	jal TRACK
	nop
	
	li $a0, 270
	jal ROTATE
	nop
	li $v0, 32
	li $a0, 5000
	syscall
	
	jal STOP
	nop
end_main:
	li $v0, 10
	syscall
		
	
#----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in] none
#----------------------------------------------------------
TRACK: 
	li $at, LEAVETRACK 
	li $t0, 1
	sb $t0, 0($at)
	jr $ra 
	nop
	
#----------------------------------------------------------
# UNTRACK procedure, to stop drawing line 
# param[in] none
#----------------------------------------------------------
UNTRACK:
	li $at, LEAVETRACK 	
	sb $zero, 0($at)
	jr $ra
	nop
#----------------------------------------------------------
# ROTATE procedure, to rotate the robot 
# param[in] $a0, An angle between 0 and 359 
								# 0 : North (up)
								# 90: East (right) 
								# 180: South (down) 
								# 270: West (left) 
#-----------------------------------------------------------	
ROTATE: 
	li $at, HEADING 
	sw $a0, 0($at)
	jr $ra
	nop 

#----------------------------------------------------------
# GO procedure, to start running 
# param[in] none
#----------------------------------------------------------
GO: 
	li $at, MOVING 
	li $k0, 1
	sb $k0, 0($at)
	jr $ra 
	nop
#----------------------------------------------------------
# STOP procedure, to stop running 
# param[in] none
#----------------------------------------------------------	
STOP:
	li $at, MOVING 
	sb $zero, 0($at)
	jr $ra
	nop
