.text

main:
# Load pointer to name in a0, that's where the system is gonna find it
la $a0, name

# Syscall nr 4 tells system to print string in $a0
li $v0, 4
syscall

# Syscall nr 10 is exit
li $v0, 10
syscall



.data
name: .asciiz "My name is Batandwa.\n"
