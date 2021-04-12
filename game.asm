#####################################################################
#
# CSCB58 Winter2021Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Ssangwook Lee, 1006215800, leesa108
#
# Bitmap Display Configuration:
# -Unit width in pixels: 8 (update this as needed)
# -Unit height in pixels: 8 (update this as needed)
# -Display width in pixels: 256 (update this as needed)
# -Display height in pixels: 256 (update this as needed)
# -Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# -Milestone 1/2/3/4 (choose the one the applies)
#
# Which approved features have been implementedfor milestone 4?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
#... (add more if necessary)
#
# Link to video demonstration for final submission:
# -(insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
#Are you OK with us sharing the video with people outside course staff?
# - yes, and please share this project githublink as well!
#
# Any additional information that the TA needs to know:
# -(write here, if any)
#
#####################################################################

.eqv	BASE_ADDRESS	0x10008000
.eqv	GRAY 		0x808080
.eqv	YELLOW		0xFFFF00
.eqv	RED		0xFF0000
.eqv	BLUE		0x3f51b5
.eqv	WHITE		0xFFFFFF
.eqv	BLACK		0x000000
.eqv	GREEN		0x00FF00
	
.data
ROAD:	.word	3
END:	.word	1
HP:	.word	128
SPEED:	.word	1280
SCORE:	.word	0
CAR_LOCATION:	0x10008000
SPAWNRATE:	
	.word	0
SPAWNONE_LOC:
	.word	128
SPAWNONE_LANE:
	.word	0
SPAWNONE_COL:	0x808080
SPAWNTWO_LOC:
	.word	128
SPAWNTWO_LANE:
	.word	0
SPAWNTWO_COL:	0x808080
SPAWNTHR_LOC:
	.word	128
SPAWNTHR_LANE:
	.word	0
SPAWNTHR_COL:	0x808080
car_pix:	.word	0, 8, 12, 16, 132, 136, 140, 144, 148, 260, 264, 268, 272, 276, 280 
spawn_pix:	.word	4, 8, 12, 128, 132, 136, 140, 144, 260, 268
gameover_pix:	.word	0, 4, 8, 132, 12, 260, 16, 388, 268, 516, 272, 520, 28, 152, 400, 524, 32, 280, 528, 900, 408, 904, 164, 412, 536, 908, 1032, 292, 416, 912, 1160, 48, 172, 420, 916, 1288, 52, 300, 548, 1044, 1416, 56, 180, 428, 924, 1172, 1420, 308, 556, 1052, 1300, 1424, 188, 436, 1180, 1428, 68, 316, 564, 936, 1308, 72, 196, 444, 1064, 76, 324, 572, 944, 1192, 1440, 80, 328, 452, 948, 1072, 1320, 1444, 332, 580, 952, 1200, 336, 584, 956, 1204, 1328, 588, 1208, 1456, 592, 964, 1212, 1460, 596, 968, 1092, 1464, 972, 1220, 1468, 1348, 1104, 1352, 1476, 1232, 1356, 1604, 1488, 1620

.text	
start:
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	li $t1, GRAY		# $t1 stores the gray colour code
	li $t2, 4		# increment
	addi $t3, $t0, 4096	# bottom-right of screen
	jal fill		# fill the screen gray
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	li $t1, YELLOW		# $t1 stores the yellow colour code
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# draw top border
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 3840	# $t0 stores the base address for display
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# draw bottom border
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 3968	# $t0 stores the base address + 3968
	li $t1, RED		# $t1 stores the red colour code
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# draw health
	
	lw $t0, CAR_LOCATION	# set initial car location
	addi $t0, $t0, 1796
	sw $t0, CAR_LOCATION
	
main:	lw $t1, END
	beqz $t1, EXIT		# if end is 0, exit
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 768	# $t0 stores the base address + 640
	li $t1, GRAY		# $t1 stores the gray colour code
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# delete lane
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 1536	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# delete lane
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 2304	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# delete lane
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 3072	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill		# delete lane

	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 768	# $t0 stores the base address + 640
	li $t1, YELLOW		# $t1 stores the yellow colour code
	addi $t3, $t0, 128	# bottom-right of screen
	li $s0, 0
	lw $s1, ROAD
	jal fillroad		# draw first road line
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 1536	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	li $s0, 0
	jal fillroad		# draw second road line
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 2304	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	li $s0, 0
	jal fillroad		# draw third road line
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 3072	# $t0 stores the base address + 640
	addi $t3, $t0, 128	# bottom-right of screen
	li $s0, 0
	jal fillroad		# draw fourth road line
	
	li $t9, 0xffff0000 
	lw $t8, 0($t9)
	bne $t8, 1, draw_car_main
	lw $t1, 4($t9)	 	# this assumes $t9 is set to 0xfff0000 from before
	
