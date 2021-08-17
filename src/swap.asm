# This file contains a function that swaps the values at two addresses.
# Executing this file will print two values, swap them, and print them again.

.data
	newline: .asciiz "\n"
	a: .word 1
	b: .word 2

.text

# Print the value at a and b, then swap them, then print them again.
main:
	# printf("%d %d\n", a, b)
	lw $a0 a 
	li $v0 1
	syscall # print number
	li $a0 ' '
	li $v0 11
	syscall # print character
	lw $a0 b 
	li $v0 1
	syscall # print number
	la $a0 newline
	li $v0 4
	syscall # print string
	
	# swap(a, b)
	la $a0 a
	la $a1 b
	jal swap
	
	# printf("%d %d\n", a, b)
	lw $a0 a 
	li $v0 1
	syscall
	li $a0 ' '
	li $v0 11
	syscall
	lw $a0 b 
	li $v0 1
	syscall
	la $a0 newline
	li $v0 4
	syscall

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
	