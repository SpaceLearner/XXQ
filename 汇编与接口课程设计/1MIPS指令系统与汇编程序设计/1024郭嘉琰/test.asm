##
######## by Guo Jiayan 1120151024
####     E:     count max
##       8-28-2018
########################

######### data segment ##########
	.data
input_string_num:    .asciiz     "Please input the number of integers:\n"
input_string_buf:    .asciiz     "Please input the integers you want:\n"
output_string:       .asciiz     "Answer is:\n"
cr:		     .asciiz	 "\n"
padding:	     .asciiz     "           "		# make sure the boundary is up to a word

integer_buf:         .space      15
integer_count:       .space      36 

MAX:                 .space      4

######### text segment ##########
        .text
        .globl main

main:

	#initial
	la	$t6,	integer_count
	move	$t8,	$t6
clear:
	sw	$zero,	0($t6)
	addi	$t6,	$t6,	4
	sub	$t9,	$t6,	$t8	
	bne	$t9,	36,	clear
	
	
        #input number
        li	    $v0,    4 		# $v0   service number = 4
        la	    $a0,    input_string_num   #提示输入数字个数
        syscall

        li      $v0,    5       # $v0   service number = 5
        syscall
        move 	$t0,    $v0		# $t0  =  $v0 
          
        #input integers & count
        li      $t1,    0       # $t1 = 0, counter
        li      $v0,    4
        la      $a0,    input_string_buf
        syscall

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

        lb    	$t5,    0($t3)        # $t4 = interger_buf[$t2]
        beq	$t5,    $t4,    count_end	    # if $t5 =  t4  then count_end
        
        la      $t6,    integer_count
        sub	$t5,    $t5,    $t8     # $t5 =  $t5 - '0'      
            
        mult	$t5,    $t7			# $t5 * $t7 = Hi and Lo registers
        mflo	$t5					# copy Lo to $t5
        
        add     $t6,    $t6,    $t5 # t7 free
        lw    	$t9,    0($t6)
        addi    $t9,    $t9,    1
        sw	$t9,    0($t6)		# count[i] += 1

        lw	$t5,    MAX		# $t7 = MAX
        ble	$t9,    $t5,    conti	    # if $t9 < $7 then continue
        sw	$t9,    MAX		# MAX = max($t7, $t9)
        
conti:        

        addi    $t3,    $t3,	1	# $t3 = $t3 + 1
        b	count_loop			# branch to count_loop
        
        #clear interger_buf
count_end:
        la      $t3,    integer_buf
        li	$t2,	0
        move	$t4,	$t3
        
clear_loop:
        sb      $t2,    0($t3)      # clear interger_buf[i]    
        addi	$t3,    $t3,    1       # $t3 =  t3  +  1
        sub	$t5,	$t3,	$t4
        blt	$t5,	15,	clear_loop 
        
        beq	$t1,    $t0,    find_max    # branch to input_loop
        b       input_loop	# branch input_loop
        

find_max:
        
        li      $t0,    32
        la      $t3,    integer_count
        li      $t1,    0
        lw      $t7,    MAX
        
        #show answer
        li	$v0,	4
        la	$a0,	output_string
        syscall

find_loop:        
        lw      $t9,    0($t3)
        beq     $t9,    $t7,    output
        
find_loop_con:
        addi	$t3,    $t3,    4	# $t3 = $t3 + 4
        addi    $t1,    $t1,    1       # $t1++
        beq     $t1,    9,    	done
        b	find_loop

output:
		
        li      $v0,    1       #service number = 1
        move    $a0,    $t1     #$a0 = $t1
        syscall
        li	$v0,	4
        la	$a0,	cr
        syscall		
        b       find_loop_con


	#done
done:
	li,	$v0,	10
	syscall
##      end of file
