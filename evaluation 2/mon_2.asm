.model tiny
.486
.data
	fname db 'mfn2.txt',0
	handle dw ?
	inp db ?
	siz db ?
	count db 0
	store db 60 dup('$')
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

	;input was a character , convert into number
	sub al,48
	mov inp,al

	;Count the number of characters to be read
	mov bl,56
	sub bl,al
	mov siz,bl 

	;Move the file pointer by the input places
	mov ah,42h
	mov al,0
	mov bx,handle
	mov cx,0
	movzx dx,inp
	int 21h

	;Read the file from the current file pointer and store it in buffer address
	mov ah,3fh
	mov bx,handle
	movzx cx,siz
	lea dx,store
	int 21h

	;Output the string from the buffer address
	lea dx,store
	mov ah,9h
	int 21h

	;Close the file mfn2.txt
	mov ah,3eh
	mov bx,handle
	int 21h
.exit
end