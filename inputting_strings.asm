.text

main:

la $a0, myWord
# How many chars to accept. Will only accept 19 characters, last char is null characte
li $a1, 20 

# Tell system we want to read string from console
li $v0, 8
syscall

# Print: "You entered ${myWord}"
la $a0, youEntered
li $v0, 4
syscall
la $a0, myWord
li $v0, 4
syscall

li $v0, 10
syscall

.data
# An ASCI string filled with 20 null characters
myWord: .space 20
youEntered: .asciiz "\nYou entered "