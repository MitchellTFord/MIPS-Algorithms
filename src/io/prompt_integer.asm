# This file contains a function that prompts the user to enter an integer and returns the input
# Executing this file prompts the user for an integer then prints it back to them

.data

	prompt: .asciiz "Enter a number: "
	result: .asciiz "You entered: "

.text

# Call promptInteger using the prompt string
main:
	# input = promptInteger("Enter a number: ")
	la $a0 prompt
	jal promptInteger
	move $t0 $v0
	
	# Print the result string
	la $a0 result
	li $v0 4
	syscall
	
	# Print the user's input
	# printf("You entered: %d", input)
	move $a0 $t0
	li $v0 1
	syscall
	
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
	syscall
	
	# Get the user's input
	li $v0 5
	syscall
	
	# Return
	jr $ra
