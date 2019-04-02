.model tiny
.486
.data
	fname db 9 dup(?),0
	handle dw ?
	ask db 'Enter name of file in next line',0ah,0dh,'$'
	nline db 0dh,0ah,'$'
	disp db ?
	row db 0
	data db 20 dup(?)
	ent db ?
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al


	;Print the question on screen
	lea dx,ask
	mov ah,9h
	int 21h

	;take input of file name
	MOV CL, 9
	MOV AH, 01H
	LEA SI, fname
X3:	INT 21H
	MOV [SI], AL
	INC SI
	DEC CL
	JNZ X3

	;take enter input
	MOV AH, 01H
	LEA SI, ent
	INT 21H

	;set text display mode
	mov ah,0
	mov al,3
	int 10h

	;open the file name given as input
	mov ah,3dh
	mov al,0
	lea dx,fname
	int 21H
	mov handle,ax


	;Read froom the file
	mov ah,3fh
	mov bx,handle
	mov cx,20
	lea dx,data
	int 21h
	
	lea si,data
	;print the first twenty characters on the screen
x1:
	;set the cursor position
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	;Write the characters
	mov ah,09h
	mov al,[si]
	mov bh,0
	mov bl,00001010b
	mov cx,1
	int 10h

	;increment si pointer
	inc si

	;increment row
	mov dl,row
	inc dl
	mov row,dl
	cmp dl,20
	jne x1


	;blocking function
	mov ah,07h
x10:
	int 21h
	cmp al,'*'
	jnz x10


	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end
