.data

.text

main:
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
isPrime:
	# i = 2
	li $t0 2
	
isPrime_LoopStart:
	# while(i < x)
	bltu $t0 $a0 isPrime_LoopBody
	j isPrimeLoopEnd
isPrime_LoopBody:
	
	# Check divisibility here
	
	# i++
	addi $t0 $t0 1
	j isPrimeLoopStart
isPrime_LoopEnd:
	# Return 1 (true)
	li $v0 1
	jr $ra
