# Programmer: Bondoc, Rod Xavier R.
# Description: This program makes the marsbot using a straight line as a path.
#			   Program computes arc tan.
# Bugs:

.data
	waypoint: .word 0x00640000, 0, 0x00000064, 0, 0x00C80008, 0x00D000C8, 0x003200D0, 0x002D01A9,
				0x015E0190, 0x0177002B, 0x015E0190, 0x000A0182, 0, -1									#The coordinates of the points where the marsbot is heading
	letterr: .word 0x000501C2, 0x000501F4, 0x000A01F4, 0x000A01E0, 0x001E01E0, 0x001E01F4, 				#Letter R for initials
			0x002301F4, 0x002301DB, 0x001901DB, 0x001901C2, 0x000501C2, -1
	box_in_r: .word 0x000A01C4, 0x001401C4, 0x001401DB, 0x000A01DB, 0x000A01C4, -1						#Box for letter R in initials
	letterx: 0x002801C2, 0x003201C2, 0x003C01D6, 0x004601C2, 0x005001C2, 0x004601DB,					#Letter X for initials
			0x005001F4, 0x004601F4, 0x003C01E0, 0x003201F4, 0x002801F4, 0x003201DB, 0x002801C2, -1
	letterb: 0x005501C2, 0x005501F4, 0x007301F4, 0x007301DB, 0x006901DB, 0x006901C2,					#Letter B for initials
			0x005501C2, -1
	upperbox: 0x005A01C7, 0x006401C7, 0x006401D6, 0x005A01D6, 0x005A01C7, -1							#Upper box for letter B
	lowerbox: 0x005A01E0, 0x006E01E0, 0x006E01EF, 0x005A01EF, 0x005A01E0, -1							#Lower box for letter B

