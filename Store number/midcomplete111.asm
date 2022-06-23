org 100h
.data

my_number   db  2,1,8,2,8,3,8,4



.code

main       proc    far
    
    
         mov ax,@data
         mov ds,ax
         mov ax,0700h
         mov ds,ax
         mov si,offset my_number
         mov di,0030h
         mov cx,7
 loop1:  mov ax,[si]
         mov [di],ax
         inc di
         inc si
         dec cx
         jnz loop1
         
         mov ah,4ch
         int 21h

main   endp