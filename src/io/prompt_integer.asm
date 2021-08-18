# This file contains a function that prompts the user to enter an integer and returns the input

.data


.text

# Call promptInteger
main:
	# Terminate the program
	li $v0 10
	syscall

# Prompt the user to enter an integer and return the input
# Arguments
#	$a0 - the address of the prompt string
# Returns
#	$v0 - the integer entered by the user
promptInteger:
	# Print the prompt string
	li $v0 4
	
	# Get the user's input
	li $v0 5
	syscall
	
	# Return
	jr $ra
