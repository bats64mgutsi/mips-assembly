.text

main:
  la $a0, askForInputStr
  la $v1, Cont1
  j Print

  Cont1:
  li $a1, 20

  la $a0, str1Buffer
  la $t0, Cont2
  j ReadString
  
  Cont2:
  la $a0, str2Buffer
  la $t0, Cont3
  j ReadString  

  Cont3:
  la $a0, str3Buffer
  la $t0, Cont4
  j ReadString

  # Printing

  Cont4:
  la $a0, displayOutputStr
  la $v1, Cont4a
  j Print

  Cont4a:
  la $a0, str3Buffer
  la $v1, Cont5
  j Print

  Cont5:
  la $a0, str1Buffer
  la $v1, Cont6
  j Print

  Cont6:
  la $a0, str2Buffer
  la $v1, Exit
  j Print

ReadString:
  # The address to write the input to should be in
  # $a0. And $a1 contains the nr of characters to read.
  # $t0 is the return address
  li $v0, 8
  syscall
  jr $t0

Print:
  # $a0 should be initialised to the address of string to print
  # $a1 should contain the return address
  li $v0, 4
  syscall
  jr $v1


Exit:
  li $v0, 10
  syscall

.data
askForInputStr: .asciiz "Enter a list of 3 lines:\n"
displayOutputStr: .asciiz "The reordered list is:\n"

str1Buffer: .space 20
str2Buffer: .space 20
str3Buffer: .space 20