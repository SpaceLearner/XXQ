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

MAX                 .space      4

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
        li      $t7,    4
        li      $t8,    48      #0
count_loop:

        move    $t5,    0($t3)        # $t4 = interger_buf[$t2]
        beq		$t5,    $t4,    count_end	    # if $t5 =  t4  then count_end
        
        la      $t6,    integer_count
        sub		$t5,    $t5,    $t8     # $t5 =  $t5 - '0'      
            
        mult	$t5,    $t7			# $t5 * $t7 = Hi and Lo registers
        mflo	$t7					# copy Lo to $t2
        
        add     $t6,    &t6,    $t7 # t7 free
        move    $t9,    0($t6)
        addi    $t9,    $t9,    1
        sw		$t9,    0($t6)		# count[i] += 1

        lw		$t7,    MAX		# $t7 = MAX
        blt		$t9,    $t7,    conti	    # if $t9 < $7 then continue
        sw		$t9,    MAX		# MAX = max($t7, $t9)
        
conti:        

        addi    t3,     4
        b		count_loop			# branch to count_loop
        
        #clear interger_buf
count_end:
        la      $t3,    integer_buf
        sw      $t2,    0($t3)      # clear interger_buf[i]    
        addi	$t3,    $t3,    4		# $t3 =  t3  +  4 
        

        beq	    $t1,    $t0,    done    # branch to input_loop
        
find_max:


