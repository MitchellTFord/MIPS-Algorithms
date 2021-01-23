# This program contains a function that calculates the factorial of a positive integer.

.data
	prompt: .asciiz "Enter a positive integer to get the factorial of: "
	result: .asciiz "Result: "

.text

# Prompts the user to enter a positive integer,
# then calculates its factorial using the factorial_iterative function
# and prints it to the console.
# Arguments
#	None
# Returns
# 	None
# Register Usage
#	$t0 - x (the user's input)
#	$t1 - x! (the result of the factorial)
main:
	# printf("Enter a positive integer to get the factorial of: ")
	li $v0 4
	la $a0 prompt
	syscall
	
	# scanf("%d", input)
	li $v0 5
	syscall
	
	# int x = input
	move $t0 $v0
	
	# result = factorial(x)
	move $a0 $t0
	jal factorial
	move $t1 $v0
	
	# printf("Result: %d", result)
	li $v0 4
	la $a0 result
	syscall
	li $v0 1
	move $a0 $t1
	syscall
	
	# printf("%d", result)
	move $a0 $t1
	li $v0 1
	syscall
	
	# Terminate the program
	li $v0 10
	syscall

# Calculate the factorial of x (x!) given a positive integer x
# Arguments
# 	$a0 - x
# Returns
#	$v0 - x!
# Register Usage
# 	$a0 - modified during execution
factorial:
	# int product = 1
	li $v0 1
	
	# while(x != 0)
	factorial_loop_start:
		beqz $a0 factorial_loop_finish
		
		# product *= x
		mult $v0 $a0
		mflo $v0
		
		# x--
		addi $a0 $a0 -1
		
		b factorial_iterative_loop_start
		
	factorial_loop_finish:
		# return product
		jr $ra
