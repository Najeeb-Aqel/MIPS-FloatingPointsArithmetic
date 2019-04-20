.data 
	message:   .asciiz "Enter 12 floating pont numbers"
	zeroFloat: .float 0.0
	



.text
	lwc1 $f4, zeroFloat
	
	#Display the message 
	li $v0, 4
	la $a0, message
	syscall 
	
	li $v0, 6
	li 
	ljij

	lkdfjkljdf
	lkdfjkljdfdsklfjlkj
	kjhfdjkh