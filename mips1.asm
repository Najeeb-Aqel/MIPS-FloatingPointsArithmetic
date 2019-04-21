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
	
	#sorting array
	main:
    	la  $t0, array      # Copy the base address of your array into $t1
    	add $t0, $t0, 48    # 4 bytes per int * 10 ints = 40 bytes                              
	outterLoop:             # Used to determine when we are done iterating over the Array
    	add $t1, $0, $0     # $t1 holds a flag to determine when the list is sorted
    	la  $a0, array      # Set $a0 to the base address of the Array
	innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    	l.s  $f20, 0($a0)         # sets $t0 to the current element in array
    	l.s   $f21, 4($a0)         # sets $t1 to the next element in array
    	#slt  $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
    	#beq $t5, $0, continue   # if $t5 = 1, then swap them
    	c.lt.s $f20,$f21       # if the following value is greater, swap them
	bc1t continue
    	add $t1, $0, 1          # if we need to swap, we need to check the list again
    	s.s  $f20, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
    	s.s  $f21, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
	continue:
    	addi $a0, $a0, 4            # advance the array to start at the next location from last time
    	bne  $a0, $t0, innerLoop    # If $a0 != the end of Array, jump back to innerLoop
    	bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
    	
	
	
	# print the values of the array 
	
	addi $t0,$zero, 0
	addi $t1,$zero, 1
	
	# print new line 
	li $v0,4
	la $a0, space   
	syscall
	
	print:
	bgt $t1, 12, done
	li $v0,2
	l.s $f12,array($t0)
	syscall
	# print new line 
	li $v0,4
	la $a0, space   
	syscall
	addi $t0,$t0, 4
	addi $t1,$t1, 1
	j print
	
	done:
	
	
	