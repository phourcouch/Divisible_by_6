.data

equalSigns: .asciiz "\n========================================================================"

prompt_input: .asciiz "\nHow many positive numbers that are divisable by 6 do you want to add?\n"

enter_num: .asciiz "\nEnter a number: "

error_output: .asciiz  "==> **** ERROR: "


normal_output: .asciiz  "==> "

negative_output: .asciiz " is not a postive number. Enter another number."

outrange_output: .asciiz " is not in the range of 1 to 100. Enter another number."


notdiv_output: .asciiz " is not divisable by 6. Enter another number"

div_output: .asciiz " is divisble by 6"


sum_output: .asciiz "\nThe sum of the positive numbers between 1 and 100 that are divisable by 6 is: "


.text
main: 

#equal signs
li $v0, 4
la $a0,equalSigns 
syscall

li $v0, 4
la $a0,prompt_input 
syscall

li $v0, 5
syscall 

add $t0,$v0,$0#input


li $t3,0#counter 
li $s0,0
li $t4,100

loop: 
 beq $t3,$t0,stop

li $v0, 4
la $a0,enter_num 
syscall

li $v0, 5
syscall 

add $t2,$v0,$0#input for chekcing if it is disvisble by a cetain number -- chekcing if causes error


blt $t2,$0,error1#checking if input is less than or equal to $0 (second regisiter) $t2 < 0 go to error 

bgt $t2,$t4,error2#chekcing if out of range (100)
ble   $t2,$0,error2# checking if less than 0

li $t6,6#x is divisble by $t6 (6) 

div $t2,$t6#x/6

mfhi $t7#remainder

bne $t7,$0,error3#if remainder is not 0 it means input is not divisvle by 6 so go to error message


li $v0,4
la $a0, normal_output
syscall

li $v0,1
add $a0,$t2,$0#print out input if it is divislbe 
syscall

li $v0,4
la $a0, div_output
syscall

add $s0,$s0,$t2#sum += divisble input
addi $t3,$t3,1#i++
j loop

error1:


li $v0,4
la $a0, error_output
syscall

li $v0,1
add $a0,$t2,$0
syscall

li $v0,4
la $a0, negative_output
syscall
j loop

error2:

li $v0,4
la $a0, error_output
syscall

li $v0,1
add $a0,$t2,$0
syscall

li $v0,4
la $a0, outrange_output
syscall
j loop

error3:

li $v0,4
la $a0, normal_output
syscall

li $v0,1
add $a0,$t2,$0
syscall

li $v0,4
la $a0, notdiv_output
syscall
j loop

stop:

li $v0,4
la $a0, sum_output
syscall

li $v0,1
add $a0,$s0,$0#print out sum
syscall

li $v0, 4
la $a0,equalSigns 
syscall


li $v0,10
syscall