w:	bne $t1, 0x77, a	# if w is pressed
	lw $t0, CAR_LOCATION	# $t0 stores the base address for display
	li $t3, BASE_ADDRESS
	addi $t3, $t3, 256 
	blt $t0, $t3, a
	subi $t0, $t0, 128
	sw $t0, CAR_LOCATION
	
	li $t1, GRAY		# $t1 stores the gray colour code
	sw $t1, 128($t0)
	sw $t1, 388($t0)
	sw $t1, 392($t0)
	sw $t1, 396($t0)
	sw $t1, 400($t0)
	sw $t1, 404($t0)
	sw $t1, 408($t0)	# delete previous pixels
	
a:	bne $t1, 0x61, s	# if a is pressed
	lw $t0, CAR_LOCATION	# $t0 stores the base address for display
	li $t3, BASE_ADDRESS
	sub $t5, $t0, $t3
	li $t4, 128
	div $t5, $t4
	mfhi $t3
	beqz $t3, s
	subi $t0, $t0, 4
	sw $t0, CAR_LOCATION	
	
	li $t1, GRAY		# $t1 stores the gray colour code
	sw $t1, 4($t0)
	sw $t1, 20($t0)
	sw $t1, 152($t0)
	sw $t1, 284($t0)	# delete previous pixels

s:	bne $t1, 0x73, d	# if s is pressed
	lw $t0, CAR_LOCATION	# $t0 stores the base address for display
	li $t3, BASE_ADDRESS
	addi $t3, $t3, 3456
	bgt $t0, $t3, d
	
	li $t1, GRAY		# $t1 stores the gray colour code
	sw $t1, 0($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)
	sw $t1, 16($t0)
	sw $t1, 132($t0)
	sw $t1, 148($t0)
	sw $t1, 280($t0)
	
	addi $t0, $t0, 128
	sw $t0, CAR_LOCATION	# delete previous pixels
	
d:	bne $t1, 0x64, p	# if d is pressed
	lw $t0, CAR_LOCATION	# $t0 stores the base address for display
	li $t3, BASE_ADDRESS
	sub $t5, $t0, $t3
	addi $t5, $t5, 28
	li $t4, 128
	div $t5, $t4
	mfhi $t3
	beqz $t3, draw_car_main
	
	li $t1, GRAY		# $t1 stores the gray colour code
	sw $t1, 0($t0)
	sw $t1, 8($t0)
	sw $t1, 132($t0)
	sw $t1, 260($t0)
	
	addi $t0, $t0, 4
	sw $t0, CAR_LOCATION	# delete previous pixels
	
p:	bne $t1, 0x70, draw_car_main	# if p is pressed
	
	sw $t0, END
	li $t0, 128
	sw $t0, HP
	sw $t0, SPAWNONE_LOC
	sw $t0, SPAWNTWO_LOC
	sw $t0, SPAWNTHR_LOC
	li $t0, 1280
	sw $t0, SPEED
	li $t0, BASE_ADDRESS
	sw $t0, CAR_LOCATION
	sw $zero, SCORE
	j start
	
draw_car_main:
	lw $t0, CAR_LOCATION	# $t0 stores the base address for display
	li $s0, 0
	jal draw_car		# draw fourth road line
	
	li $t3, 128
available_one:
	lw $t5, SPAWNONE_LOC
	bne $t5, $t3, available_two
	li $t4, 1
	j draw_obstacles
available_two:
	lw $t5, SPAWNTWO_LOC
	bne $t5, $t3, available_thr
	li $t4, 2
	j draw_obstacles
available_thr:
	lw $t5, SPAWNTHR_LOC
	bne $t5, $t3, check_spawn
	li $t4, 3
	
draw_obstacles:	
	lw $s2, SPAWNRATE
	bnez $s2, check_spawn
	
	li $v0, 42
	li $a0, 0
	li $a1, 15
	syscall
	
	li $s1, 5
	div $a0, $s1		
	mfhi $t7		# $t7 is the lane of the car	
	
red_car:
	li $t0, 4
	bgt $a0, $t0, green_car	# if the random is greater than 4, skip
	li $t1, RED		# $t1 stores the red colour code
	subi $t5, $t5, 20
	jal spawn
	li $t1, RED		# $t1 stores the red colour code
	j setup
	
