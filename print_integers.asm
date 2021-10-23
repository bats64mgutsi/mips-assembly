# To print integers, place the integer to print in $a0 and then syscall
# with 1. The integer will be printed as a decimal.

.text

main:

li $a0, -45
syscall

li $v0, 10
syscall

.data
