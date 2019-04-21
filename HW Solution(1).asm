.data 
	arr:  .space 120        # 120 bytes = 15 numbers * 8 bytes
	count_positive: .asciiz "\nThe count of positive numbers= "
	count_negative: .asciiz "\nThe count of negative numbers= "
	largest_value: .asciiz "\nThe largest value= "
	sum: .asciiz "\nThe sum of all numbers= "
	avg: .asciiz "\nThe average sum of all numbers= "
.text
	li $t0, 0
	la $t1,arr
	li $t2, 15
	li $t5,0
	li $t6,-99999999
	li $t7, 1
	mtc1 $t5,$f2
	mtc1 $t5,$f4
	mtc1 $t5,$f6
	mtc1 $t5,$f8
	mtc1 $t5,$f10
	
	mtc1 $t6,$f18
	cvt.d.w $f18,$f18 # convert from integer to double
	
	mtc1 $t7,$f20
	cvt.d.w $f20,$f20 # convert from integer to double

label1:
	mul $t3, $t0, 8
	addu $t4, $t3, $t1
	li $v0, 7
	syscall
	
	add.d $f4,$f4,$f20 	# Count the numbers	
	add.d $f10,$f10,$f0	# Sum of numbers
	
	c.lt.d $f0,$f18		# Find the largest value
	bc1f label4
bp:
	c.lt.d $f0,$f2
	bc1t label2
	c.lt.d $f0,$f2
	bc1f label3
	
	j label1
	
label2:
	add.d $f6,$f6, $f20   	# count of negative integers
	j done
	
label3: 
	add.d $f8,$f8, $f20   	# count of positive integers
	j done

label4:
	mov.d $f18,$f0		# the largest value
	j bp

done:				# store numbers in array
	s.d $f0, 0($t4)
	addi $t0, $t0,1
	blt $t0,$t2, label1
	
##############################

	# print the sum of numbers
	li $v0,4 
	la $a0, sum
	syscall

	li $v0,3
	mov.d $f12,$f10
	syscall	
##############################

	# print the average of numbers
	li $v0,4 
	la $a0, avg
	syscall
	
	div.d $f16,$f10,$f4	# The average sum of numbers 
	li $v0,3
	mov.d $f12,$f16
	syscall	
##############################
 
	# print the count of negative numbers
	li $v0,4
	la $a0, count_negative   
	syscall

	li $v0,3
	mov.d $f12,$f6
	syscall
##############################

	# print the count of positive numbers
	li $v0,4
	la $a0, count_positive   
	syscall

	li $v0,3
	mov.d $f12,$f8
	syscall
##############################
	
	# print the largest value of numbers
	li $v0,4
	la $a0, largest_value 
	syscall

	li $v0,3
	mov.d $f12,$f18
	syscall