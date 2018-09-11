##
######## For CPU TEST
####    
#########################

##########  data segment   ############
        .data

test_num1:      .space      4
test_num2:      .space      4

result:         .space      4


##########  text segment    ############
        .text
        .global main

main:
    
    #test  addi, addiu
    addi    $t1,    $0,     1000    #   $t1 = 1000
    addi    $t2,    $0,     2000    #   $t2 = 2000
    addiu   $t3,    $t2,    -1000   #   $t3 = 1000
    addiu   $t4,    $t3,    -500    #   $t4 = 500

    #test   add, addu
    add     $t5,    $t1,    $t2     #   $t5 = $t1 + $t2 = 3000
    add     $t6,    $t3,    $t4     #   $t6 = $t3 + $t4 = 1500
    addiu   $t7,    $0,     -1000   #   $t7 = -1000
    addu    $t8,    $t7,    $t6     #   $t7 = 2147483148

    #test   sub
    sub     $t7,    $t5,    $t6     #   $t7 = $t5 - $t6
    sub     $t8,    $4,     $t3     #   $t8 = $t4 - $t3        

    #test   sw, lw
    sw      $t1,    test_num1       #   test_num1 = 1000
    sw      $t2,    test_num2       #   test_num2 = 2000
    lw      $t3,    test_num1       #   $t3 = 1000
    lw      $t4,    test_num2       #   $t4 = 2000          
    addiu   $t5,    $t3,    1234    #   $t5 = 2234 
    addiu   $t6,    $t4,    1234    #   $t6 = 3234

    #test   and, or, xor
    addiu   $t1,    $0,     0xffff
    addiu   $t2,    $0,     0x0000
    and     $t3,    $t1,    $t2     #   $t3 = $t1 & $t2 = 0x0000
    or      $t3,    $t1,    $t2     #   $t3 = $t1 | &t2 = 0xffff
    xor     $t3,    $t1,    $t2     #   $t3 = $t1 ^ $t2 = 0xffff

    addiu   $t1,    $0,     0x1111
    addiu   $t2,    $0,     0x8888
    and     $t3,    $t1,    $t2     #   $t3 = $t1 & $t2 = 0x0000
    or      $t3,    $t1,    $t2     #   $t3 = $t1 | $t2 = 0x9999
    addiu   $t2,    $0,     0x9999
    xor     $t3,    $t1,    $t2     #   $t3 = $t1 ^ $t2 = 0x8888

    #test   slt
    slt     $t3,    $t1,    $t2     #   $t3 = 1
    slt     $t3,    $t2,    $t1     #   $t3 = 0

    #test   andi,   ori,    lui
    andi    $t3,    $t1,    0xdddd  #   $t3 = $t1 & 0xdddd = 0x0000
    andi    $t3,    $t2,    0x1111  #   $t3 = $t2 & 0x1111 = 0x9999

    ori     $t3,    $t1,    0x8888  #   $t3 = $t1 | 0x8888 = 0x9999
    ori     $t3,    $t2,    0x1111  #   $t3 = $t2 | 0x1111 = 0x9999

    lui     $t3,    0x3333          #   $t3 = 0x3333
    lui     $t3,    0xdddd          #   $t3 = 0xdddd

    #test   beq, j
Begin:
    beq     $t1,    $t2,    Second
    move 	$t1,    $t2
    j Begin

    #test   bgez
Second:
    bgez    $t1,    Third
    addiu   $t1,    1
    j		Second				# jump to Second
    
    #test   bget
Third:
    bget    $t1,    Forth
    addiu   $t1,    1
    j Third

    #test   jal
Forth:
    jal     Fifth

    #test   jr
Fifth:
    li		$t1, 	Sixth	# $t1 = Sixth

Sixth:
    j Sixth
   