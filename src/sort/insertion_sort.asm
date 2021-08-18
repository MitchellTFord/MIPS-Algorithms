
.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5

.text
main:
	# Terminate the program
	li $v0 10
	syscall

# Sort an array of numbers using the insertion sort algorithm
# Arguments
# 	$a0 - the base address of the array
#	$a1 - the length of the array
insertionSort:
	# Return
	jr $ra
