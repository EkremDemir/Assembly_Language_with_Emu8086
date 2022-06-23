org 100h
.data

counter_1  dw ?
x_center dw 120
y_center dw 160 
counter  dw ?
cns_r    dw  ?
difference dw ?

.code
           mov ax,@data
           mov ds,ax

           mov ax,0800h         ;Set up logic address 0800h for DS
           mov ds,ax
           mov di,00h           ;Move 00 to DI
           
           mov counter,0000h    ;Set up the "counter" as zero
           mov bx,120           ;Move 120 to BX
           mov cx,0             ;Move 0 to CX
           mov x_center,120
           mov y_center,160 
            
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


           
           mov di,0000h         ;Move 00 to DI
           MOV BL,0

           mov ah,0             ;Set video mode
           mov al,12h
           int 10h

Put_Pixel:
 
          mov bx,00             ;Move 00 to BX, for XLAT
          mov cx,x_center       ;Move "x_center" to CX
          add cx,counter_1      ;Add "counter_1" to CX
          mov ax,counter_1      ;Move  "counter_1"to AX for XLAT
          xlat                  ;Copy content of address [BX+AL] to AL
          mov dx,y_center       ;Move "Y_center" to DX
          sub dx,ax             ;Subtract AL from DX
          call Write_Pixel      ;Call function named "Print_Pixel"

          mov cx,x_center       ;Move "x_center" to CX
          sub cx,counter_1      ;Subtract "counter_1" from CX
          call Write_Pixel      ;Call function named "Print_Pixel"

          mov cx,x_center       ;Move "x_center" to CX
          add cx,counter_1      ;Add "counter_1" to CX
          mov ax,counter_1      ;Move  "counter_1" to AX for XLAT
          xlat                  ;Copy content of address [BX+AL] to AL
          mov dx,y_center       ;Move "Y_center" to DX
          add dx,ax             ;Add AX to DX
          call Write_Pixel      ;Call function named "Print_Pixel"

          mov cx,x_center       ;Move "x_center" to CX
          sub cx,counter_1      ;Subtract "counter_1" from CX
          call Write_Pixel      ;Call function named "Print_Pixel" 

          mov dx,y_center       ;Move "Y_center" to DX
          add dx,counter_1      ;Add "counter_1" to DX
          mov ax,counter_1      ;Move  "counter_1" to AX for XLAT
          xlat                  ;Copy content of address [BX+AL] to AL
          mov cx,x_center       ;Move "x_center" to CX
          sub cx,ax             ;Subtract AL from CX
          call Write_Pixel      ;Call function named "Print_Pixel"

          mov dx,y_center       ;Move "Y_center" to DX
          sub dx,counter_1      ;Subtract "counter_1" from DX
          call Write_Pixel      ;Call function named "Print_Pixel"


          mov dx,y_center       ;Move "Y_center" to DX
          add dx,counter_1      ;Add "counter_1" to DX
          mov ax,counter_1      ;Move  "counter_1" to AX for XLAT
          xlat                  ;Copy content of address [BX+AL] to AL
          mov cx,x_center       ;Move "x_center" to CX
          add cx,ax             ;Add AX to CX
          call Write_Pixel      ;Call function named "Print_Pixel"

          mov dx,y_center       ;Move "Y_center" to DX
          sub dx,counter_1      ;Subtract "counter_1" from DX
          call Write_Pixel      ;Call function named "Print_Pixel" 


          inc counter_1         ;Increment "counter_1"
          cmp counter_1,121     ;Compare "counter_1" with 121
          jne Put_Pixel         ;If "counter_1" is not equal to 121  jump to "Put_Pixel

          mov ah,4ch            ;Stop the program
          int 21h

Write_Pixel    proc               
          mov ah,0ch            ;Write Pixel value with CX(column and DX(row)
          mov al,1111b
          int 10h
          ret                   ; End the subroutine
Write_Pixel    endp        
