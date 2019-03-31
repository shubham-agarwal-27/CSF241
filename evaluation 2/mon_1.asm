.model tiny
.486
.data
	fname db 'mfn2.txt',0
	handle dw ?
	inp db ?
	siz db 55
	count db 0
.code
.startup
	;Open the file mfn2.txt
	mov ah,3dh
	mov al,2
	lea dx,fname
	int 21h
	mov handle,ax

	;Input a character from user
	mov ah,08h
	int 21h
	mov inp,al

x1:	;Replace character with the user input
	mov ah,40h
	mov bx,handle
	mov cx,1
	lea dx,inp
	int 21h

	;Move the file pointer to five places
	mov ah,42h
	mov al,1
	mov bx,handle
	mov cx,0
	mov dx,4
	int 21h

	;Increment the count of characters by 5
	mov bl,count
	add bl,5
	mov count,bl
	cmp bl,55
	jle x1

	;Close the file mfn2.txt
	mov ah,3eh
	mov bx,handle
	int 21h

.exit
end