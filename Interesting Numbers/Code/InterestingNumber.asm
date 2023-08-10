#fasm#
org 100h
jmp start 
main_msg1 db '                 Welcome to the Interesting Numbers Program$' 
main_msg2 db 0dh,0ah,0dh,0ah,'Menu-1: Fibonacci Numbers',0Dh,0Ah 
          db 'Menu-2: Factorial',0Dh,0Ah,'Menu-3: Square Number ',0Dh,0Ah          
          db 'Menu-4: Prime Number',0Dh,0Ah,'Menu-5: About Section',0Dh,0Ah,'Menu-6: Exit$'
main_msg3 db 0Dh,0Ah,'Ended with esc input$'
main_msg4 db 0Dh,0Ah,'Enter a number:$'
main_msg5 db 0Dh,0Ah,'------------------------------------------------------',0Dh,0Ah,'$'
main_msg6 db 0Dh,0Ah,'Program finished successfully.$'
main_msg7 db 0Dh,0Ah,'Enterd number can be maximum 65000$'
not_num_msg   db 0dh,0ah,'Please enter an integer:$'
main_new_line db 0dh,0ah,'$'
main_input  dw ? 
main_output dw ?
main_var1   dw ?
main_var2   dw ?
main_var3   dw ?
main_var4   dw ? 
;------------------------------------------------------------------------------------
mn_1_Msg1     db '             Fibonacci Numbers$'
Msg_2     db 20h,'is a fibonacci number$'
Msg_3     db 20h,'is not a fibonacci number. Closest small fibonacci number is $' 

;---------------------------------------------------
mn_2_Msg1      db 0dh,0ah,'             Factorial$'
mn_2_Msg2     db '! is $'
mn_2_Exit_Msg  db 0dh,0ah,'Result is so big$'
;-------------------------------------------------------
mn_3_Msg1     db  '             Square Number$'
mn_3_Msg2     db 20h,'is a square of integer $'
mn_3_Msg3     db 20h,'is not a square of an integer.Closest small integer is $' 
mn_3_Msg4  db 20h,'is not an valid integer$' 
mn_3_Msg5     db 0dh,0ah,'Nearestsmall square number is ','$'
;------------------------------------------------------
mn_4_Msg1     db  '             Prime Number$'
mn_4_Msg2     db ' is not a prime number.','$'
mn_4_Msg3     db 0dh,0ah,'Entered integer is not valid !$'    
mn_4_Msg4     db ' is a prime number. ','$' 
mn_4_Msg5     db 0dh,0ah,'Closest small prime number is $'
;-----------------------------------------------------------------
about_sec     db 0dh,0ah,'         Interesting Numbers Program'
              db 0dh,0ah,'The program consist of main function with four subfunction to'
              db 0dh,0ah,'calculate fibonacci series, factorial,square numnbers and prime numbers'
              db 0dh,0ah,'Programmer: Ekrem Demir/ 21828384'
              db 0dh,0ah,'all rights reserved.$'
;--------------------------------------------------------------------------

start:              
           mov dx,main_msg1; print the message
           mov ah,9
           int 21h
           mov dx,main_msg2; print the message
           mov ah,9
           int 21h
           
        take_menu:
           call clear
           
           mov  ah,0  ; take input
           int  16h 
           
           cmp al,27  ; compare input with "ESC" if equal jump to menu_6
           je  menu_6 
           
           cmp al,30h     ;This conditions check the entered input is number or not
           jc  next_again   ;If entered input is not a number jump to Exit_Msg   
           
           cmp al,39h
           jnc next_again
           
           jmp next_m   
       next_again:
           mov dx,not_num_msg; print the message
           mov ah,9
           int 21h 
           
           jmp take_menu
       next_m:    
           cmp al,31h ; if input is 1 jump to menu_1     
           je menu_1
           
           cmp al,32h ; if input is 2 jump to menu_2     
           je menu_2 
           
           cmp al,33h ; if input is 3 jump to menu_3     
           je menu_3
           
           cmp al,34h ; if input is 4 jump to menu_4     
           je menu_4
           
           cmp al,35h ; if input is 5 jump to menu_5     
           je menu_5
           
           cmp al,36h ; if input is 6 jump to menu_6     
           je menu_6
           
           jmp menu_6 ; jump to menu 6
                                                            
                                                                                     
menu_1:    
           call clear ; clear all registers and variables
           
           mov dx,  main_msg5;print the message
           mov ah,09
           int 21h
           
           mov dx,  mn_1_Msg1;print the message
           mov ah,09
           int 21h  
           
           mov dx,  main_msg4;print the message
           mov ah,09
           int 21h
           
           call take_num ; take an input
           
           mov ah,09           
           mov dx,main_new_line; print new line 
           int 21h
           
           
           ; initialize the variable and rgister 
           mov [main_input],bx; holds the input number       
           mov [main_var1],1  
           mov [main_var2],1
           mov [main_var3],1 
           
           cmp bx,0            ; if input is zero jump to "ExitMsg
           je  ExitMsg 
           
           mov ax,[main_var1]  ;
           call print_num      ; print the content of ax register
