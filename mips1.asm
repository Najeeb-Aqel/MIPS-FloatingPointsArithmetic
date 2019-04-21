.data
	array:     .space 100
	message:   .asciiz "Enter 12 floating point numbers:"
	zeroFloat: .float 0.0
	



.text
	lwc1 $f4, zeroFloat
	
	#Display the message 
	li $v0, 4
	la $a0, message
	syscall 
	
	# Reading 10 floating pont numbers and save them in an array 
	addi $t1,$zero, 1
	addi $t0,$zero, 0
	
	reading:
	bgt $t1, 12, exit
	li $v0, 6
	syscall
	swc1 $f0, array($t0) # $t0 = offset
	addi $t0,$t0, 8
	addi $t1,$t1, 1
	j reading
	
	exit:
	
	
	