green_car:
	li $t0, 9
	bgt $a0, $t0, yellow_car
	li $t1, GREEN		# $t1 stores the green colour code
	subi $t5, $t5, 20
	jal spawn
	li $t1, GREEN		# $t1 stores the green colour code
	j setup
	
yellow_car:
	li $t0, 14
	bgt $a0, $t0, count_road
	li $t1, YELLOW		# $t1 stores the yellow colour code
	subi $t5, $t5, 20
	jal spawn
	li $t1, YELLOW		# $t1 stores the yellow colour code
	
setup:
setup_one:
	li $t0, 1
	bne $t4, $t0, setup_two
	sw $t7, SPAWNONE_LANE
	sw $t1, SPAWNONE_COL
	sw $t5, SPAWNONE_LOC
	j check_spawn
setup_two:
	li $t0, 2
	bne $t4, $t0, setup_thr
	sw $t7, SPAWNTWO_LANE
	sw $t1, SPAWNTWO_COL
	sw $t5, SPAWNTWO_LOC
	j check_spawn
setup_thr:
	sw $t7, SPAWNTHR_LANE
	sw $t1, SPAWNTHR_COL
	sw $t5, SPAWNTHR_LOC
	
check_spawn:
	li $s5, 0
check_one:
	li $t3, 128
	lw $s3, SPAWNONE_LOC
	beq $s3, $t3, check_two
	lw $s4, SPAWNONE_LANE
	lw $t1, SPAWNONE_COL
	jal advance
	subi $s3, $s3, 4
	sw $s3, SPAWNONE_LOC

	jal collision
check_two:
	li $t3, 128
	lw $s3, SPAWNTWO_LOC
	beq $s3, $t3, check_thr
	lw $s4, SPAWNTWO_LANE
	lw $t1, SPAWNTWO_COL
	jal advance
	subi $s3, $s3, 4
	sw $s3, SPAWNTWO_LOC
	
	jal collision
	
check_thr:
	li $t3, 128
	lw $s3, SPAWNTHR_LOC
	beq $s3, $t3, count_road
	lw $s4, SPAWNTHR_LANE
	lw $t1, SPAWNTHR_COL
	jal advance
	subi $s3, $s3, 4
	sw $s3, SPAWNTHR_LOC

	jal collision
	
count_road:
	lw $s1, ROAD
	bne $s1, $zero, check_hp
	li $s1, 4
	
check_hp:
	beq $s5, 0, count_spawn
	
	lw $t0, HP
	subi $t0, $t0, 4
	sw $t0, HP
	
	bne $t0, 0, count_spawn
	sw $zero, END
	
count_spawn:
	lw $s2, SPAWNRATE
	bne $s2, $zero, count_speed
	li $s2, 7
	
count_speed:
	lw $s3, SPEED
	ble $s3, 480, loopmain
	subi $s3, $s3, 1
	sw $s3, SPEED
	
loopmain:

	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 3968	# $t0 stores the base address + 3968
	li $t1, BLACK		# $t1 stores the red colour code
	addi $t3, $t0, 128	# bottom-right of screen
	jal fill
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	lw $t4, HP
	addi $t0, $t0, 3968	# $t0 stores the base address + 3968
	li $t1, RED		# $t1 stores the red colour code
	add $t3, $t0, $t4	# bottom-right of screen
	jal fill
	
	subi $s1, $s1, 1
	sw $s1, ROAD
	
	subi $s2, $s2, 1
	sw $s2, SPAWNRATE
	
	lw $s2, SCORE
	addi $s2, $s2, 1
	sw $s2, SCORE
	
	lw $s2, SPEED
	srl $s2, $s2, 4
		
	li $v0, 32
	add $a0, $zero, $s2    	# Wait half a second (500 milliseconds)
	syscall
	
	j main

EXIT:	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	li $t1, BLACK		# $t1 stores the gray colour code
	li $t2, 4		# increment
	addi $t3, $t0, 4096	# bottom-right of screen
	jal fill		# fill the screen black
	
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
	addi $t0, $t0, 660
	li $t1, YELLOW		# $t1 stores the gray colour code
	la $s0, gameover_pix
	addi $s1, $s0, 440
	
gameover:
	beq $s0, $s1, display_score
	
	lw $s3, 0($s0)
	add $s3, $s3, $t0
	
	sw $t1, 0($s3)
	
	addi $s0, $s0, 4
	
	li $v0, 32
	li $a0, 5   		# Wait half a second (500 milliseconds)
	syscall
	
	j gameover
	
