.data
	array:     	 .space 50 # 4bytes * 12 floating point numbers 
	message:   	 .asciiz "Enter 12 floating point numbers:"
	positiveMessage: .asciiz "Count of positive numbers:"
	negativeMessage: .asciiz "Count of negative numbers:"
	space: 		 .asciiz "\n"
	zeroFloat:	 .float 0.0
	oneFloat:  	 .float 1.0

.text
	lwc1 $f4, zeroFloat # the value of the ZeroFloat
	lwc1 $f5, oneFloat  # the value of the oneFloat
	lwc1 $f7, zeroFloat # value of the negative sum
	lwc1 $f8, zeroFloat # value of the positive sum
	
	
	#Display the entry message 
	li $v0, 4
	la $a0, message
	syscall 
	
	# Reading 12 floating pont numbers and save them in an array 
	addi $t1,$zero, 1
	addi $t0,$zero, 0
	
	
	reading:
	bgt $t1, 12, exit
	li  $v0, 6
	syscall
	
	#check if positive or negative number
	c.lt.s $f0,$f4
	bc1t countNegative
	c.lt.s $f0,$f4
	bc1f countPositive
	
	
	 
	countNegative:
	add.s $f7,$f7, $f5 
	j iterate
	
	countPositive:
	add.s $f8,$f8, $f5 
	j iterate
	 
	
	iterate:
	s.s $f0, array($t0) # $t0 = offset
	addi $t0,$t0, 4
	addi $t1,$t1, 1
	j reading
	
	exit:
	# print the count of negative numbers
	li $v0,4
	la $a0, negativeMessage   
	syscall

	li $v0,2
	mov.s $f12,$f7
	syscall
	
	# print new line 
	li $v0,4
	la $a0, space   
	syscall
	
	# print the count of positive numbers
	li $v0,4
	la $a0, positiveMessage   
	syscall

	li $v0,2
	mov.s $f12,$f8
	syscall