
.data



.text

main:
	# Terminate the program
	li $v0 10
	syscall

# Swap the values at two addresses.
# Arguments
#	$a0 - the first address
#	$a1 - the second address
# Register Usage
# 	$t0 - temporary for swapping
# 	$t1 - temporary for swapping
swap:
	# Load values into registers
	lw $t0 ($a0)
	lw $t1 ($a1)
	
	# Store swapped values back in memory
	sw $t0 ($a1)
	sw $t1 ($a0)
	
	# Return
	jr $ra