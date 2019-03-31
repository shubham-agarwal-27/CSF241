.model tiny
.486
.data
	fname1 db 'a.txt',0
	handle1 dw ?
	fname2 db 'b.txt',0
	handle2 dw ?
	inp db ?
	siz db ?
	equal db 'equal$'
	noteq db 'not equal$'
	a db ?
	b db ?
.code
.startup
	
	;Input a character from user
	mov ah,08h
	int 21h
	
	;Convert the character to a number
	sub al,48
	dec al
	mov inp,al

	;Open the file a.txt
	mov ah,3dh
	mov al,2
	lea dx,fname1
	int 21h
	mov handle1,ax

	;Open the file a.txt
	mov ah,3dh
	mov al,2
	lea dx,fname2
	int 21h
	mov handle2,ax

	;Give the input offset to a.txt
	mov ah,42h
	mov al,0
	mov bx,handle1
	mov cx,0
	movzx dx,inp
	int 21h

	;Give the input offset to b.txt
	mov ah,42h
	mov al,0
	mov bx,handle2
	mov cx,0
	movzx dx,inp
	int 21h

	;read character at position from a.txt
	mov ah,3fh
	mov bx,handle1
	mov cx,1
	lea dx,a
	int 21h

	;read character at position from a.txt
	mov ah,3fh
	mov bx,handle2
	mov cx,1
	lea dx,b
	int 21h

	mov al,a
	mov bl,b
	cmp al,bl
	jne x1
	
	lea dx,equal
	mov ah,9h
	int 21h
	jmp x2
x1:
	lea dx,noteq
	mov ah,9h
	int 21h
x2:
	;Close the file a.txt
	mov ah,3eh
	mov bx,handle1
	int 21h
	;Close the file b.txt
	mov ah,3eh
	mov bx,handle2
	int 21h
.exit
end