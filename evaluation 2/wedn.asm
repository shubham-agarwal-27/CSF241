.model tiny
.486
.data
	fname1 db 'a.txt',0
	handle1 dw ?
	fname2 db 'b.txt',0
	handle2 dw ?
	temp db 'a.txt',0
	temp2 db 'temp.txt',0
	temp3 db 'b.txt',0
	inp db ?
	siz db ?
	count db 20
.code
.startup
	
	;Input a character from user
	mov ah,01h
	int 21h
	mov inp,al

	;Check if the input is y or y
	mov al,inp
	cmp al,'y'

	;If not y then check for Y
	jne x1

	; if y then jump to main part of solution
	jmp x2

x1:	;Check for Y
	mov al,inp
	cmp inp,'Y'

	;If not Y then exit 
	jne x3

	;else continue with the solution
x2:	
	;Swap the names of the two files
	mov ah,56h
	lea dx,fname1
	lea di,temp2
	mov cl,01h
	int 21h

	mov ah,56h
	lea dx,fname2
	lea di,temp
	mov cl,01h
	int 21h

	mov ah,56h
	lea dx,temp2
	lea di,temp3
	mov cl,01h
	int 21h

x3:
.exit
end