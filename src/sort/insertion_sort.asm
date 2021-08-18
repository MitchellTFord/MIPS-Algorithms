
.data
	array: .word 3, 2, 4, 5, 6
	arraySize: .word 5

.text
main:
	# Terminate the program
	li $v0 10
	syscall

insertionSort:
	# Return
	jr $ra