;-------------------------------------------------------------------------------------           
find_fibo: 
         
         mov dx,[main_input];if "var2" is greater than input jump "next_n"
         cmp [main_var2],dx            
         ja next_n
         
         mov ax,[main_var2] ; save content of var2 in var3, then print var3
         mov [main_var3],ax
         call  print_num
         
         mov dx,[main_var1] ; add var1 with var2, then save it in var1 
         add dx,[main_var2]
         mov [main_var1],dx
         
         mov dx,[main_input];if "var2" is greater than input jump "next_n" 
         cmp [main_var1],dx
         ja next_n
         
         mov ax,[main_var1] ; save content of var1 in var3, then print var3
         mov [main_var3],ax
         call print_num
         
         
         
         mov dx,[main_var2] ; add var2 with var1, then save it in var2 
         add dx,[main_var1]
         mov [main_var2],dx

        jmp find_fibo
         
  next_n:
         mov ah,09           
         mov dx, main_new_line ; print the new line
         int 21h
        
         mov dx,[main_input]; check last fibonacci number is equal to entered number or not
         cmp [main_var3],dx
         je Exit            ; if equal jump to exit
         
         
         
           
        ExitMsg:
           
           mov ax,[main_input]; print the input   
           call print_num 
           
           mov ah,09            
           mov dx,Msg_3 ;print the message
           int 21h      
           
           mov ax,[main_var3] ; print the closest small fibonacci number  
           call print_num 
           
           call menu_6 ; exit
        
        Exit:
           mov ax,[main_input]; print the input   
           call print_num 
           mov ah,09            
           mov dx,Msg_2 ;print the message
           int 21h     
           
           call menu_6 ;exit  
;----------------------------------------------------------        
menu_2:  
           call clear ; clear all registers and variables
           
           mov dx,main_msg5; Print message 1
           mov ah,9
           int 21h
           
           mov dx,mn_2_Msg1;Print the message "Msg_1"
           mov ah,09
           int 21h
           
           mov dx,main_msg4;Print the message "Msg_1"
           mov ah,09
           int 21h
           
           
           
           call take_num  ; take an input
             
           cmp bx,9       ; compare input with 9
           jnc  fuc_ExitMsg; if inpput is grater than 9 then print message and exit
             
           mov ah,09           
           mov dx, main_new_line ; print newline
           int 21h 
           
           
           mov [main_var1],0 ; if input is zero ensure the result is 1
           cmp bx,0
           je  next_f
           
           ;initialize register and variables
           mov [main_var1],bx; var1 holds input
           add bx,1        
           mov cx,1
           mov ax,1
find_fuc:
           mul cx  ; multiply numbers from 1 to inputed number
           inc cx 
           
           cmp bx,cx
           jne find_fuc
           
           mov [main_var2],ax; hold the result in var2
           
        next_f:
           mov ax,[main_var1]; print the input
           call print_num   
               
           mov dx,mn_2_Msg2;Print the message "Msg_1"
           mov ah,09
           int 21h      
           
           mov ax,[main_var2]; print the factorial result
           call print_num
             
           jmp fuc_Exit   ;jump to exit
           
                     
        fuc_ExitMsg:
           
           mov ah,09            
           mov dx,mn_2_Exit_Msg ;print the message
           int 21h     
           call menu_6 ;exit
        
        fuc_Exit:  
           call menu_6 ; exit
       
    

menu_3:
           call clear ; clear all registers and variables
            
           mov dx,main_msg5; Print message 
           mov ah,9
           int 21h
           
           mov dx,  mn_3_Msg1;Print the message 
           mov ah,09
           int 21h
           
           mov dx,  main_msg4;Print the message 
           mov ah,09
           int 21h
           
           call take_num  ; takes an input    
           
           mov ah,09           
           mov dx,main_new_line ; print new line
           int 21h  
           
           mov [main_var1],bx; var1 holds the input        
           mov cx,0
         
find_square:  
           mov ax,cx         ; take square of each number from 1 to input number
           mul cx 
           mov [main_var2],cx 
           
           cmp ax,[main_var1]; if result of square equal to input jump to exact_s 
           je  exact_s
           jnc not_exact_s   ; if result of square greater to input jump to not_exact_s 
           
           inc cx      
           jmp find_square   ;uncondition loop
            
       not_exact_s:
           sub [main_var2],1 ; decrement the result by 1
           
           mov ax,[main_var1] ; print the inpput
           call print_num
           
           mov ah,09           
           mov dx, mn_3_Msg3  ;Print the message 
           int 21h    
           
           mov ax,[main_var2] ;print the integer result 
           call print_num 
           
           mov ah,09
           mov dx,mn_3_Msg5   ; print the message
           int 21h 
           mov ax,[main_var2] ; print the square of intger result
           mul ax
           call print_num
                 
           jmp  exit_s       ; jump to exit
         
       exact_s:   
           mov ax,[main_var1]; print the input
           call print_num  
           
           mov ah,09           
           mov dx, mn_3_Msg2   ;Print the message 
           int 21h   
           
           mov ax,[main_var2]  ; print the integer result
           call print_num  
                
           jmp  exit_s         ; jump to exit
                      
        exit_msg_s   :
           mov ax,[main_var1]  ;print the input
           call print_num      
           
           mov ah,09            
           mov dx,mn_3_Msg4    ;Print the message 
           int 21h 
           
           call menu_6     ;exit
        
        exit_s:  
           call menu_6     ;exit
        

