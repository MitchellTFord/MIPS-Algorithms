.data

.text

main:
	# prime = isPrime(27)
	li $a0 27
	jal isPrime
	# printf("%d", prime)
	move $a0 $v0
	li $v0 1
	syscall
	# Terminate the program
	li $v0 10
	syscall
	

# Determine whether a number is prime.
# Arguments
#	$a0 - x, the number to check the primality of, must be a positive number
# Returns
#	$v0 - 1 if x is prime, 0 otherwise
# Register Usage
#	$t0 - i, the loop counter
#	$t1 - n, the max number to check
#	$t2 - r, remainder of x/i
isPrime:
	# i = 2
	li $t0 2
	# n = x - 1 (can be lowered to speed up execution)
isPrime_LoopStart:
	# while(i < x)
	bltu $t0 $a0 isPrime_LoopBody
	j isPrime_LoopEnd
isPrime_LoopBody:
	# r = remainder of x/i
	remu $t2 $a0 $t0
	bnez $t2 isPrime_IfNotAFactor 
	# A factor was found
	# Return 0 (false)
	li $v0 0
	jr $ra
isPrime_IfNotAFactor:
	# i++
	addi $t0 $t0 1
	j isPrime_LoopStart
isPrime_LoopEnd:
	# Return 1 (true)
	li $v0 1
	jr $ra
