# This file contains a function that prints an array.
# Executing this file will print the array [3, 2, 4, 5, 6]

.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5

.text

# Calls printArray using the array [3, 2, 4, 5, 6]
main:
	# Print array before swap operation
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
	# Terminate the program
	li $v0 10
	syscall

# Print the contents of an array
# Arguments
#	$a0 - the base address of the array
# 	$a1 - the length of the array
# Register Usage
# 	$t0 - array base address
# 	$t1 - i
#	$t2 - array length
#	$t3 - address of array[i]
# 	$v0 - used for syscall
printArray:
	move $t0 $a0 # base address of array
	li $t1 0 # i = 0
	move $t2 $a1 # the number of elements in array
	
	printArray_BeginWhile: # while(i < arraySize)
	blt $t1 $t2 printArray_While
	j printArray_EndWhile
	printArray_While:
	
	# Calculate the address of array[i]
	sll $t3 $t1 2 # multiply i by 4 to get the offset
	add $t3 $t0 $t3 # add the base address and the offset
	
	# Load and print array[i]
	lw $a0 ($t3)
	li $v0 1
	syscall
	
	# Print a space character
	li $a0 32 # code for space
	li $v0 11 # code to print a character
	syscall
	
	# i++
	addi $t1 $t1 1
	
	j printArray_BeginWhile
	printArray_EndWhile:
		
	# Print a new line character
	li $a0 10 # code for new line
	li $v0 11 # code to print a character
	syscall
	
	# Return
	jr $ra