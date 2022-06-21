;Purpose of this code is take square of each number from 0 to 15.
;First I set up bx register as a zero, then bx is incremented in the loop to get numbers from 0 to 15.
;I have 16 numbers,hence I set up a loop for 16 times 
;for every loop square is taken
;Then I write the results TO specified memeroy addressses.


.code

     mov ax,0700h ; Load data to segment address
     mov ds,ax    ; assign a value to DS                              
     mov di,0000h ; set up data pointer DI
     mov bx,0     ; Initialize BX
     mov ax,bx    ; Move content of BX to AX
     mov cx,16    ; Set up loop counter CX=16  
     
multply_LP: mul ax; Multiply data of AX register with data of AX  
                ; register then write the result in AX register
                
            mov [di],ax   ; Store the result in data segment
            inc di        ; Increment DI
            inc bx        ; Increment BX
            dec cx        ; Decrement loop counter
            mov ax,bx     ; Asiign data of BX to AX 
            jnz multply_LP  ; jump if loop counter is not zero
     hlt ;finish the program