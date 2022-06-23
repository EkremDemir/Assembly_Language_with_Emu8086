
main      proc    far
          mov ax,-4  ;assign 4 to the ax
         
          call again; call function named "again"
          call complement
          mov bx,ax ;copy the content of ax to the content of bx 
          call again;call function named "again" 
          call complement
          mov cx,ax ;copy the content of ax to the content of cx
          call again;call function named "again"     
          call complement
          mov dx,ax ;copy the content of ax to the content of dx
          hlt
main      endp




again     proc
          
          add ax,ax;add content of AX with itself and store result in AX
          add ax,ax;add content of AX with itself and store result in AX
          ret      ;finish the function
again     endp


complement     proc
          
              xor ax,0ffffh; 
              add ax,1
              ret      ;finish the function
complement   endp
