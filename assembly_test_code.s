.text
main:
    addi t0, x0, 0        # base address of array
    addi t1, x0, 25
    sw   t1, 0(t0)        # array[0] = 25
    addi t1, x0, 12
    sw   t1, 4(t0)        # array[1] = 12
    addi t1, x0, 48
    sw   t1, 8(t0)        # array[2] = 48
    addi t1, x0, 7
    sw   t1, 12(t0)       # array[3] = 7
    addi t1, x0, 31
    sw   t1, 16(t0)       # array[4] = 31

    addi t2, x0, 0        # sum = 0
    addi t3, x0, 0        # i = 0
    addi t4, x0, 5        # size = 5

loop:
    beq  t3, t4, done      # if (i == size) goto done
    slli t5, t3, 2         # offset = i * 4
    add  t6, t0, t5        # address = base + offset
    lw   t1, 0(t6)         # load array[i]
    add  t2, t2, t1        # sum += array[i]
    addi t3, t3, 1         # i++
    beq  x0, x0, loop       # repeat

done:
    #beq  x0, x0, done       # infinite loop (halt)
    
    addi a7, a7, 10
    
    ecall