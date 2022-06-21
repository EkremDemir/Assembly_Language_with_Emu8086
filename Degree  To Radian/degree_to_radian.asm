
 org 0100h
.data
 
data_in    db 5,10,15,20,25,30,35,40,50,55,60,65,70,75,80,85
cons_1     dw 10000
cons_2     dw 1000
cons_3     dw 100
cons_4     dw 174
variable   dw ?


.code


main        proc   far
            mov ax,@data ;Load the data segment address
            mov ds,ax    ; assign value to ds
            mov ax,0700h ; Assign a specific value to AX register
            mov ds,ax   ;Assign value to DS, specifies the logic address
            mov di,offset data_in;Set up data pointer di
            mov si,00   ; Assign a specific value to ax register, it specifies offset address
            mov cx,16   ; set up CX register as a counter
   loop_1:  mov al,[di] ;copy data of DI to the AL register
            mov [si],al ;copy  data of AL to the DS
            mov variable,si;copy  data of offset address to the variable 
            sub ah,ah   ; clear ah
            mul cons_4  ; multiply content of AX register by cons_4 (174)
  
            div cons_1  ; Divide content of AX register by cons_1 (10000), to reach first  integer 
            add si,10h  ; increment SI by 10h
            call repeat ; call function named "repeat"
            div cons_2  ; Divide content of AX register by cons_2 (1000),to reach first digit after decimal point
            call repeat ; call function named "repeat"
            div cons_3  ; Divide content of AX register by cons_3 (100)
            call repeat ; call function named "repeat"
            mov si,variable; store content of SI in the variable
            inc di      ; increment DI by 1
            inc si      ; increment SI by 1
            dec cx      ; increment CX by 1
            jnz loop_1  ; if bit of zero flag is not 1 jump to looop_1
            
            ;to rearenge addresses of data   
            mov di,0020h; initialize DI
            mov si,0030h; initialize DI
            mov bx,0050h; initialize DI
            mov cl,16   ; Set up CL for counter CX=16
            
            
 loop_2:       mov al,[si];Copy the content of [SI] to the AL
               mov [di],al;Copy the content of AL to the [DI]
               mov dl,[bx];Copy the content of [BX] to the DL
               mov [si],dl;Copy the content of DL to the [SI]
               mov [bx],00;clear content of [BX]
               
               inc di      ; increment DI by 1
               inc si      ; increment SI by 1
               inc bx      ; increment BX by 1
               dec cL      ; increment CX by 1
               jnz loop_2  ;If bit of zero flag is not 1 jump to looop_2
            

            mov ah,4ch
            int 21h ; Finish the program
main        endp

repeat       proc
            add ax,30h ; increment content of ax by 30h to ASCII code of the number
            mov [si],ax;Copy the content of AX to the [SI] 
            mov ax,dx  ;Copy the content of DX to the AX
            sub dx,dx  ;Clear contetn of the DX
            add si,20h ;increment DI by 1 to reach next 20h memory location
            
            ret  ; finish the funtion
repeat     endp