display_score:
	
	li $t0, BASE_ADDRESS
	addi $t0, $t0, 3084
	
	li $t1, WHITE
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 136($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 384($t0)
	sw $t1, 512($t0)
	
	sw $t1, 20($t0)
	sw $t1, 148($t0)
	sw $t1, 272($t0)
	sw $t1, 276($t0)
	sw $t1, 280($t0)
	sw $t1, 404($t0)
	sw $t1, 532($t0)
	sw $t1, 536($t0)
	
	sw $t1, 160($t0)
	sw $t1, 416($t0)
	
	addi $t0, $t0, 44
	
	lw $s1, SCORE
	ble $s1, 10000, print_score
	li $s1, 9999
	
print_score:
	li $s0, 1000
	div $s1, $s0 
	mflo $s0
	mfhi $s1
	jal print_num
	
	addi $t0, $t0, 16
	li $s0, 100
	div $s1, $s0 
	mflo $s0
	mfhi $s1
	jal print_num
	
	addi $t0, $t0, 16
	li $s0, 10
	div $s1, $s0 
	mflo $s0
	mfhi $s1
	jal print_num
	
	addi $t0, $t0, 16
	li $s0, 1
	div $s1, $s0 
	mflo $s0
	mfhi $s1
	jal print_num
	
end_loop:
	li $t9, 0xffff0000 
	lw $t0, 0($t9)
	bne $t0, 1, end_loop
	lw $t8, 4($t9)
	bne $t8, 0x70, end_loop	# if p is pressed
	
	sw $t0, END
	li $t0, 128
	sw $t0, HP
	sw $t0, SPAWNONE_LOC
	sw $t0, SPAWNTWO_LOC
	sw $t0, SPAWNTHR_LOC
	li $t0, 1280
	sw $t0, SPEED
	li $t0, BASE_ADDRESS
	sw $t0, CAR_LOCATION
	sw $zero, SCORE
	j start
	
# Write functions here...
fill:	beq $t0, $t3, return	# if $t0 reaches the bottom-right of the screen
	sw $t1, 0($t0)		# paint the unit. 
	add $t0, $t0, $t2	# increment $t0
	j fill			# loop back
	
fillroad:	
	beq $t0, $t3, return	# when $t0 reaches $t3, return
	bne $s0, $t2, paint	# if $s0 != 4, paint, else make $s0 = 0
	li $s0, 0
	
paint:	beq $s0, $s1, loop	# when $s0 is the same as $s1, skip to loop
	sw $t1, 0($t0)		# paint the unit. 
	
loop:	add $t0, $t0, $t2	# increment $t0
	addi $s0, $s0, 1
	j fillroad		# loop back
	
draw_car:
	li $t1, BLUE		# draw body
	sw $t1, 0($t0)
	sw $t1, 8($t0)
	sw $t1, 132($t0)
	sw $t1, 136($t0)
	sw $t1, 140($t0)
	sw $t1, 144($t0)
	sw $t1, 148($t0)
	sw $t1, 260($t0)
	sw $t1, 268($t0)
	sw $t1, 276($t0)
	sw $t1, 280($t0)
	
	li $t1, WHITE		# draw glass
	sw $t1, 12($t0)
	sw $t1, 16($t0)
	
	li $t1, BLACK		# draw tires
	sw $t1, 264($t0)
	sw $t1, 272($t0)
	
	j return
	
spawn:
	li $t0, BASE_ADDRESS	# $t0 stores the base address for display
one:
	bnez $t7, two
	addi $t0, $t0, 364
two:	li $s1, 1
	bne $t7, $s1, three
	addi $t0, $t0, 1132
three:	li $s1, 2
	bne $t7, $s1, four
	addi $t0, $t0, 1900
four:	li $s1, 3
	bne $t7, $s1, five
	addi $t0, $t0, 2668
five:	li $s1, 4
	bne $t7, $s1, draw_spawn
	addi $t0, $t0, 3436
draw_spawn:			# $t0 = position, $t1 = colour
	sw $t1, 8($t0)
	sw $t1, 12($t0)
	sw $t1, 128($t0)
	sw $t1, 132($t0)
	sw $t1, 136($t0)
	sw $t1, 140($t0)
	sw $t1, 144($t0)
	
	li $t1, WHITE
	sw $t1, 4($t0)
	
	li $t1, BLACK
	sw $t1, 260($t0)
	sw $t1, 268($t0)
	
	j return
	
advance:			# $s3 = location, $s4 = lane, $t1 = colour
	sw $ra, 0($sp)
	li $t0, BASE_ADDRESS
	li $t3, 768
	
	mult $t3, $s4
	mflo $t3
	addi $t3, $t3, 256
	add $t3, $t3, $s3
	add $t0, $t0, $t3
	subi $t0, $t0, 4

	jal draw_spawn
	
	li $t1, GRAY
	sw $t1, 16($t0)
	sw $t1, 148($t0)
	sw $t1, 264($t0)
	sw $t1, 272($t0)
	
	bne $s3, $zero, adv_return
	sw $t1, 8($t0)
	sw $t1, 12($t0)
	sw $t1, 128($t0)
	sw $t1, 132($t0)
	sw $t1, 136($t0)
	sw $t1, 140($t0)
	sw $t1, 144($t0)
	sw $t1, 4($t0)
	sw $t1, 260($t0)
	sw $t1, 268($t0)
	
	li $s3, 132
	
adv_return:
	lw $ra, 0($sp)
	jr $ra
	
return:	jr $ra

collision:			# $s3 = location, $s4 = lane, $s5 = bool
	sw $ra, 0($sp)
	li $t0, BASE_ADDRESS
	li $t3, 768
	
	mult $t3, $s4
	mflo $t3
	addi $t3, $t3, 256
	add $t3, $t3, $s3
	add $t0, $t0, $t3
	
	lw $t3, CAR_LOCATION
	
	la $s6, car_pix
	la $s7, spawn_pix
	
	addi $s0, $s6, 60
	addi $s1, $s7, 40
	
	
first_loop:
	beq $s0, $s6, floop_end
	lw $s2, 0($s6)
	add $s2, $s2, $t3
	
second_loop:
	beq $s1, $s7, sloop_end
	lw $s3, 0($s7)
	add $s3, $s3, $t0
	
	beq $s2, $s3, true
	
	addi $s7, $s7, 4
	j second_loop
sloop_end:
	la $s7, spawn_pix
	addi $s6, $s6, 4
	j first_loop
	
floop_end:
	lw $ra, 0($sp)
	jr $ra
	
true:
	addi $s5, $s5, 1
	j floop_end

print_num:			# $s0 = number, $t0 = location
	li $t1, WHITE
print_zero:
	bne $s0, $zero, print_one
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 136($t0)
	sw $t1, 256($t0)
	sw $t1, 264($t0)
	sw $t1, 384($t0)
	sw $t1, 392($t0)
	sw $t1, 512($t0)
	sw $t1, 516($t0)
	sw $t1, 520($t0)
	
print_one:
	bne $s0, 1, print_two
	
	sw $t1, 8($t0)
	sw $t1, 136($t0)
	sw $t1, 264($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	
print_two:
	bne $s0, 2, print_three
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 136($t0)
	sw $t1, 264($t0)
	sw $t1, 260($t0)
	sw $t1, 256($t0)
	sw $t1, 384($t0)
	sw $t1, 512($t0)
	sw $t1, 516($t0)
	sw $t1, 520($t0)
	
print_three:
	bne $s0, 3, print_four
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 136($t0)
	sw $t1, 264($t0)
	sw $t1, 260($t0)
	sw $t1, 256($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	sw $t1, 516($t0)
	sw $t1, 512($t0)
	
print_four:
	bne $s0, 4, print_five
	
	sw $t1, 0($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 136($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	
print_five:
	bne $s0, 5, print_six
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	sw $t1, 516($t0)
	sw $t1, 512($t0)
	
print_six:
	bne $s0, 6, print_seven
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 384($t0)
	sw $t1, 392($t0)
	sw $t1, 512($t0)
	sw $t1, 516($t0)
	sw $t1, 520($t0)
	
print_seven:
	bne $s0, 7, print_eight
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 136($t0)
	sw $t1, 264($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	
print_eight:
	bne $s0, 8, print_nine
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 136($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 384($t0)
	sw $t1, 392($t0)
	sw $t1, 512($t0)
	sw $t1, 516($t0)
	sw $t1, 520($t0)
	
print_nine:
	bne $s0, 9, return
	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 128($t0)
	sw $t1, 136($t0)
	sw $t1, 256($t0)
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	sw $t1, 392($t0)
	sw $t1, 520($t0)
	
	j return

	
	
	
	
	
