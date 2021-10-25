.text

main:
  la $a0, askForInputStr
  jal Print

  li $a1, 20

  la $a0, str1Buffer
  jal ReadString
  
  la $a0, str2Buffer
  jal ReadString  

  la $a0, str3Buffer
  jal ReadString

  # Printing

  la $a0, displayOutputStr
  jal Print

  la $a0, str3Buffer
  jal Print

  la $a0, str1Buffer
  jal Print

  la $a0, str2Buffer
  la $ra, Exit
  j Print

ReadString:
  # The address to write the input to should be in
  # $a0. And $a1 contains the nr of characters to read.
  # $ra is the return address
  li $v0, 8
  syscall
  jr $ra

Print:
  # $a0 should be initialised to the address of string to print
  # $ra should contain the return address
  li $v0, 4
  syscall
  jr $ra

Exit:
  li $v0, 10
  syscall

.data
askForInputStr: .asciiz "Enter a list of 3 lines:\n"
displayOutputStr: .asciiz "The reordered list is:\n"

str1Buffer: .space 20
str2Buffer: .space 20
str3Buffer: .space 20