.text
	main:
		addi $sp, $sp, -24												#Add -24 to stack pointer
		sw $s0, 0($sp)													#Saves stored registers in stack pointer
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $s3, 12($sp)
		sw $s4, 16($sp)
		sw $s5, 20($sp)

		li $s0, 0xffff8010												#Address for direction of marsbot
		li $s1, 0xffff8020												#Address for leave mark
		li $s2, 0xffff8030												#Address for x coordinate
		li $s3, 0xffff8040												#Address for y coordinate
		li $s4, 0xffff8050												#Address for move or not move
		li $s5, 1														#A constant 1 for activation of leave mark and move

		la $s6, waypoint												#Loads the waypoint
		lw $a0, 0($s6)													#Loads the first word of the waypoint
		bne $a0, -1, execute											#Check if the bot will move or do nothing
		jal make_initial												#Jumps to making initials
		lw $s0, 0($sp)													#Loads the saved register from the stack pointer
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		addi $sp, $sp, 24												#Adds 24 to stack pointer
		j exit															#Terminate program
		execute:
			jal get_components											#Gets the x and y components of the point
			move $a0, $v0												#Stores x coordinate in $a0
			move $a1, $v1												#Stores y coordinate in $a1
			sw $zero, 0($s1)											#Tells marsbot don't leave mark
			jal move_bot												#Makes bot move
			addi $s6, $s6, 4											#Adds 4 to $s6
			lw $a0, 0($s6)												#Loads the next word in waypoint
			go_to_point:
				bne $a0, -1, go_to_point1								#Check if the marsbot will stop moving
				jal make_initial										#Jumps to making initials										
				lw $s0, 0($sp)											#Loads the saved registers from stack pointer
				lw $s1, 4($sp)
				lw $s2, 8($sp)
				lw $s3, 12($sp)
				lw $s4, 16($sp)
				lw $s5, 20($sp)
				addi $sp, $sp, 24										#Adds 24 to stack pointer
				j exit													#Terminate program
				go_to_point1:
				jal get_components										#Gets the x and y components of the point
				move $a0, $v0											#Stores x coordinate in $a0
				move $a1, $v1											#Stores y coordinate in $a1
				sw $s5, 0($s1)											#Tells bot to leave mark
				jal move_bot											#Makes bot move
				sw $zero, 0($s1)										#Tells bot not to leave mark
				addi $s6, $s6, 4										#Adds 4 to $s6
				lw $a0, 0($s6)											#Loads the next word in waypoint
				j go_to_point											#Loops while $a0 != -1

	# Purpose: This procedure gets the x and y components of the destination of tha mars bot.
	# Arguments:
	# $a0: The number representing the point
	# Return value:
	# $v0: The x coordinate of the destination point
	# $v1: The y coordinate of the destination point
	get_components:
		srl $v0, $a0, 16												#Gets the upper 16 bits for x coordinate
		sll $v1, $a0, 16												#Gets the lower 16 bits for y coordinate
		srl $v1, $v1, 16
		jr $ra

	# Purpose: This procedure moves the mars bot to the destination point
	# Arguments:
	# $a0: The x coordinate of the destination point
	# $a1: The y coordinate of the destination point
	# Return value:
	# None
	move_bot:
		addi $sp, $sp, -4												#Adds -4 to stack pointer
		lw $t0, 0($s2)													#Loads the current x coordinate
		lw $t1, 0($s3)													#Loads the current y coordinate
		bne $a0, $t0, check_y											#Check if current and next x is equal
		bne $a1, $t1, move_y											#Check if current and next y is equal
		jr $ra															#Do nothing if the current point is the same as the next 
		move_y:
			blt $a1, $t1, move_up										#Check if current y > next y
			li $t2, 180													#Loads 180 to $t2
			sw $t2, 0($s0)												#Direction = 180
			sw $s5, 0($s4)												#Tells bot to move
			not_y1:														#Loops while current y is not equal to target y
				lw $t3, 0($s3)
				sub $t3 $t3, $a1
				blt $t3, $zero, not_y1
				sw $zero, 0($s4)
				addi $sp, $sp, 4
				jr $ra
			move_up:
				sw $zero, 0($s0)										#Direction = 0
				sw $s5, 0($s4)											#Tells bot to move
				not_y2:													#Loops while current y is not equal to target y
					lw $t3, 0($s3)
					sub $t3, $t3, $a1
					bgt $t3, $zero, not_y2
					sw $zero, 0($s4)
					addi $sp, $sp, 4
					jr $ra
		check_y:
			bne $a1, $t1, move_with_angle								#Check if y coordinate will also change
			blt $a0, $t0, move_left										#Check if current x > next x
			li $t2, 90													#Loads 90 to $t2
			sw $t2, 0($s0)												#Direction = 90
			sw $s5, 0($s4)												#Tells bot to move
			not_x1:														#Loops while current x is not equal to target x
				lw $t3, 0($s2)
				sub $t3, $t3, $a0
				blt $t3, $zero, not_x1
				sw $zero, 0($s4)
				addi $sp, $sp, 4
				jr $ra
			move_left:
				li $t2, 270												#Loads 270 to $t2
				sw $t2, 0($s0)											#Direction = 270
				sw $s5, 0($s4)											#Tells bot to move
				not_x2:													#Loops while current x is not equal target x
					lw $t3, 0($s2)
					sub $t3, $t3, $a0
					bgt $t3, $zero, not_x2
					sw $zero, 0($s4)
					addi $sp, $sp, 4
					jr $ra
		move_with_angle:												#Follow a straight line path after computing for angle
			move $s7, $ra
			jal compute_arctan											#Computes the arctan of the angle between two points
			move $ra, $s7
			
			move $t4, $v0												#The value of arctan
			bgt $a0, $t0, check_y2										#Checks if next x > current x
			bgt $a1, $t1, move_SW										#Check if next y > current y
			bgt $t2, $t3, add_270										#Checks if change in x > change in y
			
			subi $t4, $t4, 360											#Subtracts 360 from the angle
			abs $t4, $t4												#Gets the absolute value of the angle
			sw $t4, 0($s0)												#Direction = $t4
			sw $s5, 0($s4)												#Tells bot to move
			not_y3:														#Loops while current y is not equal to target y
				lw $t3, 0($s3)
				sub $t3, $t3, $a1
				bgt $t3, $zero, not_y3
				sw $zero, 0($s4)
				move $s7, $ra
				jal move_bot
				move $ra, $s7
				addi $sp, $sp, 4
				jr $ra
			add_270:
				addi $t4, $t4, 270										#Adds 270 to the angle
				sw $t4, 0($s0)											#Direction = $t4
				sw $s5, 0($s4)											#Tells bot to move
				not_x3:													#Loops while current x is note equal to target x
					lw $t3, 0($s2)										
					sub $t3, $t3, $a0
					bgt $t3, $zero, not_x3
					sw $zero, 0($s4)
					move $s7, $ra
					jal move_bot
					move $ra, $s7
					addi $sp, $sp, 4
					jr $ra
			move_SW:
				bgt $t2, $t3, sub_from_270								#Checks of change in x > change in y
				addi $t4, $t4, 180										#Adds 180 to the angle
				sw $t4,0($s0)											#Direction = $t4
				sw $s5, 0($s4)											#Tells bot to move
				not_y4:													#Loops while current y is not equal to target y
					lw $t3, 0($s3)
					sub $t3, $t3, $a1
					blt $t3, $zero, not_y4
					sw $zero, 0($s4)
					move $s7, $ra
					jal move_bot
					move $ra, $s7
					addi $sp, $sp, 4
					jr $ra
				sub_from_270:
					subi $t4, $t4, 270									#Subtracts 270 from the angle
					abs $t4, $t4										#Gets the absolute value of the angle
					sw $t4, 0($s0)										#Direction = $t4
					sw $s5, 0($s4)										#Tells bot to move
					not_x4:												#Loops while current x is not equal to target x
						lw $t3, 0($s2)
						sub $t3, $t3, $a0
						bgt $t3, $zero, not_x4
						sw $zero, 0($s4)
						move $s7, $ra
						jal move_bot
						move $ra, $s7
						addi $sp, $sp, 4
						jr $ra

			check_y2:
				bgt $a1, $t1, move_SE									#Checks if next y > current y
				bgt $t2, $t3, sub_from_90								#Checks if change in x > change in y
				sw $t4, 0($s0)											#Direction = $t4
				sw $s5, 0($s4)											#Tells bot to move
				not_y5:													#Loops while current y is not equal to target y
					lw $t3, 0($s3)
					sub $t3, $t3, $a1
					bgt $t3, $zero, not_y5
					sw $zero, 0($s4)
					move $s7, $ra
					jal move_bot
					move $ra, $s7
					addi $sp, $sp, 4
					jr $ra
				sub_from_90:
					subi $t4, $t4, 90									#Subtracts 90 from the angle
					abs $t4, $t4										#Gets the absoluve value of the angle
					sw $t4, 0($s0)										#Direction = $t4
					sw $s5, 0($s4)										#Tells bot to move
					not_x5:												#Loops while current x is not equal to target y
						lw $t3, 0($s2)
						sub $t3, $t3, $a0
						blt $t3, $zero, not_x5
						sw $zero, 0($s4)
						move $s7, $ra
						jal move_bot
						move $ra, $s7
						addi $sp, $sp, 4
						jr $ra
				move_SE:
					bgt $t2, $t3, add_90								#Checks if change in x> change in y
					subi $t4, $t4, 180									#Subtracts 180 from the angle
					abs $t4, $t4										#Gets the absolute value of the angle
					sw $t4, 0($s0)										#Direction = $t4
					sw $s5, 0($s4)										#Tells bot to move
					not_y6:												#Loops while current y is not equal to target y
						lw $t3, 0($s3)
						sub $t3, $t3, $a1
						blt $t3, $zero, not_y6
						sw $zero, 0($s4)
						move $s7, $ra
						jal move_bot
						move $ra, $s7
						addi $sp, $sp, 4
						jr $ra
					add_90:
						addi $t4, $t4, 90								#Adds 90 to the angle
						sw $t4, 0($s0)									#Direction = $t4
						sw $s5, 0($s4)									#Tells bot to move
						not_x6:											#Loops while current x is not equal to target x
							lw $t3, 0($s2)
							sub $t3, $t3, $a0
							blt $t3, $zero, not_x6
							sw $zero, 0($s4)
							move $s7, $ra
							jal move_bot
							move $ra, $s7
							addi $sp, $sp, 4
							jr $ra

	# Purpose: This procedure approximates the arc tan
	# Arguments:
	# $a0: The x coordinate of destination point
	# $a1: The y coordinate of destination point
	# Return value:
	# $v0: The arc tan
		compute_arctan:
			sub $t2, $t0, $a0											#Computes the change in x
			abs $t2, $t2									
			sub $t3, $t1, $a1											#Computes the change in y
			abs $t3, $t3

			mtc1 $t2, $f1												#Moves values to coproc 1
			mtc1 $t3, $f2
			cvt.s.w $f1, $f1											#Convert values from word to single precision
			cvt.s.w $f2, $f2
			bgt $t2, $t3, divf2byf1										#Check if change in x > change in y
			div.s $f3, $f1, $f2											#Computes the tangent
			j taylor													#Compute arc tan using taylor series

			divf2byf1:
				div.s $f3, $f2, $f1										#Computes the tangent
			
			taylor:														#Computes the summation from n=1 to n=30
				li $t4, 0												# ((-1)^n(x)^(2n+1))/(2n+1)
			loop:
				remu $t5, $t4, 2
				beq $t5, 1, negative
				
				add $t5, $t4, $t4
				addi $t5, $t5, 1
				move $t6, $t5
				li $t7, 1
				mtc1 $t7, $f4
				cvt.s.w $f4, $f4
				loop1:
				mul.s $f4, $f4, $f3
				sub $t5, $t5, 1
				bne $t5, 0, loop1
				j continue
				negative:
					add $t5, $t4, $t4
					addi $t5, $t5, 1
					move $t6, $t5
					li $t7, 1
					mtc1 $t7, $f4
					cvt.s.w $f4, $f4
					loop2:
						mul.s $f4, $f4, $f3
						sub $t5, $t5, 1
						bne $t5, 0, loop2
						neg.s $f4, $f4

				continue:
					mtc1 $t6, $f5
					cvt.s.w $f5, $f5
					div.s $f4, $f4, $f5
					addi $sp, $sp, -4
					s.s $f4, 0($sp)
					addi $t4, $t4, 1
					bne $t4, 30, loop
				
				loop_summation:
					l.s $f5, 0($sp)
					addi $sp, $sp, 4
					add.s $f6, $f6, $f5
					addi $t4, $t4, -1
					bne $t4, 0, loop_summation
					li $t7, 1113927451
					mtc1 $t7, $f5
					mul.s $f6, $f6, $f5
					round.w.s $f6, $f6
					mfc1 $v0,$f6
					jr $ra


	# Purpose: This procedure draws my initials
	# Arguments:
	# None
	# Return value:
	# None
	make_initial:
		addi $sp, $sp, -4													#Adds -4 to stack pointer
		sw $s6, 0($sp)														#Stores $s6 in stack pointer
		la $s6, letterr														#Loads address of letterr
		lw $a0, 0($s6)														#Loads the first word in $s6
		move $a2, $ra														#Moves the return address to $a2
		jal get_components													#Gets components
		move $ra, $a2														#Moves $a2 to $ra
		move $a0, $v0														#Stores the x coordinate in $a0
		move $a1, $v1														#Stores the y coordinate in $a1
		sw $zero, 0($s1)													#Do not leave mark
		jal move_bot														#Move bot
		addi $s6, $s6, 4
		lw $a0, 0($s6)
		go_to_point2:														#Loops to tell bot to go through points until $a0 = -1
			bne $a0, -1, go_to_point3
			j do_box_in_r
			go_to_point3:
				jal get_components
				move $a0, $v0
				move $a1, $v1
				sw $s5, 0($s1)
				jal move_bot
				sw $zero, 0($s1)
				addi $s6, $s6, 4
				lw $a0, 0($s6)
				j go_to_point2

		do_box_in_r:
			la $s6, box_in_r												#Loads address of box_in_r
			lw $a0, 0($s6)													#Loads the first word in $s6
			jal get_components												#Gets components
			move $a0, $v0													#Stores the x coordinate in $a0
			move $a1, $v1													#Stores the y coordinate in $a1
			sw $zero, 0($s1)												#Do not leave mark
			jal move_bot													#Move bot
			addi $s6, $s6, 4
			lw $a0, 0($s6)
			go_to_point4:													#Loops to tell bot to go through points until $a0 = -1
				bne $a0, -1, go_to_point5
				j do_x
				go_to_point5:
					jal get_components
					move $a0, $v0
					move $a1, $v1
					sw $s5, 0($s1)
					jal move_bot
					sw $zero, 0($s1)
					addi $s6, $s6, 4
					lw $a0, 0($s6)
					j go_to_point4

		do_x:
			la $s6, letterx													#Loads address of letterx
			lw $a0, 0($s6)													#Loads the first word in $s6
			jal get_components												#Gets components
			move $a0, $v0													#Stores the x coordinate in $a0
			move $a1, $v1													#Stores the y coordinate in $a1
			sw $zero, 0($s1)												#Do not leave mark
			jal move_bot													#Move bot
			addi $s6, $s6, 4
			lw $a0, 0($s6)
			go_to_point6:													#Loops to tell bot to go through points until $a0 = -1
				bne $a0, -1, go_to_point7
				j do_b
				go_to_point7:
					jal get_components
					move $a0, $v0
					move $a1, $v1
					sw $s5, 0($s1)
					jal move_bot
					sw $zero, 0($s1)
					addi $s6, $s6, 4
					lw $a0, 0($s6)
					j go_to_point6
		do_b:
			la $s6, letterb													#Loads address of letterb						
			lw $a0, 0($s6)													#Loads the first word in $s6
			jal get_components												#Gets components
			move $a0, $v0													#Stores the x coordinate in $a0
			move $a1, $v1													#Stores the y coordinate in $a1
			sw $zero, 0($s1)												#Do not leave mark
			jal move_bot													#Move bot
			addi $s6, $s6, 4
			lw $a0, 0($s6)
			go_to_point8:													#Loops to tell bot to go through points until $a0 = -1
				bne $a0, -1, go_to_point9
				j do_upperbox
				go_to_point9:
					jal get_components
					move $a0, $v0
					move $a1, $v1
					sw $s5, 0($s1)
					jal move_bot
					sw $zero, 0($s1)
					addi $s6, $s6, 4
					lw $a0, 0($s6)
					j go_to_point8

		do_upperbox:
			la $s6, upperbox												#Loads address of upperbox
			lw $a0, 0($s6)													#Loads the first word in $s6
			jal get_components												#Gets components
			move $a0, $v0													#Stores the x coordinate in $a0
			move $a1, $v1													#Stores the y coordinate in $a1
			sw $zero, 0($s1)												#Do not leave mark
			jal move_bot													#Move bot
			addi $s6, $s6, 4
			lw $a0, 0($s6)
			go_to_point10:													#Loops to tell bot to go through points until $a0 = -1
				bne $a0, -1, go_to_point11
				j do_lowerbox
				go_to_point11:
					jal get_components
					move $a0, $v0
					move $a1, $v1
					sw $s5, 0($s1)
					jal move_bot
					sw $zero, 0($s1)
					addi $s6, $s6, 4
					lw $a0, 0($s6)
					j go_to_point10
	
		do_lowerbox:
			la $s6, lowerbox												#Loads address of lowerbox
			lw $a0, 0($s6)													#Loads the first word in $s6
			jal get_components												#Gets components
			move $a0, $v0													#Stores the x coordinate in $a0
			move $a1, $v1													#Stores the y coordinate in $a1
			sw $zero, 0($s1)												#Do not leave mark
			jal move_bot													#Move bot
			addi $s6, $s6, 4												
			lw $a0, 0($s6)
			go_to_point12:													#Loops to tell bot to go through points until $a0 = -1
				bne $a0, -1, go_to_point13
				li $a0, 120
				li $a1, 500
				sw $zero, 0($s1)
				jal move_bot
				move $ra, $a2
				jr $ra
				go_to_point13:
					jal get_components
					move $a0, $v0
					move $a1, $v1
					sw $s5, 0($s1)
					jal move_bot
					sw $zero, 0($s1)
					addi $s6, $s6, 4
					lw $a0, 0($s6)
					j go_to_point12
						
	# Purpose: Terminates the progran
	# Arguments:
	# None
	# Return value:
	# None	
	exit:
		li $v0, 10
		syscall