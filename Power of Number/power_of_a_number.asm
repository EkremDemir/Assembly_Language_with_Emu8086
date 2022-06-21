; The purpose of this code to take the second,third and fourth power of 4 
;without MUL instruction, then store results in BX,CX,DX respectively.
;After adding a number to itself, the total is added with itself
;In this way, the second, third and fourth powers of 4 can be found
;Here I have to use the same code more than once to perform the same operation. 
;In this case I used a subroutine named "again" to perform the same task more than once
;After getting the desired powers of 4, I placed the results in the specified registers



main      proc    far
          mov ax,4  ;assign 4 to the ax
          mov ch,2  ;assign power 2 to the ch
          call again; call function named "again"
          mov bx,ax ;copy the content of ax to the content of bx
          call again;call function named "again"
          mov cx,ax ;copy the content of ax to the content of cx
          call again;call function named "again"
          mov dx,ax ;copy the content of ax to the content of dx
          mov  ah,4ch
          int 21h  ; finish the program
main      endp 

again     proc
          
          add ax,ax;add content of AX with itself and store result in AX
          add ax,ax;add content of AX with itself and store result in AX
          ret      ;finish the function
again     endp
