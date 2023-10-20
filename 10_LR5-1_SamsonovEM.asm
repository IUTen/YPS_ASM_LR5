use16
org 100h

mov ax,0x0

start:
    push ax
    mov dx,buff
    mov ah,0x0a
    int 21h ;ds:dx
    pop ax

    mov si,dx
    add si,2
    mov cx,p_size
    dec cx
    mov di,cor_psw

	pusha
	repe cmpsb ;ds:si и es:di

	je correct
	jmp wrong

wrong:
	push dx
	push ax

	mov dx,false_msg

	mov ah,09h
	int 21h

	pop ax
	pop dx
	jmp start

correct:
	push dx
	push ax

	mov dx,cor_msg
	mov ah,09h
	int 21h

	pop ax
	pop dx

finish:
	mov ax,0x0
	int 16h
	int 20h


cor_psw db '22u086$'
p_size = $ - cor_psw

buff db 128,?,p_size dup(?)

cor_msg db 0xA, 0xD, 'Correct password', 0xA, 0xD, '$' 
false_msg db 0xA, 0xD, 'Wrong password', 0xA, 0xD, '$'