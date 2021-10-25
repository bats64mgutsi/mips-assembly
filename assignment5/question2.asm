.text

main:
  la $a0, prompt
  jal Print

  jal GetPrefixedStringInput
  # $s1 is the prefixed input buffer
  move $s1, $v0

  # $s2 holds the sum
  li $s2, 0

  WhileCheck:
    lb $t2, 0($s1)
    li $t0, 0
    bne $t2, $t0, WhileBody
    #
    move $a0, $s2
    la $ra, Exit
    j PrintSignedInteger

  WhileBody:
    lb $a0, 0($s1)
    jal IsCharInA0ADigit
    beq $v0, 1, CharIsANumber
    addi $s1, $s1, 1
    j WhileCheck

    CharIsANumber:
      # Load previous character (sign) into $t0
      addi $t0, $s1, -1
      lb $t0, 0($t0)
      # Convert value of ($s1) into a number into $t1
      lb $t1, 0($s1)
      addi $t1, $t1, -48
      
      # Increment next char position for next iteration
      addi $s1, $s1, 1

      la $t3, positiveSignSymbol
      lb $t3, 0($t3)
      beq $t3, $t0, DoAdd       # If prev char is '+'

      sub $s2, $s2, $t1
      j WhileCheck

      DoAdd:
        add $s2, $s2, $t1
        j WhileCheck



  move $a0, $s1
  jal Print
  j Exit

# --- Program library ---

GetPrefixedStringInput:
  # $v0 will contain address of read string
  # $ra should contain the return address
  # Uses: $a0, $a1, $s0, $s1, $s2, $t0, $t7
  move $t7, $ra           # Store return address
  li $a1, 50
  la $s0, inputBuffer
  addi $s1, $s0, 1
  move $a0, $s1
  jal ReadString

  lb $a0, 0($s1)
  jal IsCharInA0ADigit
  beq $v0, 1, PrependPositiveSignAndReturn

  move $v0, $s1
  jr $t7

  PrependPositiveSignAndReturn:
    la $s2, positiveSignSymbol
    lb $t0, 0($s2)
    sb $t0, 0($s0)
    #
    la $v0, inputBuffer
    jr $t7
    
IsCharInA0ADigit:
  # $a0 is the char to check
  # $v0 is the return value: 1 for true and 0 for false
  # $ra is the return address
  # Uses: $t0
  li $t0, 48
  bge	$a0, $t0, CheckHigherBound	# if $t0 >= $t1 then target
  j IsCharInA0ADigitElse

  CheckHigherBound:
    li $t0, 57
    ble	$a0, $t0, WhenMet	# if $t0 <= $t1 then target
    j IsCharInA0ADigitElse

      WhenMet:
        li $v0, 1
        jr $ra

  IsCharInA0ADigitElse:
    li $v0, 0
    jr $ra

# --- System ---

PrepareToPushWordToStack:
  # subi $sp, $sp, 4
  # Caller must do the following after calling this
  # sw $v0, 0($sp)
  jr $ra

CleanUpStackPop:
  # Caller must call following before calling this
  # lw $v0, 0($sp)
  # addi $sp, $sp, 4
  jr $ra

ReadString:
  # The address to write the input to should be in $a0.
  # And $a1 contains the nr of characters to read.
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

PrintSignedInteger:
  # Prints signed integer in $a0
  move $t7, $ra
  move $t6, $a0
  la $a0, newline
  jal Print

  move $a0, $t6
  li $v0, 1
  syscall

  jr $t7

Exit:
  li $v0, 10
  syscall

.data
inputBuffer: .space 52
positiveSignSymbol: .asciiz "+"
newline: .asciiz "\n"
prompt: .asciiz "Enter a sum: "