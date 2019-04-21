#sorting Array 
	addi $t0,$zero, 0
	addi $t1,$zero, 1
	addi $t2,$zero, 1
	la   $a0,array
	loop:
	bgt  $t1, 144, continue
	addi $t1,$t1, 1
	l.s  $f20, 0($a0)           # sets $t0 to the current element in array
        l.s  $f21, 4($a0)     # sets $t1 to the next element in array
        c.lt.s $f21,$f20       # if the following value is greater, swap them
	bc1t swap
	bgt  $t2, 12, initialize
	addi $t2,$t2, 1
        addi $a0, $a0, 4     # advance the array to start at the next location from last time
        j  loop                  # jump back to loop so we can compare next two elements

	swap:       
	s.s  $f20, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
        s.s  $f21, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
        la  $a0, array                 # resets the value of $a0 back to zero so we can start from beginning of array
        j   loop   
	
	initialize:
	la  $a0, array 