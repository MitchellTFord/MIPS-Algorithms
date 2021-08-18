# This file contains a function that swaps the values at two indices of an array.
# Executing this file will print the array, perform a swap, and print it again.

.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5

.text

# Print array, swap array[1] and array[2], and print it again
main:
	# Print array before swap operation
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
	# Swap array[1] and array[2]
	li $a0 1
	li $a1 2
	la $a2 array
	jal swapByIndex
	
	# Print array after swap operation
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
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

# Swap the values at two indices of an array
# Arguments
# 	$a0 - the first index
# 	$a1 - the second index
#	$a2 - the base address of the array
# Register Usage
#	$a0 - changed to the address of array[$a0]
#	$a1 - changed to the address of array[$a1]
swapByIndex:
	# Calculate the address of array[$a0]
	sll $a0 $a0 2 # calculate the offset
	add $a0 $a0 $a2 # add base address to the offset
	
	# Calculate the address of array[$a1]
	sll $a1 $a1 2 # calculate the offset
	add $a1 $a1 $a2 # add the base address to the offset
	
	# Save $ra to stack
	addi $sp $sp -4
	sw $ra ($sp)
	
	# swap(array[i],array[j])
	jal swap
	
	# Load $ra from stack
	lw $ra ($sp)
	addi $sp $sp 4
	
	# Return
	jr $ra

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