menu_4:
           call clear
           mov dx,main_msg5; Print message 
           mov ah,9
           int 21h 
           
           mov dx,mn_4_Msg1;Print the message 
           mov ah,09
           int 21h
           
           
           mov dx,main_msg4;Print the message 
           mov ah,09
           int 21h

           call take_num   ;takes an input
            
             
          
           mov dx,main_new_line ; print the new line
           mov ah,9
           int 21h
           
           mov [main_var1],bx; var1 holds the input 
           mov ax,bx
           mov cx,2
           
           cmp bx,2   ;ensure that input 0 and 1 is not prime
           jc  not_prime
           
           cmp bx,2   ;ensure that input 2 is prime
           je  prime
           
           mov cx,2  ; initialize cx as 2 
           
   find_prime: 
           mov dx,00 ; divide each number from 2 to (inpute-1) 
           mov ax,[main_var1]
           div cx
           inc cx 
           
           cmp dx,0 ; if ramain is 0 then jump to not_prime
           je  not_prime
           cmp cx,bx; if input is equal to counter jump to prime
           je prime
           
           jmp find_prime; unconditional loop
         prime:         
         
           mov ax,[main_var1]
           call print_num
           mov dx,  mn_4_Msg4;Print the message 
           mov ah,09
           int 21h
           jmp exit
      
         not_prime:
           mov ax,[main_var1]; print the input
           call print_num    
           
           mov dx, mn_4_Msg2;Print the message
           mov ah,09
           int 21h  
           
           mov bx,[main_var1];

           mov cx,2           ;ensure that input 0 and 1 is not prime
           cmp bx,2
           jc  next_pp
           
   find_sprime:
           sub [main_var1],1  ; decrement input by 1
           mov bx,[main_var1] ;holds it in bx register
             
       find_ssprime:
              mov dx,00        ; find closest small prime number
              mov ax,[main_var1]
              div cx
              cmp dx,0
              je  find_sprime ; if dx is zero jump to "find_sprime"
              inc cx
              cmp cx,bx       ; compare the closest small prime number with counter
              je  next_pp     ;if they are equal jump to next_pp
          
              jmp find_ssprime; unconditional jump
              
         next_pp:
           mov dx, mn_4_Msg5  ; print the message
           mov ah,09
           int 21h     
           
           mov ax,cx          ; print the closest small prime number
           call print_num 
           
           jmp exit          ; jump to exit
              
              
              
        pr_ExitMsg:
           mov dx,mn_4_Msg3;Print the message 
           mov ah,09
           int 21h
  
        exit:
            call menu_6  ; exit

menu_5:
           mov dx,about_sec; Print message 
           call menu_6

menu_6:
           mov dx,main_msg6; Print message 
           mov ah,9
           int 21h    
           
           mov ah,04ch   ; exit
           int 21h
       
take_num:

           mov dx,10 
           mov ah, 01h
           int 21h   
           
           cmp al,27
           je  menu_6
           
           cmp al, 13 
           je  next_t  
           
           cmp al,30h     ;This conditions check the entered input is number or not
           jc  user_errors   ;If entered input is not a number jump to Exit_Msg
           cmp al,39h
           jnc user_errors
           mov ah, 0  
           sub al, 48 
       
           mov ah,0
           mov cx, ax 
           mov ax, bx   

           mul dx      

           add ax, cx  
           mov bx, ax         
           jmp take_num
       next_t:
           cmp bx,65000
           jc  next_tt    
           
           mov dx,main_msg7; Print message 
           mov ah,9
           int 21h
           call menu_6
       next_tt:
           
           ret
           
       user_errors:
           mov dx,  not_num_msg;Print the message 
           mov ah,09
           int 21h
           jmp take_num
           
print_num:
           mov cx,0
           mov dx,0
           cmp ax,0
           je zero
     push_num:
           cmp ax,0
           je  print1  
            
           mov bx,10       
           div bx                 

           push dx             
           inc cx
           xor dx,dx
           jmp push_num
      print1:
           cmp cx,0
           je  next_pr
           pop dx
        
           add dx,30h
           mov ah,02h
           int 21h
           dec cx
           jmp print1
           
      zero:mov dx,0
           add dx,30h
           mov ah,02h
           int 21h
      next_pr:
            mov dl,20h
            mov ah,2
            int 21h
            ret
           
           
clear:
      mov ax,0
      mov bx,0
      mov cx,0
      mov dx,0
      mov [main_var1],ax
      mov [main_var2],ax
      mov [main_var3],ax
      mov [main_var4],ax
      ret
check_esc:
         mov ah,1
         int 16h
         jz  pressed
         ret
    pressed:
         cmp al,27
         je  menu_6
         ret