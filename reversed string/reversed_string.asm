
 org 0100h
.data
 
data_in    db 'This code written by Ekrem Demir.','$'

.code


main        proc   far  
    
            mov ax,@data ;Load the data segment address
            mov ds,ax    ; assign value to ds
            mov ax,0700h ; Assign a specific value to AX register
            mov ds,ax   ;Assign value to DS, specifies the logic address
            mov si,offset data_in;Set up data pointer di
             
            mov di,500h;set up the specified offset address
            mov cx,0   ; set up cx as zero to count characters
    
      loop_1:
             mov al,[si]; exchange the content of the registers DI AND SI
             mov [di],al;
          
             inc si     ; Increment SI to reach next address
             inc di     ; Increment to reach next address
             inc cx     ; Increment CX to count #of caharacters
             
             cmp [si],'$'; check the end of the string 
             je  next_1  ; if cursor is in end of the string go to next_1
             jmp loop_1  ; if not go to loop_1
    
     next_1:mov si,offset data_in; Copy the first address of the "data_in" to SI register 
            mov di,540h  ;set up the specified offset address 
            sub cx,1     ; subtruct 1 from CX
            add si,cx    ;Add content of SI register with CX register to reach end of the string
            add cx,1     ;add content of CX register 1
          
      loop_2: mov al,[si];exchange the content of the registers DI AND SI
              mov [di],al
                         
              dec si     ;Decrement SI to reach back address
              inc di     ; Increment DI to reach next address
              dec cx     ; Decrement CX to finish the loop
              jnz loop_2 
            
      
     exit:
          mov ah,4ch;Finish the program
          int 21h
main      endp
