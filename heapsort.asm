.data

sizeoutput: .asciiz "How many values in your array: "
numinput: .asciiz "Enter number: "
unsortedarrayoutput: .asciiz "The unsorted array is: "
maxheapoutput: .asciiz "The max heap is: "
newline: .asciiz "\n"
sortedarrayoutput: .asciiz "The sorted array is: "

.text

.globl main
.ent main
main:

li $v0, 4
la $a0, sizeoutput
syscall

li $v0, 5
syscall

move $s0, $v0 

mul $a0, $s0, 4
li $v0, 9
syscall
move $s1, $v0  


li $t0, 0



input:

    beq $t0, $s0, printunsortedarray


    li $v0, 4
    la $a0, numinput
    syscall


    li $v0, 5
    syscall

   
    mul $t1, $t0, 4
    add $t1, $t1, $s1 
    sw $v0, ($t1)  

    addi $t0, $t0, 1
    j input

printunsortedarray:

li $v0, 4
la $a0, unsortedarrayoutput
syscall

li $t0, 0

unsortedarrayloop:

    beq $t0, $s0, init

    mul $t1, $t0, 4   
    add $t1, $t1, $s1  

    li $v0, 1
    lw $a0, ($t1)     
    syscall
    
    li $v0, 11         
    li $a0, 32  
    syscall

    addi $t0, $t0, 1  
    j unsortedarrayloop


init:


div $t0, $s0, 2   
addi $t0, $t0, -1

buildmaxheap:

blt $t0, $zero, printmaxheap

move $a3, $s0
move $a1, $s1
move $a2, $t0


jal maxheapify

addi $t0, $t0, -1

j buildmaxheap

maxheapify:




move $t1, $a2 

mul $t2, $t1, 2
addi $t2, $t2, 1
addi $t3, $t2, 1




slt $t4, $t2, $a3
slt $t5, $t3, $a3

and $t6, $t4, $t5
beq $t6, 1, bothchildrenexist

beq $t4, 1, leftchildexists
beq $t5, 1, rightchildexists




jr $ra


bothchildrenexist:



mul $t1, $t1, 4
add $t1, $t1, $a1
lw $t4, ($t1)

mul $t2, $t2, 4
add $t2, $t2, $a1
lw $t5, ($t2)

mul $t3, $t3, 4
add $t3, $t3, $a1
lw $t6, ($t3)

slt $t7, $t4, $t5
addi $t6, $t6, -1
slt $t8, $t6, $t5
and $t9, $t7, $t8
beq $t9, 1, leftswap

addi $t6, $t6, 1
slt $t7, $t4, $t6
slt $t8, $t5, $t6
and $t9, $t7, $t8
beq $t9, 1, rightswap



jr $ra

leftchildexists:


mul $t1, $t1, 4
add $t1, $t1, $a1
lw $t4, ($t1)

mul $t2, $t2, 4
add $t2, $t2, $a1
lw $t5, ($t2)

bgt $t5, $t4, leftswap

jr $ra

rightchildexists:



mul $t1, $t1, 4
add $t1, $t1, $a1
lw $t4, ($t1)

mul $t3, $t3, 4
add $t3, $t3, $a1
lw $t6, ($t3)

bgt $t6, $t4, leftswap

jr $ra

leftswap:



sw $t5, ($t1)
sw $t4, ($t2)

sub $t2, $t2, $a1
div $a2, $t2, 4

j maxheapify


rightswap:



sw $t6, ($t1)
sw $t4, ($t3)

sub $t3, $t3, $a1
div $a2, $t3, 4

j maxheapify





printmaxheap:

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, maxheapoutput
syscall

li $t0, 0

maxheaploop:

    beq $t0, $s0, init2

    mul $t1, $t0, 4   
    add $t1, $t1, $s1  

    li $v0, 1
    lw $a0, ($t1)     
    syscall

    
    li $v0, 11         
    li $a0, 32  
    syscall

    addi $t0, $t0, 1  
    j maxheaploop

init2:

move $t0, $s0
addi $t0, -1

heapsort:


beq $t0, 0, printsorted

mul $t1, $t0, 4
add $t1, $t1, $s1


lw $t2, ($s1)
lw $t3, ($t1)

sw $t2, ($t1)
sw $t3, ($s1)


move $a3, $t0
move $a1, $s1
li $a2, 0

jal maxheapify
addi $t0, $t0, -1
j heapsort

printsorted:

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, sortedarrayoutput
    syscall

    li $t0, 0

printsortedloop:

    beq $t0, $s0, end

    mul $t1, $t0, 4   
    add $t1, $t1, $s1  

    li $v0, 1
    lw $a0, ($t1)     
    syscall

    li $v0, 11         
    li $a0, 32  
    syscall

    addi $t0, $t0, 1  
    j printsortedloop



end:
li $v0, 10
syscall


.end main
