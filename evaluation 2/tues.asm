.model tiny
.486
.data
	fname db 'mfn2.txt',0
	handle dw ?
	inp db ?
	siz db ?
	count db 20
.code
.startup
	
	;Open the file mfn2.txt
	mov ah,3dh
	mov al,2
	lea dx,fname
	int 21h
	mov handle,ax

	;Input a character from user
	mov ah,01h
	int 21h
	mov inp,al

	;Move the file pointer to the EOF
	mov ah,42h
	mov al,2
	mov bx,handle
	mov cx,0
	mov dx,0
	int 21h

x1:
	;Append to the file at the current file pointer
	mov ah,40h
	mov bx,handle
	mov cx,1
	lea dx,inp
	int 21h

	;check if we appended 20 times or not
	mov dl,count
	dec dl
	mov count,dl
	cmp dl,0
	jne x1

	;Close the file mfn2.txt
	mov ah,3eh
	mov bx,handle
	int 21h
.exit
end