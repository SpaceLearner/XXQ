##
######## by David Guo
####     count max
##       8-28-2018
########################

######### data segment ##########
        .data
input_string_num    .asciiz     "Please input the number of string:\n"
input_string_buf    .asciiz     "Please input the integers you want:\n"

integer_buf         .space      15
integer_count       .space      36    

######### text segment ##########
        .text
        .globl main

main:
        #input number
        li		$v0,    4 		# $v0   service number = 4
        la	    $a0,    input_string_num   #提示输入数字个数
        syscall

        li      $v0,    5       # $v0   service number = 5
        syscall
        move 	$t0,    $v0		# $t0  =  $v0   
        
        #input integers & count
        li      $t1,    0       # $t1 = 0, counter

        #input
input_loop:

        li      $v0,    8
        la      $a0,    integer_buf     # $a0 = interger_buf
        li      $a1,    10
        syscall
        addi	$t1,    $t1,    1	    # $t1  = $t1 + 1
        
        #count
        li      $t2,    0
        la      $t3,    integer_buf
        li      $t4,    10      #\n
count_loop:

        move    $t5,    0($t3)        # $t4 = interger_buf[$t2]
        beq		$t5,    $t4,    count_end	    # if $t5 =  t4  then count_end
        
        la      $t6,    integer_count
        
        
count_end: