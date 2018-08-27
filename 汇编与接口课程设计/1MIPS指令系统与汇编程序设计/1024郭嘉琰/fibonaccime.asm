##
######## by stevie zou
####    fibonacii
###      10-16-2008
#######################

#########  text segment  ##############
        .text
        .globl main
main:
        li    $v0,   4         #��ӡ�ַ���
        la    $a0,   msg1
        syscall

        li    $v0,   5          #�����ʼֵ
        syscall
        move    $a0,   $v0

        move   $v0,   $a0
        blt    $a0,   2,   done
        li     $t0,   0
        li     $v0,   1
      
fib:    add    $t1,   $t0,  $v0
        move   $t0,   $v0        #���´���һ����ֵ����F(n-2)
        move   $v0,   $t1        #������һ��쳲�������ֵF(n-1)
        sub    $a0,   $a0,  1
        bgt    $a0,   1,    fib
done:   sw     $v0,   result

        move    $a0,   $v0    #���Խ���Ƿ���ȷ
        li     $v0,    1
        syscall

############### data segment   #####
       .data
result: .word  0x00000000
msg1:   .asciiz  "/ninput initial N:/n"

## end of file
