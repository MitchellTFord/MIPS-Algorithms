
.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5
	sortingMessage: .asciiz "Sorting...\n"

.text
main:
	# Print array before sort
	la $a0 array
	lw $a1 arraySize
	jal printArray
	
	# printf("Sorting...\n")
	la $a0 sortingMessage
	li $v0 4
	syscall # print string
	
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
#	$t3 - array[j]
#	$t4 - temp for and conditon
#	$t5 - temp for and conditon
# Pseudocode
#   int i = 1;
#	while(i < arrayLength) {
#	  int j = i - 1;
#	  int key = array[i];
#	  while(j >=0 && array[j] < key) {
#		array[j + 1] = array[j];
#		j = j - 1;
#	  }
#	  i = i + 1;
#	}
insertionSort:
	
	# i = 1;
	li $t0 1
	
	# while(i < arrayLength)
	insertionSort_BeginOuterWhile:
	
	blt $t0 $a1 insertionSort_OuterWhile
	j insertionSort_EndOuterWhile
	
	insertionSort_OuterWhile:
	
		# j = i - 1
		addi $t1 $t0 -1
		
		# key = array[i]
		sll $t2 $t0 2 # calculate the offset
		add $t2 $t2 $a0 # calculate the address of array[i]
		lw $t2 ($t2) # load array[i]
		
		# while(j >=0 && array[j] < key)
		insertionSort_BeginInnerWhile:
		
		sll $t3 $t1 2 # calculate the offset
		add $t3 $t3 $a0 # calculate the address of array[j]
		lw $t3 ($t3) # load array[j]
		
		slt $t4 $t1 $0 # temp1 = j < 0
		not $t4 $t4 # temp1 = !temp (j >= 0)
		
		slt $t5 $t3 $t2 # temp2 = array[j] < key
		
		and $t4 $t4 $t5 # temp1 = temp1 && temp2
		
		bne $t4 $0 insertionSort_InnerWhile
		j insertionSort_EndInnerWhile
		
		insertionSort_InnerWhile:
		
			# Inner loop body
			
			# j = j - 1
			addi $t1 $t1 -1
			
			j insertionSort_BeginInnerWhile
		
		insertionSort_EndInnerWhile:
		
		# i = i + 1
		addi $t0 $t0 1
		
		j insertionSort_BeginOuterWhile
	
	insertionSort_EndOuterWhile:
	
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