org 100h

jmp start  
Msg_1      db  'This code is written by Ekrem Demir.',0dh,0ah
         db 'Enter an integer between 0 and 255, as X-pixel value : ','$'
     

Msg_2     db 0dh,0ah,'Y-pixel value is =  : ','$' 
Msg_3     db 0dh,0ah,'Entered integer is not between 0 and 255 !$'
Msg_4     db 0dh,0ah,'All pixel lengths corresponding to Y have been successfully saved.$'
Msg_5     db 0dh,0ah,'To save all pixels of Y press any key...$'
Input   db 3 dup(?)
Output  db  3 dup(?),'$'  

cns_r    dw  120        
counter  dw ?
difference dw ?    
start:
           mov dx, offset Msg_1;Print the message "Msg_1"
           mov ah,09
           int 21h

           mov si, offset Input;Load first address of the "Input" 
           mov bl, 0           ;Move 0 to BL register
           xor ax,ax           ;Clear AX register
           xor cx,cx           ;Clear CX register
              

     TakeNum:

           mov dx,10 
           mov ah, 01h; input one character
           int 21h

           cmp al, 13 ; compare content of al and 13(enter button)  
           je  Next_1   ; if enter button is pressed jump to "next" statement

           mov ah, 0  ; set up ah register as a zero
           sub al, 48 ; convert number in ascii character to number in decimal  
       
           mov ah,0
           mov cx, ax ; copy the content of the al register to the cl register
           mov ax, bx ; copy the content of the bl register to the al register  

           mul dx     ; multiply content of ax register by content of dl register  

           add ax, cx ; add content of the al register with content of the cl register 
           mov bx, ax ; copy the content of the al register bl the cl register
           mov bl, al
      

           jmp TakeNum
      
           mov bh,00     ;Move 0 to BH register
       
           Next_1:   
           cmp bx,0      ;Check the number is smaller than zero or not
           jc  ExitMsg   ;If number smaller than 0 go "ExitMsg"
         
           cmp bx,121    ;Check the number is bigger than zero or not
           jnc ExitMsg   ;If number bigger than 120 go "ExitMsg"
          
            
           mov ax, cns_r ;Take squarre of the 120
           mul cns_r
           mov cx,ax     ;Copy the content of the AX TO CX
         
           mov ax,bx     ;Take squarre of the inputted number
           mul ax
           sub cx,ax     ;Subtract AX from CX then save it to CX
           mov ax,cx         
         
           mov cx,1      ;Move 1 to CX
           mov bx,0000   ;Move 0000 BX
       
         
TakeSqrt:  cmp ax,0      ;Check the AX is zero or not 
           je  Exact     ;If AX is zero jump to "Exact"
           
           sub ax,cx     ;Subtract CX from AX then save it to AX
           add cx,2      ;Add CX with 2
   
           inc bx        ;Increment BX 
           
           cmp ax,8fffh  ;Check the number in AX is bigger than 8fffh or not
           jc  TakeSqrt  ;If number smaller than 8fffh  go "TakeSqrt"

         
          Exact:   
           mov si, offset Output;Load first address of the "Output" 
           mov ax,bx            ;Copy the BX to AX
           mov bx,10            ;Move 10 to BX
         
PrintNum:  div bx               ;Divide AX by BX
           add dl,30h           ;Decimal to ascii
           
           cmp ax,0             ;Check the AX is zero or not
           je  Next_2           ;If AX is zero jump to "Next_2"
         
           mov [si+2],dl        ;Copy the DL to address [si+2]
           sub dx,dx            ;Clear DX
           dec si               ;Decrement SI

        jmp PrintNum            ;Jump to "PrintNum"
       
          Next_2:  
           mov [si+2],dl        ;Copy the DL to address [si+2]
         
           mov ah,09            ;Print the message "Msg_2"
           mov dx,offset Msg_2
           int 21h
         
           mov ah,09            ;Print the message "Output"
           mov dx,offset Output
           int 21h
           
           mov dx, offset Msg_5;Print the message "Msg_5"
           mov ah,09
           int 21h
           
           mov ah,00           ;Press any key
           int 16h
         
           call Save            ; Call function named as "Save"
           
           mov ax,0700h         ;Since all defined data is in 0700h logic address
                                ;Program need to back 0700h logic address,
                                ;After save Y pixel to 0800h logic address
           mov ds,ax             
           
           mov ah,09            ;Print the message "Msg_4"
           mov dx,offset Msg_4
           int 21h            
           
           jmp  Exit            ;Jump to "Exit"
         
         
          ExitMsg:
             
           mov ah,09            ; Print the message "Msg_3"
           mov dx,offset Msg_3
           int 21h 

        
          Exit:  
           mov ah,4ch           ;Stop the program
           int  21h
        

Save          proc              ; Define a subroutine
    
           mov ax,0800h         ;Set up logic address 0800h for DS
           mov ds,ax
           mov di,00h           ;Move 00 to DI
           
           mov counter,0000h    ;Set up the "counter" as zero
           mov bx,120           ;Move 120 to BX
           mov cx,0             ;Move 0 to CX
            
            
 Subtract: mov cns_r,120        ;Move 120 to "cns_r"
           mov ax, cns_r        ;Take squarre of the 120
           mul cns_r                                    
                                ;Copy the AX to BX
           mov bx,ax
         
           mov ax,counter       ; take squarre of the inputted number
           mul ax
           sub bx,ax            ;Subtract AX from BX then save it to BX
           mov difference,bx    ;Copy the BX to "difference
              
              
TakeSqrt_2: 
           mov ax,cx            ;Copy the CX to AX   
           mul cx               ;take squarre of the CX
              
           cmp ax,difference    ;Compare "difference" and AX
           je  Exact_2          ;If they are equal, jump to "Exact_2"
            
           inc cx               ;Increment CX
           
           cmp ax,difference    ;Compare "difference" and AX
           jc  TakeSqrt_2       ;If AX is samller than "diffrence", jump to "TakeSqrt_2" statement
           
           sub cx,2             ;Decrement CX by 2  
           
         Exact_2: 
           mov [di],cl          ;Copy the CL to address of [DI]
           sub cx,4             ;Subtract 4 from CX
           
           cmp cx,25            ;Compare CX with 25
           jnc Next_5           ;If CX is bigger than 25, jump to "Next_5"
           
           mov cx,0             ;Set up cx as 0
         Next_5:
           inc counter          ;Increment counter by 1
           inc di               ;Decrement DI  by 1
           
           cmp counter,121      ;Compare "counter" with 120
           jne  Subtract        ;If they are not equal jump to "Subtract" statment
           ret
Save         endp
