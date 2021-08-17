# This file contains a function that

.data
	a: .word 1
	b: .word 2

.text
main:
	# Terminate the program
	li $v0 10
	syscall
		
# Swap the values at two addresses.
# Arguments
#	$a0 - the first address
#	$a1 - the second address
swap:
	