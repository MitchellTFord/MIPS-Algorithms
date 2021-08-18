
.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5

.text
main:
	# Print array before sort
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
	# Sort the array
	la $a0 array
	lw $a1 arraySize
	jal insertionSort

	# Print array after sort
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
	# Terminate the program
	li $v0 10
	syscall

# Sort an array of numbers using the insertion sort algorithm
# Arguments
# 	$a0 - the base address of the array
#	$a1 - the length of the array
# Register Usage
#	$t0 - i
#	$t1 - j
#	$t2 - key
# Pseudocode
#   int i = 1;
#	while(i < arrayLength) {
#	  int key = array[i];
#	  int j = i - 1;
#	  while(j >=0 && array[j] < key) {
#		array[j + 1] = array[j];
#		j = j - 1;
#	  }
#	}
insertionSort:
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